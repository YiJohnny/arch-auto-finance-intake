import { createClient } from "@/utils/supabase/server";

type AppProfile = {
  full_name: string | null;
  email: string | null;
  role: string;
};

type AuthUser = {
  id: string;
  email?: string;
  user_metadata: {
    full_name?: string;
    name?: string;
  };
};

export async function ensureAppProfile(user: AuthUser): Promise<AppProfile | null> {
  const supabase = await createClient();
  const { data: existingProfile } = await supabase
    .from("app_profiles")
    .select("full_name,email,role")
    .eq("profile_id", user.id)
    .maybeSingle<AppProfile>();

  if (existingProfile) {
    return existingProfile;
  }

  const fullName = user.user_metadata.full_name ?? user.user_metadata.name ?? user.email ?? "Employee";
  const { data: createdProfile } = await supabase
    .from("app_profiles")
    .upsert({
      profile_id: user.id,
      full_name: fullName,
      email: user.email,
      role: "employee",
    })
    .select("full_name,email,role")
    .maybeSingle<AppProfile>();

  return createdProfile;
}
