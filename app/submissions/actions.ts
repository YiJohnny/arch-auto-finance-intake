"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { createClient } from "@/utils/supabase/server";

const allowedClusters = new Set(["repair", "rental", "retail", "general"]);
const allowedRepairContexts = new Set(["rental_vehicle", "retail_inventory", "walk_in", "shop_general"]);
const allowedDirections = new Set(["income", "expense"]);

function cleanString(value: FormDataEntryValue | null) {
  return String(value ?? "").trim();
}

function redirectWithError(message: string): never {
  redirect(`/?error=${encodeURIComponent(message)}`);
}

export async function saveDraftSubmission(formData: FormData) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: profile } = await supabase
    .from("app_profiles")
    .select("profile_id")
    .eq("profile_id", user.id)
    .maybeSingle();

  if (!profile) {
    redirectWithError("Complete your profile before saving a submission.");
  }

  const businessCluster = cleanString(formData.get("business_cluster"));
  const rawRepairContext = cleanString(formData.get("repair_context"));
  const direction = cleanString(formData.get("direction"));
  const transactionDate = cleanString(formData.get("transaction_date"));
  const amountText = cleanString(formData.get("amount"));
  const paymentMethod = cleanString(formData.get("payment_method"));
  const memo = cleanString(formData.get("memo"));
  const intent = cleanString(formData.get("intent"));
  const vehicleIdText = cleanString(formData.get("vehicle_id"));
  const unmatchedVehicleVin = cleanString(formData.get("unmatched_vehicle_vin"));
  const unmatchedVehicleYearText = cleanString(formData.get("unmatched_vehicle_year"));
  const unmatchedVehicleMake = cleanString(formData.get("unmatched_vehicle_make"));
  const unmatchedVehicleModel = cleanString(formData.get("unmatched_vehicle_model"));
  const unmatchedVehicleStockNumber = cleanString(formData.get("unmatched_vehicle_stock_number"));
  const file = formData.get("document");
  const status = intent === "submit" ? "submitted" : "draft";
  const allowedPaymentMethods = new Set([
    "self_paid",
    "visa_1209",
    "visa_2829",
    "visa_3173",
    "visa_3675",
    "visa_3687",
    "visa_4647",
    "visa_6755",
    "visa_7647",
  ]);

  if (!allowedClusters.has(businessCluster)) {
    redirectWithError("Select a valid business cluster.");
  }

  if (!allowedDirections.has(direction)) {
    redirectWithError("Select income or expense.");
  }

  const repairContext = businessCluster === "repair" ? rawRepairContext : null;

  if (businessCluster === "repair" && !allowedRepairContexts.has(rawRepairContext)) {
    redirectWithError("Select a valid repair context.");
  }

  const amount = amountText ? Number(amountText) : null;
  const vehicleId = vehicleIdText ? Number(vehicleIdText) : null;
  const unmatchedVehicleYear = unmatchedVehicleYearText ? Number(unmatchedVehicleYearText) : null;
  const needsVehicleInfo = businessCluster !== "general";

  if (amount !== null && (!Number.isFinite(amount) || amount < 0)) {
    redirectWithError("Enter a valid amount.");
  }

  if (paymentMethod && !allowedPaymentMethods.has(paymentMethod)) {
    redirectWithError("Select a valid payment method.");
  }

  if (vehicleId !== null && (!Number.isInteger(vehicleId) || vehicleId <= 0)) {
    redirectWithError("Select a valid vehicle.");
  }

  if (unmatchedVehicleYear !== null && (!Number.isInteger(unmatchedVehicleYear) || unmatchedVehicleYear < 1900 || unmatchedVehicleYear > 2100)) {
    redirectWithError("Enter a valid vehicle year.");
  }

  if (needsVehicleInfo && vehicleId === null && (!unmatchedVehicleVin || !unmatchedVehicleMake || !unmatchedVehicleModel)) {
    redirectWithError("Select a vehicle or manually enter VIN, Make, and Model.");
  }

  if (needsVehicleInfo && vehicleId === null && unmatchedVehicleVin) {
    if (unmatchedVehicleVin.length < 11 || unmatchedVehicleVin.length > 17) {
      redirectWithError(`VIN must be 11–17 characters (you entered ${unmatchedVehicleVin.length}). Please go back and correct it.`);
    }
  }

  const resolvedVehicleId: number | null = vehicleId;

  const { data: submission, error: submissionError } = await supabase
    .from("intake_submissions")
    .insert({
      submitted_by: user.id,
      business_cluster: businessCluster,
      repair_context: repairContext,
      direction,
      status,
      vehicle_id: resolvedVehicleId,
      unmatched_vehicle_vin: resolvedVehicleId ? null : unmatchedVehicleVin || null,
      unmatched_vehicle_year: resolvedVehicleId ? null : unmatchedVehicleYear,
      unmatched_vehicle_make: resolvedVehicleId ? null : unmatchedVehicleMake || null,
      unmatched_vehicle_model: resolvedVehicleId ? null : unmatchedVehicleModel || null,
      unmatched_vehicle_stock_number: resolvedVehicleId ? null : unmatchedVehicleStockNumber || null,
      transaction_date: transactionDate || null,
      amount,
      payment_method: paymentMethod || null,
      memo: memo || null,
    })
    .select("submission_id")
    .single();

  if (submissionError || !submission) {
    redirectWithError(submissionError?.message ?? "Could not save submission.");
  }

  if (file instanceof File && file.size > 0) {
    const extension = file.name.includes(".") ? file.name.split(".").pop() : "upload";
    const storagePath = `${user.id}/${submission.submission_id}/${crypto.randomUUID()}.${extension}`;
    const uploadResult = await supabase.storage.from("intake-documents").upload(storagePath, file, {
      contentType: file.type || undefined,
      upsert: false,
    });

    if (uploadResult.error) {
      redirectWithError(uploadResult.error.message);
    }

    const fileType = file.type === "application/pdf" ? "pdf" : file.type.startsWith("image/") ? "receipt_photo" : "other";
    const { error: documentError } = await supabase.from("intake_documents").insert({
      submission_id: submission.submission_id,
      uploaded_by: user.id,
      storage_path: storagePath,
      file_name: file.name,
      file_type: fileType,
      mime_type: file.type || null,
      file_size_bytes: file.size,
    });

    if (documentError) {
      redirectWithError(documentError.message);
    }
  }

  revalidatePath("/");
  redirect("/");
}
