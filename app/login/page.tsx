import Link from "next/link";
import { redirect } from "next/navigation";
import { signIn } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { createClient } from "@/utils/supabase/server";

type LoginPageProps = {
  searchParams?: Promise<{
    error?: string;
    notice?: string;
  }>;
};

export default async function LoginPage({ searchParams }: LoginPageProps) {
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
        <BrandHeader subtitle="Sign in with your Arch Auto staff account." />

        {params?.error ? <p className="notice">{params.error}</p> : null}
        {params?.notice ? <p className="success">{params.notice}</p> : null}

        <form action={signIn} className="panel auth-panel">
          <h2>Sign In</h2>
          <div className="field">
            <label htmlFor="signin_email">Email</label>
            <input id="signin_email" name="email" type="email" autoComplete="email" required />
          </div>
          <div className="field">
            <label htmlFor="signin_password">Password</label>
            <input id="signin_password" name="password" type="password" autoComplete="current-password" required />
          </div>
          <div className="actions split-actions">
            <Link className="text-link" href="/signup">
              Create employee account
            </Link>
            <button className="button" type="submit">
              Sign In
            </button>
          </div>
        </form>
      </section>
    </main>
  );
}
