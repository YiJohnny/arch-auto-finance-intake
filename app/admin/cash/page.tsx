import Link from "next/link";
import { redirect } from "next/navigation";
import { createCashLedgerEntry } from "@/app/admin/actions";
import { signOut } from "@/app/auth/actions";
import { BrandHeader } from "@/app/components/brand-header";
import { createClient } from "@/utils/supabase/server";
import { ClipboardCheck, LayoutDashboard, WalletCards } from "lucide-react";

type CashPageProps = {
  searchParams?: Promise<{
    error?: string;
  }>;
};

type CashEntry = {
  cash_entry_id: number;
  entry_date: string;
  direction: "in" | "out";
  amount: number;
  category: string;
  description: string | null;
  source_system: string;
  source_record_id: string | null;
  created_at: string;
};

function money(amount: number) {
  return new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" }).format(amount);
}

function todayString() {
  return new Date().toISOString().slice(0, 10);
}

export default async function AdminCashPage({ searchParams }: CashPageProps) {
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

  const { data: balanceRows } = await supabase
    .from("store_cash_balance")
    .select("cash_account,balance")
    .eq("cash_account", "store_cash")
    .maybeSingle<{ cash_account: string; balance: number }>();

  const { data: entries, error: entriesError } = await supabase
    .from("cash_account_ledger")
    .select("cash_entry_id,entry_date,direction,amount,category,description,source_system,source_record_id,created_at")
    .order("entry_date", { ascending: false })
    .order("created_at", { ascending: false })
    .limit(100)
    .returns<CashEntry[]>();

  const balance = balanceRows?.balance ?? 0;

  return (
    <main className="shell">
      <div className="workspace">
        <header className="topbar">
          <BrandHeader
            title="Store Cash"
            subtitle="Track store cash movements separately from income and expense ledgers."
          />
          <nav className="topbar-nav" aria-label="Admin navigation">
            <Link href="/">
              <LayoutDashboard size={17} />
              Dashboard
            </Link>
            <Link href="/admin/submissions">
              <ClipboardCheck size={17} />
              Review Submissions
            </Link>
            <Link className="active" href="/admin/cash">
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
        {entriesError ? <p className="notice">{entriesError.message}</p> : null}

        <section className="cash-grid">
          <div className="panel">
            <h2>Current Balance</h2>
            <p className="cash-balance">{money(balance)}</p>
            <p className="muted">Calculated from all store cash in/out entries.</p>
          </div>

          <form action={createCashLedgerEntry} className="panel cash-entry-form">
            <h2>Manual Cash Entry</h2>
            <div className="form-grid">
              <div className="field">
                <label htmlFor="entry_date">Entry Date</label>
                <input id="entry_date" name="entry_date" type="date" defaultValue={todayString()} required />
              </div>
              <div className="field">
                <label htmlFor="direction">Direction</label>
                <select id="direction" name="direction" defaultValue="in" required>
                  <option value="in">Cash In</option>
                  <option value="out">Cash Out</option>
                </select>
              </div>
              <div className="field">
                <label htmlFor="amount">Amount</label>
                <input id="amount" name="amount" type="number" min="0.01" step="0.01" required />
              </div>
              <div className="field">
                <label htmlFor="category">Cash Category</label>
                <select id="category" name="category" defaultValue="CASH_TRANSFER_IN" required>
                  <option value="CASH_TRANSFER_IN">Cash Transfer In</option>
                  <option value="CASH_TRANSFER_OUT">Cash Transfer Out</option>
                  <option value="REIMBURSEMENT_PAYMENT">Employee Reimbursement Payment</option>
                  <option value="INCOME_DEPOSIT">Cash Income Deposit</option>
                  <option value="CASH_ADJUSTMENT">Cash Adjustment</option>
                </select>
              </div>
              <div className="field full">
                <label htmlFor="description">Description</label>
                <textarea
                  id="description"
                  name="description"
                  placeholder="Example: Bank withdrawal to store cash"
                  required
                />
              </div>
            </div>
            <div className="actions">
              <button className="button" type="submit">
                Add Cash Entry
              </button>
            </div>
          </form>
        </section>

        <section className="panel">
          <h2>Recent Cash Activity</h2>
          {!entries || entries.length === 0 ? (
            <p className="muted">No cash entries yet.</p>
          ) : (
            <div className="submissions-table-wrapper">
              <table className="submissions-table">
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Direction</th>
                    <th>Amount</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Source</th>
                  </tr>
                </thead>
                <tbody>
                  {entries.map((entry) => (
                    <tr key={entry.cash_entry_id}>
                      <td>{entry.entry_date}</td>
                      <td>
                        <span className={`badge badge-cash-${entry.direction}`}>{entry.direction}</span>
                      </td>
                      <td>{money(entry.amount)}</td>
                      <td>{entry.category}</td>
                      <td>{entry.description ?? "—"}</td>
                      <td className="muted">
                        {entry.source_system}
                        {entry.source_record_id ? ` / ${entry.source_record_id}` : ""}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}
