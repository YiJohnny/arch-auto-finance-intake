# Deployment Notes

## Recommended stack

- App hosting: Vercel
- Database, auth, and storage: Supabase

## Vercel environment variables

Set these in the Vercel project before the first deployment:

```text
NEXT_PUBLIC_SUPABASE_URL
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY
```

Use the same values currently stored locally in `.env.local`.

## Supabase auth URLs

After Vercel gives the production URL, update Supabase Authentication URL Configuration.

Suggested examples:

```text
Site URL:
https://your-project.vercel.app

Redirect URLs:
http://localhost:3000/**
https://your-project.vercel.app/**
https://*-your-account-slug.vercel.app/**
```

The exact production URL should be used once it is known.

## Email confirmation template

If the Confirm signup email template has been customized, keep it compatible with `emailRedirectTo`.

Preferred options:

```text
{{ .ConfirmationURL }}
```

or a redirect-aware link using:

```text
{{ .RedirectTo }}
```

## First deployment smoke test

1. Open the deployed `/login`.
2. Create a test employee account.
3. Confirm the account through email.
4. Sign in.
5. Create one test submission with a receipt or PDF.
6. Sign in as admin and review the submission.
7. Approve and post it.
