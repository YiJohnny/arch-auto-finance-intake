import { redirect } from "next/navigation";
import { updateRecoveredPassword } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { createClient } from "@/utils/supabase/server";

type ResetPasswordPageProps = {
  searchParams?: Promise<{
    error?: string;
  }>;
};

export default async function ResetPasswordPage({ searchParams }: ResetPasswordPageProps) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  const params = await searchParams;

  if (!user) {
    redirect("/login?error=Open%20the%20password%20reset%20link%20from%20your%20email%20first.");
  }

  return (
    <main className="shell auth-shell">
      <section className="auth-card compact">
        <BrandHeader title="Choose New Password" subtitle="Set a new password for your Arch Auto account." />

        {params?.error ? <p className="notice">{params.error}</p> : null}

        <form action={updateRecoveredPassword} className="panel auth-panel">
          <h2>Update Password</h2>
          <div className="field">
            <label htmlFor="new_password">New Password</label>
            <input id="new_password" name="password" type="password" autoComplete="new-password" minLength={8} required />
          </div>
          <div className="field">
            <label htmlFor="confirm_password">Confirm New Password</label>
            <input id="confirm_password" name="confirm_password" type="password" autoComplete="new-password" minLength={8} required />
          </div>
          <div className="actions">
            <button className="button" type="submit">
              Update Password
            </button>
          </div>
        </form>
      </section>
    </main>
  );
}
