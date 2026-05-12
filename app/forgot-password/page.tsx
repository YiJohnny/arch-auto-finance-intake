import Link from "next/link";
import { redirect } from "next/navigation";
import { requestPasswordReset } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { createClient } from "@/utils/supabase/server";

type ForgotPasswordPageProps = {
  searchParams?: Promise<{
    error?: string;
    notice?: string;
  }>;
};

export default async function ForgotPasswordPage({ searchParams }: ForgotPasswordPageProps) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  const params = await searchParams;

  if (user) {
    redirect("/");
  }

  return (
    <main className="shell auth-shell">
      <section className="auth-card compact">
        <BrandHeader title="Reset Password" subtitle="We will email a secure password reset link." />

        {params?.error ? <p className="notice">{params.error}</p> : null}
        {params?.notice ? <p className="success">{params.notice}</p> : null}

        <form action={requestPasswordReset} className="panel auth-panel">
          <h2>Forgot Password</h2>
          <div className="field">
            <label htmlFor="reset_email">Email</label>
            <input id="reset_email" name="email" type="email" autoComplete="email" required />
          </div>
          <div className="actions split-actions">
            <Link className="text-link" href="/login">
              Back to sign in
            </Link>
            <button className="button" type="submit">
              Send Reset Link
            </button>
          </div>
        </form>
      </section>
    </main>
  );
}
