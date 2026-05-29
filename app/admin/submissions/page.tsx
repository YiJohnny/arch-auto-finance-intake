import Link from "next/link";
import { redirect } from "next/navigation";
import { signOut } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { SubmissionsTable, type IntakeSubmission, type DocumentLink } from "@/app/components/submissions-table";
import { createClient } from "@/utils/supabase/server";
import { ClipboardCheck, LayoutDashboard, WalletCards } from "lucide-react";

type AdminSubmissionsPageProps = {
  searchParams?: Promise<{
    error?: string;
    tab?: string;
  }>;
};

const TAB_CONFIG = [
  { key: "pending", label: "Pending", statuses: ["submitted", "in_review"] },
  { key: "approved", label: "Approved", statuses: ["approved"] },
  { key: "posted", label: "Posted", statuses: ["posted"] },
  { key: "rejected", label: "Rejected", statuses: ["rejected"] },
] as const;

type TabKey = (typeof TAB_CONFIG)[number]["key"];

export default async function AdminSubmissionsPage({ searchParams }: AdminSubmissionsPageProps) {
  const params = await searchParams;
  const rawTab = params?.tab ?? "pending";
  const tabConfig = TAB_CONFIG.find((t) => t.key === rawTab) ?? TAB_CONFIG[0];
  const tab = tabConfig.key as TabKey;

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
      "submission_id,submission_number,business_cluster,repair_context,direction,status,vehicle_id,unmatched_vehicle_vin,unmatched_vehicle_year,unmatched_vehicle_make,unmatched_vehicle_model,unmatched_vehicle_stock_number,transaction_date,amount,memo,ai_suggested_category,ai_suggested_vendor,accounting_category,rejection_reason,created_at,app_profiles:submitted_by(full_name,email),vehicles(vehicle_id,stock_number,vin,year,make,model),intake_documents(file_name,storage_path)",
    )
    .in("status", [...tabConfig.statuses])
    .order("created_at", { ascending: false })
    .limit(100)
    .returns<IntakeSubmission[]>();

  const documentLinksBySubmission: Record<string, DocumentLink[]> = {};

  if (submissions) {
    await Promise.all(
      submissions.map(async (submission) => {
        const links = await Promise.all(
          submission.intake_documents.map(async (doc) => {
            const { data } = await supabase.storage
              .from("intake-documents")
              .createSignedUrl(doc.storage_path, 60 * 10);
            return { file_name: doc.file_name, signed_url: data?.signedUrl ?? null };
          }),
        );
        documentLinksBySubmission[submission.submission_id] = links;
      }),
    );
  }

  return (
    <main className="shell">
      <div className="workspace">
        <header className="topbar">
          <BrandHeader
            title="Submission Review"
            subtitle="Approve, reject, and post employee finance submissions."
          />
          <nav className="topbar-nav" aria-label="Admin navigation">
            <Link href="/">
              <LayoutDashboard size={17} />
              Dashboard
            </Link>
            <Link className="active" href="/admin/submissions">
              <ClipboardCheck size={17} />
              Review Submissions
            </Link>
            <Link href="/admin/cash">
              <WalletCards size={17} />
              Store Cash
            </Link>
          </nav>
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

        {params?.error ? <p className="notice">{params.error}</p> : null}

        <div className="status-tabs">
          {TAB_CONFIG.map((t) => (
            <Link
              key={t.key}
              href={`/admin/submissions?tab=${t.key}`}
              className={tab === t.key ? "status-tab active" : "status-tab"}
            >
              {t.label}
            </Link>
          ))}
        </div>

        <section className="panel">
          {error ? (
            <p className="notice">{error.message}</p>
          ) : (
            <SubmissionsTable
              submissions={submissions ?? []}
              documentLinks={documentLinksBySubmission}
              tab={tab}
            />
          )}
        </section>
      </div>
    </main>
  );
}
