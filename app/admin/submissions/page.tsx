import Link from "next/link";
import { redirect } from "next/navigation";
import { approveSubmission, postSubmission, rejectSubmission } from "@/app/admin/actions";
import { signOut } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { createClient } from "@/utils/supabase/server";

type AdminSubmissionsPageProps = {
  searchParams?: Promise<{
    error?: string;
  }>;
};

type IntakeSubmission = {
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
  rejection_reason: string | null;
  created_at: string;
  app_profiles: {
    full_name: string | null;
    email: string | null;
  } | null;
  vehicles: {
    stock_number: string | null;
    vin: string | null;
    year: number | null;
    make: string | null;
    model: string | null;
  } | null;
  intake_documents: Array<{
    file_name: string;
    storage_path: string;
  }>;
};

type DocumentLink = {
  file_name: string;
  signed_url: string | null;
};

function money(amount: number | null) {
  if (amount === null) {
    return "No amount";
  }

  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
  }).format(amount);
}

function vehicleSummary(submission: IntakeSubmission) {
  if (submission.vehicles) {
    return [
      submission.vehicles.stock_number ? `#${submission.vehicles.stock_number}` : null,
      submission.vehicles.year,
      submission.vehicles.make,
      submission.vehicles.model,
      submission.vehicles.vin ? `VIN ${submission.vehicles.vin}` : null,
    ]
      .filter(Boolean)
      .join(" ");
  }

  if (submission.unmatched_vehicle_vin || submission.unmatched_vehicle_model) {
    return [
      "Unmatched:",
      submission.unmatched_vehicle_stock_number ? `#${submission.unmatched_vehicle_stock_number}` : null,
      submission.unmatched_vehicle_year,
      submission.unmatched_vehicle_make,
      submission.unmatched_vehicle_model,
      submission.unmatched_vehicle_vin ? `VIN ${submission.unmatched_vehicle_vin}` : null,
    ]
      .filter(Boolean)
      .join(" ");
  }

  return "No vehicle";
}

export default async function AdminSubmissionsPage({ searchParams }: AdminSubmissionsPageProps) {
  const params = await searchParams;
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: profile } = await supabase
    .from("app_profiles")
    .select("full_name,email,role")
    .eq("profile_id", user.id)
    .maybeSingle();

  if (!profile || !["manager", "accountant", "admin"].includes(profile.role)) {
    redirect("/");
  }

  const { data: submissions, error } = await supabase
    .from("intake_submissions")
    .select(
      "submission_id,submission_number,business_cluster,repair_context,direction,status,vehicle_id,unmatched_vehicle_vin,unmatched_vehicle_year,unmatched_vehicle_make,unmatched_vehicle_model,unmatched_vehicle_stock_number,transaction_date,amount,memo,rejection_reason,created_at,app_profiles:submitted_by(full_name,email),vehicles(vehicle_id,stock_number,vin,year,make,model),intake_documents(file_name,storage_path)",
    )
    .in("status", ["submitted", "approved", "rejected"])
    .order("created_at", { ascending: false })
    .limit(50)
    .returns<IntakeSubmission[]>();

  const documentLinksBySubmission = new Map<string, DocumentLink[]>();

  if (submissions) {
    await Promise.all(
      submissions.map(async (submission) => {
        const links = await Promise.all(
          submission.intake_documents.map(async (document) => {
            const { data } = await supabase.storage.from("intake-documents").createSignedUrl(document.storage_path, 60 * 10);

            return {
              file_name: document.file_name,
              signed_url: data?.signedUrl ?? null,
            };
          }),
        );

        documentLinksBySubmission.set(submission.submission_id, links);
      }),
    );
  }

  return (
    <main className="shell">
      <div className="workspace">
        <header className="topbar">
          <BrandHeader title="Submission Review" subtitle="Approve, reject, and post employee finance submissions." />
          <div className="profile-chip">
            <div>
              <strong>{profile.full_name ?? profile.email ?? user.email}</strong>
              <span>{profile.role}</span>
            </div>
            <form action={signOut}>
              <button className="link-button" type="submit">
                Sign Out
              </button>
            </form>
          </div>
        </header>

        <div className="admin-nav">
          <Link href="/">New Submission</Link>
        </div>

        {params?.error ? <p className="notice">{params.error}</p> : null}

        <section className="panel">
          <h2>Review Queue</h2>
          {error ? <p className="notice">{error.message}</p> : null}
          {!error && (!submissions || submissions.length === 0) ? <p className="muted">No submissions need review.</p> : null}

          {submissions && submissions.length > 0 ? (
            <div className="review-list">
              {submissions.map((submission) => (
                <article className="review-item" key={submission.submission_id}>
                  <div className="review-main">
                    <div>
                      <strong>#{submission.submission_number}</strong>
                      <span className="badge">{submission.status}</span>
                    </div>
                    <p>
                      {submission.business_cluster}
                      {submission.repair_context ? ` / ${submission.repair_context}` : ""} / {submission.direction}
                    </p>
                    <p>{money(submission.amount)} {submission.transaction_date ? `on ${submission.transaction_date}` : ""}</p>
                    <p className="muted">Submitted by {submission.app_profiles?.full_name ?? submission.app_profiles?.email ?? "Unknown"}</p>
                    <p className="muted">{vehicleSummary(submission)}</p>
                    {submission.memo ? <p>{submission.memo}</p> : null}
                    {documentLinksBySubmission.get(submission.submission_id)?.length ? (
                      <div className="document-links">
                        {documentLinksBySubmission.get(submission.submission_id)?.map((document) =>
                          document.signed_url ? (
                            <a href={document.signed_url} key={document.file_name} rel="noreferrer" target="_blank">
                              View {document.file_name}
                            </a>
                          ) : (
                            <span className="muted" key={document.file_name}>
                              {document.file_name}
                            </span>
                          ),
                        )}
                      </div>
                    ) : null}
                    {submission.rejection_reason ? <p className="notice">{submission.rejection_reason}</p> : null}
                  </div>

                  <div className="review-actions">
                    {submission.status === "submitted" ? (
                      <form action={approveSubmission}>
                        <input type="hidden" name="submission_id" value={submission.submission_id} />
                        <button className="button" type="submit">
                          Approve
                        </button>
                      </form>
                    ) : null}

                    {submission.status === "approved" ? (
                      <form action={postSubmission}>
                        <input type="hidden" name="submission_id" value={submission.submission_id} />
                        <button className="button" type="submit">
                          Post to Ledger
                        </button>
                      </form>
                    ) : null}

                    {submission.status !== "rejected" ? (
                      <form action={rejectSubmission} className="reject-form">
                        <input type="hidden" name="submission_id" value={submission.submission_id} />
                        <textarea name="rejection_reason" placeholder="Rejection reason" required />
                        <button className="button danger" type="submit">
                          Reject
                        </button>
                      </form>
                    ) : null}
                  </div>
                </article>
              ))}
            </div>
          ) : null}
        </section>
      </div>
    </main>
  );
}
