import { type EmailOtpType } from "@supabase/supabase-js";
import { NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";

export async function GET(request: Request) {
  const requestUrl = new URL(request.url);
  const tokenHash = requestUrl.searchParams.get("token_hash");
  const code = requestUrl.searchParams.get("code");
  const type = requestUrl.searchParams.get("type") as EmailOtpType | null;
  const next = requestUrl.searchParams.get("next");
  const fallbackNext = type === "recovery" ? "/reset-password" : "/auth/confirmed";
  const safeNext = next?.startsWith("/") ? next : fallbackNext;
  const redirectUrl = new URL(requestUrl);

  redirectUrl.pathname = safeNext;
  redirectUrl.search = "";

  if (tokenHash && type) {
    const supabase = await createClient();
    const { error } = await supabase.auth.verifyOtp({
      type,
      token_hash: tokenHash,
    });

    if (!error) {
      return NextResponse.redirect(redirectUrl);
    }

    redirectUrl.pathname = type === "recovery" ? "/forgot-password" : "/login";
    redirectUrl.searchParams.set("error", error.message);
    return NextResponse.redirect(redirectUrl);
  }

  if (code) {
    const supabase = await createClient();
    const { error } = await supabase.auth.exchangeCodeForSession(code);

    if (!error) {
      return NextResponse.redirect(redirectUrl);
    }

    redirectUrl.pathname = safeNext === "/reset-password" ? "/forgot-password" : "/login";
    redirectUrl.searchParams.set(
      "error",
      "This email link could not be verified in this browser. Please request a new link and open it in the same browser, or ask an admin to use the token-based email template.",
    );
    return NextResponse.redirect(redirectUrl);
  }

  redirectUrl.pathname = safeNext === "/reset-password" ? "/forgot-password" : "/login";
  redirectUrl.searchParams.set("error", "Invalid email confirmation link.");
  return NextResponse.redirect(redirectUrl);
}
