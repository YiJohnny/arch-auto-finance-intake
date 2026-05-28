"use client";

import { useRouter } from "next/navigation";
import { useState, useTransition } from "react";
import {
  approveSubmission,
  deleteSubmission,
  postSubmission,
  rejectSubmission,
  batchApproveResult,
  batchRejectResult,
} from "@/app/admin/actions";

export type IntakeSubmission = {
  submission_id: string;
  submission_number: number;
  business_cluster: string;
  repair_context: string | null;
  direction: string;
  status: string;
  vehicle_id: number | null;
  unmatched_vehicle_vin: string | null;
  unmatched_vehicle_year: number | null;
  unmatched_vehicle_make: string | null;
  unmatched_vehicle_model: string | null;
  unmatched_vehicle_stock_number: string | null;
  transaction_date: string | null;
  amount: number | null;
  memo: string | null;
  ai_suggested_category: string | null;
  ai_suggested_vendor: string | null;
  accounting_category: string | null;
  rejection_reason: string | null;
  created_at: string;
  app_profiles: { full_name: string | null; email: string | null } | null;
  vehicles: {
    stock_number: string | null;
    vin: string | null;
    year: number | null;
    make: string | null;
    model: string | null;
  } | null;
  intake_documents: Array<{ file_name: string; storage_path: string }>;
};

export type DocumentLink = { file_name: string; signed_url: string | null };

type Props = {
  submissions: IntakeSubmission[];
  documentLinks: Record<string, DocumentLink[]>;
  tab: string;
};

function money(amount: number | null) {
  if (amount === null) return "—";
  return new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" }).format(amount);
}

function vehicleSummary(s: IntakeSubmission) {
  if (s.vehicles) {
    return [
      s.vehicles.stock_number ? `#${s.vehicles.stock_number}` : null,
      s.vehicles.year,
      s.vehicles.make,
      s.vehicles.model,
      s.vehicles.vin ? `VIN ${s.vehicles.vin}` : null,
    ]
      .filter(Boolean)
      .join(" ");
  }
  if (s.unmatched_vehicle_vin || s.unmatched_vehicle_model) {
    return [
      "Unmatched:",
      s.unmatched_vehicle_stock_number ? `#${s.unmatched_vehicle_stock_number}` : null,
      s.unmatched_vehicle_year,
      s.unmatched_vehicle_make,
      s.unmatched_vehicle_model,
      s.unmatched_vehicle_vin ? `VIN ${s.unmatched_vehicle_vin}` : null,
    ]
      .filter(Boolean)
      .join(" ");
  }
  return "—";
}

const vehicleExpenseCategories = [
  { value: "FUEL", label: "Fuel" },
  { value: "REPAIR", label: "Repair & Maintenance" },
  { value: "PARTS", label: "Parts" },
  { value: "TOWING", label: "Towing" },
  { value: "TRANSPORTATION", label: "Transportation" },
  { value: "CLEANING", label: "Cleaning" },
  { value: "DETAIL", label: "Detail" },
  { value: "INSPECTION", label: "Inspection" },
  { value: "REGISTRATION_FEE", label: "Registration Fee" },
  { value: "TITLE_FEE", label: "Title Fee" },
  { value: "OTHER_DIRECT_COST", label: "Other Direct Cost" },
];

const generalCategories = [
  { value: "RENT", label: "Rent" },
  { value: "INSURANCE", label: "Insurance" },
  { value: "LEGAL_ACCOUNTING", label: "Legal & Accounting" },
  { value: "OFFICE_SUPPLIES", label: "Office Supplies" },
  { value: "UTILITIES", label: "Utilities" },
  { value: "BANK_FEES", label: "Bank Fees" },
  { value: "DELIVERY_FREIGHT", label: "Delivery / Freight" },
  { value: "LAUNDRY_UNIFORMS", label: "Laundry & Uniforms" },
  { value: "OUTSIDE_SERVICES", label: "Outside Services" },
  { value: "SMALL_TOOLS_SUPPLIES", label: "Small Tools & Supplies" },
  { value: "TRAVEL", label: "Travel" },
  { value: "MEALS_ENTERTAINMENT", label: "Meals & Entertainment" },
  { value: "COMPENSATION", label: "Compensation" },
  { value: "EMPLOYEE_BENEFITS", label: "Employee Benefits" },
  { value: "WORKERS_COMPENSATION", label: "Workers Compensation" },
  { value: "ADVERTISING", label: "Advertising" },
  { value: "SALES_PROMOTION", label: "Sales Promotion" },
  { value: "FLOORPLAN_INTEREST", label: "Floorplan Interest" },
  { value: "BAD_DEBT", label: "Bad Debt" },
  { value: "REIMBURSEMENT", label: "Reimbursement" },
  { value: "OTHER_INCOME", label: "Other Income" },
  { value: "MISCELLANEOUS", label: "Miscellaneous" },
];

