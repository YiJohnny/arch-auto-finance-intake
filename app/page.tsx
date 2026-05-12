import { createClient } from "@/utils/supabase/server";
import { signOut } from "@/app/auth/actions";
import { ensureAppProfile } from "@/app/auth/profile";
import { BrandHeader } from "@/app/components/brand-header";
import { IntakeWizard } from "@/app/components/intake-wizard";
import { redirect } from "next/navigation";
import Link from "next/link";

type HomePageProps = {
  searchParams?: Promise<{
    error?: string;
  }>;
};

export default async function Page({ searchParams }: HomePageProps) {
  const params = await searchParams;
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: loadedProfile } = await supabase
    .from("app_profiles")
    .select("full_name,email,role")
    .eq("profile_id", user.id)
    .maybeSingle();
  const profile = loadedProfile ?? (await ensureAppProfile(user));

  const { data: submissions, error } = await supabase
    .from("intake_submissions")
    .select("submission_number,business_cluster,repair_context,direction,status,amount,transaction_date,created_at")
    .order("created_at", { ascending: false })
    .limit(5);

  return (
    <main className="shell">
      <div className="workspace">
        <header className="topbar">
          <BrandHeader />
          <div className="profile-chip">
            <div>
              <strong>{profile?.full_name ?? user.email}</strong>
              <span>{profile?.role ?? "profile needed"}</span>
            </div>
            <form action={signOut}>
              <button className="link-button" type="submit">
                Sign Out
              </button>
            </form>
          </div>
        </header>

        {profile && ["manager", "accountant", "admin"].includes(profile.role) ? (
          <div className="admin-nav">
            <Link href="/admin/submissions">Review Submissions</Link>
          </div>
        ) : null}

        {params?.error ? <p className="notice">{params.error}</p> : null}

        <section className="grid">
          <div className="panel">
            <h2>New Submission</h2>
            <IntakeWizard />
          </div>

          <aside className="panel">
            <h2>Recent Submissions</h2>
            {error ? (
              <p className="notice">
                Supabase is connected, but this page needs the intake schema and signed-in access before records can load.
              </p>
            ) : submissions && submissions.length > 0 ? (
              <ul className="status-list">
                {submissions.map((submission) => (
                  <li className="status-item" key={submission.submission_number}>
                    <strong>#{submission.submission_number}</strong>
                    <span className="muted">
                      {submission.business_cluster} / {submission.direction} / {submission.status}
                    </span>
                  </li>
                ))}
              </ul>
            ) : (
              <p className="muted">No submissions yet.</p>
            )}
          </aside>
        </section>
      </div>
    </main>
  );
}
