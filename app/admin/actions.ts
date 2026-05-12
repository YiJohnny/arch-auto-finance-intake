"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { createClient } from "@/utils/supabase/server";

type ReviewerProfile = {
  profile_id: string;
  role: string;
};

function cleanString(value: FormDataEntryValue | null) {
  return String(value ?? "").trim();
}

function adminRedirectWithError(message: string): never {
  redirect(`/admin/submissions?error=${encodeURIComponent(message)}`);
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

  if (!submissionId) {
    adminRedirectWithError("Missing submission ID.");
  }

  const { data: submission, error: loadError } = await supabase
    .from("intake_submissions")
    .select(
      "submission_id,submission_number,business_cluster,repair_context,direction,status,vehicle_id,transaction_date,amount,memo,counterparty_name,vehicle_cost_ledger_entry_id,general_ledger_entry_id",
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

  if (submission.business_cluster !== "general") {
    if (!submission.vehicle_id) {
      adminRedirectWithError("Match this submission to a vehicle before posting.");
    }

    const category = submission.business_cluster === "repair" ? "REPAIR" : "OTHER_DIRECT_COST";
    const { data: ledgerEntry, error: ledgerError } = await supabase
      .from("vehicle_cost_ledger")
      .insert({
        vehicle_id: submission.vehicle_id,
        entry_date: submission.transaction_date,
        entry_type: submission.direction === "income" ? "SALE" : "DIRECT_COST",
        category: submission.direction === "income" ? "SALE_PROCEEDS" : category,
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

    const { error: updateError } = await supabase
      .from("intake_submissions")
      .update({
        status: "posted",
        posted_at: new Date().toISOString(),
        vehicle_cost_ledger_entry_id: ledgerEntry.ledger_entry_id,
      })
      .eq("submission_id", submission.submission_id);

    if (updateError) {
      adminRedirectWithError(updateError.message);
    }
  } else {
    const { data: generalEntry, error: generalError } = await supabase
      .from("general_ledger_entries")
      .insert({
        entry_date: submission.transaction_date,
        business_cluster: submission.business_cluster,
        direction: submission.direction,
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

    const { error: updateError } = await supabase
      .from("intake_submissions")
      .update({
        status: "posted",
        posted_at: new Date().toISOString(),
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