function categoryOptions(s: IntakeSubmission) {
  if (s.business_cluster !== "general" && s.direction === "expense") return vehicleExpenseCategories;
  if (s.business_cluster !== "general" && s.direction === "income") {
    return [{ value: "SALE_PROCEEDS", label: "Vehicle Income / Sale Proceeds" }];
  }
  return generalCategories;
}

function defaultCategory(s: IntakeSubmission) {
  const options = categoryOptions(s);
  if (s.accounting_category && options.some((option) => option.value === s.accounting_category)) {
    return s.accounting_category;
  }
  if (s.ai_suggested_category && options.some((option) => option.value === s.ai_suggested_category)) {
    return s.ai_suggested_category;
  }
  if (s.business_cluster !== "general" && s.direction === "income") return "SALE_PROCEEDS";
  return "";
}

export function SubmissionsTable({ submissions, documentLinks, tab }: Props) {
  const router = useRouter();
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [batchRejectReason, setBatchRejectReason] = useState("");
  const [showBatchRejectInput, setShowBatchRejectInput] = useState(false);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [isPending, startTransition] = useTransition();

  const canSelect = tab === "pending" || tab === "approved";
  const allSelected =
    submissions.length > 0 && submissions.every((s) => selectedIds.has(s.submission_id));

  function toggleAll() {
    setSelectedIds(allSelected ? new Set() : new Set(submissions.map((s) => s.submission_id)));
  }

  function toggleOne(id: string) {
    const next = new Set(selectedIds);
    next.has(id) ? next.delete(id) : next.add(id);
    setSelectedIds(next);
  }

  function handleBatchApprove() {
    setErrorMessage(null);
    startTransition(async () => {
      const result = await batchApproveResult(Array.from(selectedIds));
      if (result.error) {
        setErrorMessage(result.error);
      } else {
        setSelectedIds(new Set());
        router.refresh();
      }
    });
  }

  function handleBatchRejectClick() {
    if (!showBatchRejectInput) {
      setShowBatchRejectInput(true);
      return;
    }
    setErrorMessage(null);
    startTransition(async () => {
      const result = await batchRejectResult(Array.from(selectedIds), batchRejectReason);
      if (result.error) {
        setErrorMessage(result.error);
      } else {
        setSelectedIds(new Set());
        setShowBatchRejectInput(false);
        setBatchRejectReason("");
        router.refresh();
      }
    });
  }

  const colCount = canSelect ? 8 : 7;

  return (
    <div>
      {selectedIds.size > 0 && canSelect && (
        <div className="batch-toolbar">
          <span>{selectedIds.size} selected</span>
          {tab === "pending" && (
            <button className="button" disabled={isPending} onClick={handleBatchApprove}>
              Approve {selectedIds.size}
            </button>
          )}
          {showBatchRejectInput && (
            <input
              autoFocus
              placeholder="Rejection reason (required)"
              value={batchRejectReason}
              onChange={(e) => setBatchRejectReason(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && handleBatchRejectClick()}
            />
          )}
          <button className="button danger" disabled={isPending} onClick={handleBatchRejectClick}>
            {showBatchRejectInput ? "Confirm Reject" : `Reject ${selectedIds.size}`}
          </button>
          <button
            className="button secondary"
            onClick={() => {
              setSelectedIds(new Set());
              setShowBatchRejectInput(false);
              setBatchRejectReason("");
            }}
          >
            Clear
          </button>
        </div>
      )}

      {errorMessage && <p className="notice">{errorMessage}</p>}

      {submissions.length === 0 ? (
        <p className="muted">No submissions in this category.</p>
      ) : (
        <div className="submissions-table-wrapper">
          <table className="submissions-table">
            <thead>
              <tr>
                {canSelect && (
                  <th>
                    <input type="checkbox" checked={allSelected} onChange={toggleAll} />
                  </th>
                )}
                <th>#</th>
                <th>Date</th>
                <th>Type</th>
                <th>Amount</th>
                <th>Vehicle</th>
                <th>Submitted by</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              {submissions.map((s) => (
                <SubmissionRow
                  key={s.submission_id}
                  submission={s}
                  documentLinks={documentLinks[s.submission_id] ?? []}
                  isSelected={selectedIds.has(s.submission_id)}
                  isExpanded={expandedId === s.submission_id}
                  canSelect={canSelect}
                  colCount={colCount}
                  onToggle={() => toggleOne(s.submission_id)}
                  onExpand={() =>
                    setExpandedId(expandedId === s.submission_id ? null : s.submission_id)
                  }
                />
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

type RowProps = {
  submission: IntakeSubmission;
  documentLinks: DocumentLink[];
  isSelected: boolean;
  isExpanded: boolean;
  canSelect: boolean;
  colCount: number;
  onToggle: () => void;
  onExpand: () => void;
};

function SubmissionRow({
  submission: s,
  documentLinks,
  isSelected,
  isExpanded,
  canSelect,
  colCount,
  onToggle,
  onExpand,
}: RowProps) {
  return (
    <>
      <tr
        className={isExpanded ? "submission-row expanded" : "submission-row"}
        onClick={onExpand}
      >
        {canSelect && (
          <td
            onClick={(e) => {
              e.stopPropagation();
              onToggle();
            }}
          >
            <input type="checkbox" checked={isSelected} onChange={onToggle} />
          </td>
        )}
        <td>
          <strong>#{s.submission_number}</strong>
        </td>
        <td>{s.transaction_date ?? <span className="muted">—</span>}</td>
        <td>
          {s.business_cluster}
          {s.repair_context ? ` / ${s.repair_context}` : ""} / {s.direction}
        </td>
        <td>{money(s.amount)}</td>
        <td className="muted cell-truncate">{vehicleSummary(s)}</td>
        <td className="muted">
          {s.app_profiles?.full_name ?? s.app_profiles?.email ?? "Unknown"}
        </td>
        <td>
          <span className={`badge badge-${s.status}`}>{s.status}</span>
        </td>
      </tr>

      {isExpanded && (
        <tr className="expanded-detail">
          <td colSpan={colCount}>
            <div className="expanded-content">
              <div className="expanded-info">
                {s.memo && <p>{s.memo}</p>}
                {!s.memo && <p className="muted">No memo.</p>}

                {(s.ai_suggested_category || s.ai_suggested_vendor || s.accounting_category) && (
                  <div className="review-meta">
                    {s.ai_suggested_vendor && <span>AI vendor: {s.ai_suggested_vendor}</span>}
                    {s.ai_suggested_category && <span>AI category: {s.ai_suggested_category}</span>}
                    {s.accounting_category && <span>Final category: {s.accounting_category}</span>}
                  </div>
                )}

                {s.rejection_reason && (
                  <p className="notice" style={{ margin: 0 }}>
                    Rejected: {s.rejection_reason}
                  </p>
                )}

                {documentLinks.length > 0 && (
                  <div className="document-links">
                    {documentLinks.map((doc) =>
                      doc.signed_url ? (
                        <a
                          href={doc.signed_url}
                          key={doc.file_name}
                          rel="noreferrer"
                          target="_blank"
                          onClick={(e) => e.stopPropagation()}
                        >
                          View {doc.file_name}
                        </a>
                      ) : (
                        <span className="muted" key={doc.file_name}>
                          {doc.file_name}
                        </span>
                      ),
                    )}
                  </div>
                )}
              </div>

              {s.status !== "posted" && (
                <div className="expanded-actions">
                  {(s.status === "submitted" || s.status === "in_review") && (
                    <form action={approveSubmission} onClick={(e) => e.stopPropagation()}>
                      <input type="hidden" name="submission_id" value={s.submission_id} />
                      <button className="button" type="submit">
                        Approve
                      </button>
                    </form>
                  )}

                  {s.status === "approved" && (
                    <form action={postSubmission} className="post-form" onClick={(e) => e.stopPropagation()}>
                      <input type="hidden" name="submission_id" value={s.submission_id} />
                      <label htmlFor={`category-${s.submission_id}`}>Accounting category</label>
                      <select
                        id={`category-${s.submission_id}`}
                        name="accounting_category"
                        defaultValue={defaultCategory(s)}
                        required
                      >
                        <option value="" disabled>
                          Select category
                        </option>
                        {categoryOptions(s).map((category) => (
                          <option key={category.value} value={category.value}>
                            {category.label}
                          </option>
                        ))}
                      </select>
                      <button className="button" type="submit">
                        Post to Ledger
                      </button>
                    </form>
                  )}

                  {(s.status === "submitted" || s.status === "in_review" || s.status === "approved") && (
                    <form
                      action={rejectSubmission}
                      className="reject-inline"
                      onClick={(e) => e.stopPropagation()}
                    >
                      <input type="hidden" name="submission_id" value={s.submission_id} />
                      <textarea name="rejection_reason" placeholder="Rejection reason" required />
                      <button className="button danger" type="submit">
                        Reject
                      </button>
                    </form>
                  )}

                  <form
                    action={deleteSubmission}
                    onClick={(e) => {
                      e.stopPropagation();
                      if (!confirm(`Delete submission #${s.submission_number}? This cannot be undone.`)) {
                        e.preventDefault();
                      }
                    }}
                  >
                    <input type="hidden" name="submission_id" value={s.submission_id} />
                    <button className="button secondary" type="submit" style={{ fontSize: 12 }}>
                      Delete
                    </button>
                  </form>
                </div>
              )}
            </div>
          </td>
        </tr>
      )}
    </>
  );
}
