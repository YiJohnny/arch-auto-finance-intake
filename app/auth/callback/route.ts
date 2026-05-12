import { NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";

export async function GET(request: Request) {
  const requestUrl = new URL(request.url);
  const code = requestUrl.searchParams.get("code");
  const next = requestUrl.searchParams.get("next") ?? "/";
  const redirectUrl = new URL(requestUrl);

  redirectUrl.pathname = next;
  redirectUrl.search = "";

  if (code) {
    const supabase = await createClient();
    const { error } = await supabase.auth.exchangeCodeForSession(code);

    if (!error) {
      return NextResponse.redirect(redirectUrl);
    }

    redirectUrl.pathname = "/login";
    redirectUrl.searchParams.set("error", error.message);
    return NextResponse.redirect(redirectUrl);
  }

  redirectUrl.pathname = "/login";
  redirectUrl.searchParams.set("error", "Invalid auth callback.");
  return NextResponse.redirect(redirectUrl);
}
