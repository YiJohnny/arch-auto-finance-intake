"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { createClient } from "@/utils/supabase/server";

type ReviewerProfile = {
  profile_id: string;
  role: string;
};

const vehicleExpenseCategories = new Set([
  "AUCTION_FEE",
  "BUYER_FEE",
  "TRANSPORTATION",
  "TOWING",
  "FUEL",
  "TITLE_FEE",
  "REGISTRATION_FEE",
  "INSPECTION",
  "SMOG",
  "REPAIR",
  "PARTS",
  "DETAIL",
  "CLEANING",
  "PHOTOGRAPHY",
  "KEY_REPLACEMENT",
  "WARRANTY_REPAIR",
  "OTHER_DIRECT_COST",
]);

const generalAccountingCategories = new Set([
  "RENT",
  "INSURANCE",
  "LEGAL_ACCOUNTING",
  "OFFICE_SUPPLIES",
  "UTILITIES",
  "BANK_FEES",
  "DELIVERY_FREIGHT",
  "LAUNDRY_UNIFORMS",
  "OUTSIDE_SERVICES",
  "SMALL_TOOLS_SUPPLIES",
  "TRAVEL",
  "MEALS_ENTERTAINMENT",
  "COMPENSATION",
  "EMPLOYEE_BENEFITS",
  "WORKERS_COMPENSATION",
  "ADVERTISING",
  "SALES_PROMOTION",
  "FLOORPLAN_INTEREST",
  "BAD_DEBT",
  "REIMBURSEMENT",
  "OTHER_INCOME",
  "MISCELLANEOUS",
]);

function cleanString(value: FormDataEntryValue | null) {
  return String(value ?? "").trim();
}

function adminRedirectWithError(message: string): never {
  redirect(`/admin/submissions?error=${encodeURIComponent(message)}`);
}

function cashRedirectWithError(message: string): never {
  redirect(`/admin/cash?error=${encodeURIComponent(message)}`);
}

function vehicleBusinessUseForSubmission(businessCluster: string, repairContext: string | null) {
  if (businessCluster === "rental") return "rental";
  if (businessCluster === "retail") return "retail";
  if (businessCluster === "repair" && repairContext === "rental_vehicle") return "rental";
  if (businessCluster === "repair" && repairContext === "retail_inventory") return "retail";
  if (businessCluster === "repair") return "repair_shop";
  return null;
}

async function requireReviewer(): Promise<ReviewerProfile> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: profile } = await supabase
    .from("app_profiles")
    .select("profile_id,role")
    .eq("profile_id", user.id)
    .maybeSingle<ReviewerProfile>();

  if (!profile || !["manager", "accountant", "admin"].includes(profile.role)) {
    redirect("/");
  }

  return profile;
}

async function postStoreCashMovement({
  supabase,
  reviewerId,
  entryDate,
  direction,
  amount,
  category,
  description,
  sourceSystem = "MANUAL",
  sourceRecordId,
}: {
  supabase: Awaited<ReturnType<typeof createClient>>;
  reviewerId: string;
  entryDate: string;
  direction: "in" | "out";
  amount: number;
  category: string;
  description: string;
  sourceSystem?: string;
  sourceRecordId?: string;
}) {
  return supabase.from("cash_account_ledger").upsert(
    {
      entry_date: entryDate,
      cash_account: "store_cash",
      direction,
      amount,
      category,
      description,
      source_system: sourceSystem,
      source_record_id: sourceRecordId ?? null,
      created_by: reviewerId,
    },
    { onConflict: "source_system,source_record_id" },
  );
}

export async function approveSubmission(formData: FormData) {
  const reviewer = await requireReviewer();
  const supabase = await createClient();
  const submissionId = cleanString(formData.get("submission_id"));

  if (!submissionId) {
    adminRedirectWithError("Missing submission ID.");
  }

  const { error } = await supabase
    .from("intake_submissions")
    .update({
      status: "approved",
      reviewed_by: reviewer.profile_id,
      reviewed_at: new Date().toISOString(),
      rejection_reason: null,
    })
    .eq("submission_id", submissionId)
    .in("status", ["submitted", "in_review"]);

  if (error) {
    adminRedirectWithError(error.message);
  }

  revalidatePath("/admin/submissions");
  redirect("/admin/submissions");
}

