import Link from "next/link";
import { redirect } from "next/navigation";
import { signUp } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { createClient } from "@/utils/supabase/server";

type SignupPageProps = {
  searchParams?: Promise<{
    error?: string;
    notice?: string;
  }>;
};

export default async function SignupPage({ searchParams }: SignupPageProps) {
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
        <BrandHeader title="Create Account" subtitle="Create your Arch Auto staff login." />

        {params?.error ? <p className="notice">{params.error}</p> : null}
        {params?.notice ? <p className="success">{params.notice}</p> : null}

        <form action={signUp} className="panel auth-panel">
          <h2>Create Employee Account</h2>
          <p className="form-note">After confirmation, return to the sign-in page.</p>
          <div className="field">
            <label htmlFor="signup_name">Full Name</label>
            <input id="signup_name" name="full_name" type="text" autoComplete="name" required />
          </div>
          <div className="field">
            <label htmlFor="signup_email">Email</label>
            <input id="signup_email" name="email" type="email" autoComplete="email" required />
          </div>
          <div className="field">
            <label htmlFor="signup_password">Password</label>
            <input id="signup_password" name="password" type="password" autoComplete="new-password" required />
          </div>
          <div className="actions split-actions">
            <Link className="text-link" href="/login">
              Back to sign in
            </Link>
            <button className="button" type="submit">
              Create Account
            </button>
          </div>
        </form>
      </section>
    </main>
  );
}
