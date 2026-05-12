import { type EmailOtpType } from "@supabase/supabase-js";
import { NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";

export async function GET(request: Request) {
  const requestUrl = new URL(request.url);
  const tokenHash = requestUrl.searchParams.get("token_hash");
  const type = requestUrl.searchParams.get("type") as EmailOtpType | null;
  const next = requestUrl.searchParams.get("next") ?? "/auth/confirmed";
  const redirectUrl = new URL(requestUrl);

  redirectUrl.pathname = next;
  redirectUrl.search = "";

  if (tokenHash && type) {
    const supabase = await createClient();
    const { error } = await supabase.auth.verifyOtp({
      type,
      token_hash: tokenHash,
    });

    if (!error) {
      redirectUrl.pathname = "/auth/confirmed";
      return NextResponse.redirect(redirectUrl);
    }

    redirectUrl.pathname = "/login";
    redirectUrl.searchParams.set("error", error.message);
    return NextResponse.redirect(redirectUrl);
  }

  redirectUrl.pathname = "/login";
  redirectUrl.searchParams.set("error", "Invalid email confirmation link.");
  return NextResponse.redirect(redirectUrl);
}
