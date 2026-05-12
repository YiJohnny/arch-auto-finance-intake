"use server";

import { revalidatePath } from "next/cache";
import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { ensureAppProfile } from "@/app/auth/profile";
import { createClient } from "@/utils/supabase/server";

function encodedMessage(type: "error" | "notice", text: string) {
  return `/login?${type}=${encodeURIComponent(text)}`;
}

function encodedAuthMessage(path: string, type: "error" | "notice", text: string) {
  return `${path}?${type}=${encodeURIComponent(text)}`;
}

export async function signIn(formData: FormData) {
  const email = String(formData.get("email") ?? "").trim();
  const password = String(formData.get("password") ?? "");
  const supabase = await createClient();

  if (!email || !password) {
    redirect(encodedMessage("error", "Email and password are required."));
  }

  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password,
  });

  if (error) {
    redirect(encodedMessage("error", error.message));
  }

  if (data.user) {
    await ensureAppProfile(data.user);
  }

  revalidatePath("/", "layout");
  redirect("/");
}

export async function signUp(formData: FormData) {
  const fullName = String(formData.get("full_name") ?? "").trim();
  const email = String(formData.get("email") ?? "").trim();
  const password = String(formData.get("password") ?? "");
  const supabase = await createClient();
  const origin = (await headers()).get("origin");

  if (!fullName || !email || !password) {
    redirect(encodedMessage("error", "Full name, email, and password are required."));
  }

  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      emailRedirectTo: origin ? `${origin}/auth/confirm` : undefined,
      data: {
        full_name: fullName,
      },
    },
  });

  if (error) {
    redirect(encodedMessage("error", error.message));
  }

  if (data.user) {
    await supabase.from("app_profiles").upsert({
      profile_id: data.user.id,
      full_name: fullName,
      email,
      role: "employee",
    });
  }

  revalidatePath("/", "layout");
  redirect(encodedMessage("notice", "Account created. Check your email and confirm the account before signing in."));
}

export async function requestPasswordReset(formData: FormData) {
  const email = String(formData.get("email") ?? "").trim();
  const supabase = await createClient();
  const origin = (await headers()).get("origin");

  if (!email) {
    redirect(encodedAuthMessage("/forgot-password", "error", "Email is required."));
  }

  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: origin ? `${origin}/auth/callback?next=/reset-password` : undefined,
  });

  if (error) {
    redirect(encodedAuthMessage("/forgot-password", "error", error.message));
  }

  redirect(
    encodedAuthMessage(
      "/forgot-password",
      "notice",
      "Password reset email sent. Check your inbox for the recovery link.",
    ),
  );
}

export async function updateRecoveredPassword(formData: FormData) {
  const password = String(formData.get("password") ?? "");
  const confirmPassword = String(formData.get("confirm_password") ?? "");
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect(encodedMessage("error", "Open the password reset link from your email first."));
  }

  if (!password || password.length < 8) {
    redirect(encodedAuthMessage("/reset-password", "error", "Password must be at least 8 characters."));
  }

  if (password !== confirmPassword) {
    redirect(encodedAuthMessage("/reset-password", "error", "Passwords do not match."));
  }

  const { error } = await supabase.auth.updateUser({
    password,
  });

  if (error) {
    redirect(encodedAuthMessage("/reset-password", "error", error.message));
  }

  await supabase.auth.signOut();
  revalidatePath("/", "layout");
  redirect(encodedMessage("notice", "Password updated. Sign in with your new password."));
}

export async function signOut() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  revalidatePath("/", "layout");
  redirect("/login");
}

export async function createProfile(formData: FormData) {
  const fullName = String(formData.get("full_name") ?? "").trim();
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  if (!fullName) {
    redirect("/?error=Full%20name%20is%20required.");
  }

  await supabase.from("app_profiles").upsert({
    profile_id: user.id,
    full_name: fullName,
    email: user.email,
    role: "employee",
  });

  revalidatePath("/", "layout");
  redirect("/");
}