export async function rejectSubmission(formData: FormData) {
  const reviewer = await requireReviewer();
  const supabase = await createClient();
  const submissionId = cleanString(formData.get("submission_id"));
  const rejectionReason = cleanString(formData.get("rejection_reason"));

  if (!submissionId) {
    adminRedirectWithError("Missing submission ID.");
  }

  if (!rejectionReason) {
    adminRedirectWithError("Rejection reason is required.");
  }

  const { error } = await supabase
    .from("intake_submissions")
    .update({
      status: "rejected",
      rejection_reason: rejectionReason,
      reviewed_by: reviewer.profile_id,
      reviewed_at: new Date().toISOString(),
    })
    .eq("submission_id", submissionId)
    .in("status", ["submitted", "in_review", "approved"]);

  if (error) {
    adminRedirectWithError(error.message);
  }

  revalidatePath("/admin/submissions");
  redirect("/admin/submissions");
}

export async function postSubmission(formData: FormData) {
  const reviewer = await requireReviewer();
  const supabase = await createClient();
  const submissionId = cleanString(formData.get("submission_id"));
  const accountingCategory = cleanString(formData.get("accounting_category"));

  if (!submissionId) {
    adminRedirectWithError("Missing submission ID.");
  }

  const { data: submission, error: loadError } = await supabase
    .from("intake_submissions")
    .select(
      "submission_id,submission_number,business_cluster,repair_context,direction,status,vehicle_id,unmatched_vehicle_vin,unmatched_vehicle_year,unmatched_vehicle_make,unmatched_vehicle_model,unmatched_vehicle_stock_number,transaction_date,amount,payment_method,memo,counterparty_name,vehicle_cost_ledger_entry_id,general_ledger_entry_id",
    )
    .eq("submission_id", submissionId)
    .maybeSingle();

  if (loadError || !submission) {
    adminRedirectWithError(loadError?.message ?? "Submission not found.");
  }

  if (submission.status !== "approved") {
    adminRedirectWithError("Only approved submissions can be posted.");
  }

  if (!submission.amount || !submission.transaction_date) {
    adminRedirectWithError("Amount and transaction date are required before posting.");
  }

  if (submission.vehicle_cost_ledger_entry_id || submission.general_ledger_entry_id) {
    adminRedirectWithError("This submission has already been posted.");
  }

  if (!accountingCategory) {
    adminRedirectWithError("Choose an accounting category before posting.");
  }

  // Resolve vehicle_id from unmatched data if the intake flow didn't link one
  let resolvedVehicleId: number | null = submission.vehicle_id;

  if (resolvedVehicleId === null && submission.business_cluster !== "general" && submission.unmatched_vehicle_vin) {
    const { data: existing } = await supabase
      .from("vehicles")
      .select("vehicle_id")
      .eq("vin", submission.unmatched_vehicle_vin)
      .maybeSingle();

    if (existing) {
      resolvedVehicleId = existing.vehicle_id;
    } else if (
      submission.unmatched_vehicle_vin.length >= 11 &&
      submission.unmatched_vehicle_vin.length <= 17 &&
      submission.unmatched_vehicle_make &&
      submission.unmatched_vehicle_model
    ) {
      const stockNumber =
        submission.unmatched_vehicle_stock_number ||
        `MAN-${submission.unmatched_vehicle_vin.slice(-8).toUpperCase()}`;

      const { data: created, error: vehicleError } = await supabase
        .from("vehicles")
        .insert({
          vin: submission.unmatched_vehicle_vin,
          stock_number: stockNumber,
          year: submission.unmatched_vehicle_year ?? null,
          make: submission.unmatched_vehicle_make,
          model: submission.unmatched_vehicle_model,
          purchase_date: new Date().toISOString().split("T")[0],
          status: "IN_INVENTORY",
          business_use: vehicleBusinessUseForSubmission(submission.business_cluster, submission.repair_context),
        })
        .select("vehicle_id")
        .single();

      if (vehicleError) adminRedirectWithError(`Could not create vehicle: ${vehicleError.message}`);
      if (created) resolvedVehicleId = created.vehicle_id;
    }

    if (resolvedVehicleId) {
      await supabase
        .from("intake_submissions")
        .update({ vehicle_id: resolvedVehicleId })
        .eq("submission_id", submissionId);
    }
  }

  if (submission.business_cluster !== "general") {
    if (!resolvedVehicleId) {
      const vin = submission.unmatched_vehicle_vin ?? "(none)";
      adminRedirectWithError(
        `No vehicle linked to this submission (stored VIN: ${vin}). ` +
        `Approve/posting can create the vehicle only when VIN, Make, and Model are present. ` +
        `Ask the employee for missing vehicle details or link this submission to an existing vehicle before posting.`
      );
    }

    const ledgerCategory =
      submission.direction === "income" ? "SALE_PROCEEDS" : accountingCategory;

    if (submission.direction === "expense" && !vehicleExpenseCategories.has(ledgerCategory)) {
      adminRedirectWithError("Choose a valid vehicle ledger category before posting.");
    }

    if (submission.direction === "income" && ledgerCategory !== "SALE_PROCEEDS") {
      adminRedirectWithError("Vehicle income must post as SALE_PROCEEDS.");
    }

    const { data: ledgerEntry, error: ledgerError } = await supabase
      .from("vehicle_cost_ledger")
      .insert({
        vehicle_id: resolvedVehicleId,
        entry_date: submission.transaction_date,
        entry_type: submission.direction === "income" ? "SALE" : "DIRECT_COST",
        category: ledgerCategory,
        amount: submission.amount,
        description: submission.memo ?? `Intake submission #${submission.submission_number}`,
        vendor_name: submission.counterparty_name,
        source_system: "INTAKE",
        source_record_id: submission.submission_id,
      })
      .select("ledger_entry_id")
      .single();

    if (ledgerError || !ledgerEntry) {
      adminRedirectWithError(ledgerError?.message ?? "Could not post vehicle ledger entry.");
    }

    if (submission.payment_method === "store_cash") {
      const { error: cashError } = await postStoreCashMovement({
        supabase,
        reviewerId: reviewer.profile_id,
        entryDate: submission.transaction_date,
        direction: submission.direction === "income" ? "in" : "out",
        amount: submission.amount,
        category: submission.direction === "income" ? "INCOME_DEPOSIT" : "EXPENSE_PAYMENT",
        description: submission.memo ?? `Store cash for intake submission #${submission.submission_number}`,
        sourceSystem: "INTAKE",
        sourceRecordId: submission.submission_id,
      });

      if (cashError) {
        adminRedirectWithError(cashError.message);
      }
    }

    const { error: updateError } = await supabase
      .from("intake_submissions")
      .update({
        status: "posted",
        posted_at: new Date().toISOString(),
        accounting_category: ledgerCategory,
        vehicle_cost_ledger_entry_id: ledgerEntry.ledger_entry_id,
      })
      .eq("submission_id", submission.submission_id);

    if (updateError) {
      adminRedirectWithError(updateError.message);
    }
  } else {
    if (!generalAccountingCategories.has(accountingCategory)) {
      adminRedirectWithError("Choose a valid general ledger category before posting.");
    }

    const { data: generalEntry, error: generalError } = await supabase
      .from("general_ledger_entries")
      .insert({
        entry_date: submission.transaction_date,
        business_cluster: submission.business_cluster,
        direction: submission.direction,
        accounting_category: accountingCategory,
        amount: submission.amount,
        description: submission.memo ?? `Intake submission #${submission.submission_number}`,
        counterparty_name: submission.counterparty_name,
        source_system: "INTAKE",
        source_record_id: submission.submission_id,
        posted_by: reviewer.profile_id,
      })
      .select("general_ledger_entry_id")
      .single();

    if (generalError || !generalEntry) {
      adminRedirectWithError(generalError?.message ?? "Could not post general ledger entry.");
    }

    if (submission.payment_method === "store_cash") {
      const { error: cashError } = await postStoreCashMovement({
        supabase,
        reviewerId: reviewer.profile_id,
        entryDate: submission.transaction_date,
        direction: submission.direction === "income" ? "in" : "out",
        amount: submission.amount,
        category: submission.direction === "income" ? "INCOME_DEPOSIT" : "EXPENSE_PAYMENT",
        description: submission.memo ?? `Store cash for intake submission #${submission.submission_number}`,
        sourceSystem: "INTAKE",
        sourceRecordId: submission.submission_id,
      });

      if (cashError) {
        adminRedirectWithError(cashError.message);
      }
    }

    const { error: updateError } = await supabase
      .from("intake_submissions")
      .update({
        status: "posted",
        posted_at: new Date().toISOString(),
        accounting_category: accountingCategory,
        general_ledger_entry_id: generalEntry.general_ledger_entry_id,
      })
      .eq("submission_id", submission.submission_id);

    if (updateError) {
      adminRedirectWithError(updateError.message);
    }
  }

  revalidatePath("/admin/submissions");
  revalidatePath("/");
  redirect("/admin/submissions");
}

