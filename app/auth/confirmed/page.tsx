import Link from "next/link";
import { BrandHeader } from "@/app/components/brand-header";

export default function ConfirmedPage() {
  return (
    <main className="shell auth-shell">
      <section className="auth-card compact">
        <BrandHeader title="Email Confirmed" subtitle="Your Arch Auto employee account is ready." />

        <div className="panel auth-panel confirmation-panel">
          <h2>Registration complete</h2>
          <p className="muted">
            Your email has been confirmed successfully. You can now sign in and start submitting finance records.
          </p>
          <div className="actions">
            <Link className="button button-link" href="/login">
              Go to Sign In
            </Link>
          </div>
        </div>
      </section>
    </main>
  );
}
