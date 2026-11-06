# Boighor — starter project

A free-to-start Bengali digital library using GitHub Pages + Supabase.

## What is included
- Premium dark / gold responsive library UI
- Public shelf for approved books
- Member PDF submission (pending review)
- Admin-only private shelf (Supabase Auth + database/storage policies)
- Search and category filtering

## 1. Create the Supabase project
1. Create a free project at https://supabase.com
2. Open SQL Editor and run all of `supabase-setup.sql`.
3. Open Authentication > Providers and make sure Email is enabled.
4. Create your own account in the deployed site (or Supabase Auth).
5. In Authentication > Users, copy your account UUID.
6. In SQL Editor run:
   `update public.profiles set role='admin' where id='PASTE-YOUR-UUID-HERE';`
   Do not share your UUID publicly.

## 2. Add project keys
1. Supabase project > Project Settings > API.
2. Copy Project URL and the `anon` / publishable key.
3. Put them in `app.js`:
   - SUPABASE_URL
   - SUPABASE_ANON_KEY
The anon/publishable key is intended for browser use; NEVER put a `service_role` or secret key in this website.

## 3. Publish with GitHub Pages
1. Create a GitHub repository named `boighor`.
2. Upload `index.html`, `style.css`, `app.js`, and `supabase-setup.sql` (SQL can stay in repo, but remove it if you prefer not to publish setup notes).
3. Repository Settings > Pages > Build and deployment > Deploy from a branch.
4. Choose `main` and `/ (root)`, then Save.
5. Wait for GitHub Pages to publish your site.

## 4. Add your own private PDF books
For the first version, private book uploads are managed from the Supabase dashboard or a future admin upload panel:
1. Upload each PDF to the `private-books` bucket using a path like `admin/book-file.pdf`.
2. Insert a row in `books` with `visibility='private'`, `status='approved'`, and matching `file_path`.
Only an admin can read private book rows and private storage files.

## 5. Review public submissions
Members can sign up and submit a PDF. Submissions are stored as `pending`.
In Supabase Table Editor > books, change `status` to `approved` to publish, or `rejected` to decline.
The public bucket is private (not publicly browsable); approved book reading is served with short-lived signed links by the site.

## Important security notes
- Keep all private PDFs in `private-books`, never in the public bucket.
- Never use the Supabase `service_role` key in frontend code.
- Keep your Supabase account protected with a unique password and email verification.
- GitHub Pages hosts static files; the database and access controls are enforced by Supabase.
- Free tiers have quotas and can change. This starter is for a small initial library, not unlimited storage or guaranteed permanent hosting.
- Only upload books you wrote or have permission to distribute. Do not upload copyrighted books without permission.

## Current starter limitations
- Admin approval is done in Supabase dashboard, not a custom admin panel yet.
- Private book upload is done in Supabase dashboard, not the website yet.
- For stronger production security, add rate limiting, file scanning, and stricter upload moderation before accepting large volumes of public uploads.