export async function createCashLedgerEntry(formData: FormData) {
  const reviewer = await requireReviewer();
  const supabase = await createClient();
  const entryDate = cleanString(formData.get("entry_date"));
  const direction = cleanString(formData.get("direction"));
  const amountText = cleanString(formData.get("amount"));
  const category = cleanString(formData.get("category"));
  const description = cleanString(formData.get("description"));

  const allowedDirections = new Set(["in", "out"]);
  const allowedCategories = new Set([
    "CASH_TRANSFER_IN",
    "CASH_TRANSFER_OUT",
    "REIMBURSEMENT_PAYMENT",
    "INCOME_DEPOSIT",
    "CASH_ADJUSTMENT",
  ]);
  const amount = amountText ? Number(amountText) : null;

  if (!entryDate) {
    cashRedirectWithError("Entry date is required.");
  }

  if (!allowedDirections.has(direction)) {
    cashRedirectWithError("Choose cash in or cash out.");
  }

  if (!amount || !Number.isFinite(amount) || amount <= 0) {
    cashRedirectWithError("Enter a valid positive amount.");
  }

  if (!allowedCategories.has(category)) {
    cashRedirectWithError("Choose a valid cash category.");
  }

  if (!description) {
    cashRedirectWithError("Description is required.");
  }

  const { error } = await postStoreCashMovement({
    supabase,
    reviewerId: reviewer.profile_id,
    entryDate,
    direction: direction as "in" | "out",
    amount,
    category,
    description,
    sourceSystem: "MANUAL",
    sourceRecordId: crypto.randomUUID(),
  });

  if (error) {
    cashRedirectWithError(error.message);
  }

  revalidatePath("/admin/cash");
  redirect("/admin/cash");
}

export async function deleteSubmission(formData: FormData) {
  await requireReviewer();
  const supabase = await createClient();
  const submissionId = cleanString(formData.get("submission_id"));

  if (!submissionId) {
    adminRedirectWithError("Missing submission ID.");
  }

  const { error } = await supabase
    .from("intake_submissions")
    .delete()
    .eq("submission_id", submissionId)
    .in("status", ["draft", "submitted", "in_review", "approved", "rejected"]);

  if (error) {
    adminRedirectWithError(error.message);
  }

  revalidatePath("/admin/submissions");
  redirect("/admin/submissions");
}

export async function linkVehicleToSubmission(submissionId: string, vehicleId: number): Promise<{ error?: string }> {
  await requireReviewer();
  const supabase = await createClient();

  const { error } = await supabase
    .from("intake_submissions")
    .update({ vehicle_id: vehicleId })
    .eq("submission_id", submissionId);

  if (error) return { error: error.message };
  revalidatePath("/admin/submissions");
  return {};
}

export async function batchApproveResult(submissionIds: string[]): Promise<{ error?: string }> {
  const reviewer = await requireReviewer();
  const supabase = await createClient();

  if (!submissionIds.length) {
    return { error: "No submissions selected." };
  }

  const { error } = await supabase
    .from("intake_submissions")
    .update({
      status: "approved",
      reviewed_by: reviewer.profile_id,
      reviewed_at: new Date().toISOString(),
      rejection_reason: null,
    })
    .in("submission_id", submissionIds)
    .in("status", ["submitted", "in_review"]);

  if (error) return { error: error.message };
  revalidatePath("/admin/submissions");
  return {};
}

export async function batchRejectResult(submissionIds: string[], reason: string): Promise<{ error?: string }> {
  const reviewer = await requireReviewer();
  const supabase = await createClient();

  if (!submissionIds.length) {
    return { error: "No submissions selected." };
  }

  if (!reason.trim()) {
    return { error: "Rejection reason is required." };
  }

  const { error } = await supabase
    .from("intake_submissions")
    .update({
      status: "rejected",
      rejection_reason: reason.trim(),
      reviewed_by: reviewer.profile_id,
      reviewed_at: new Date().toISOString(),
    })
    .in("submission_id", submissionIds)
    .in("status", ["submitted", "in_review", "approved"]);

  if (error) return { error: error.message };
  revalidatePath("/admin/submissions");
  return {};
}
