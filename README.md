# Supabase Keep Alive

A GitHub Actions workflow queries a dedicated table in each Supabase project every day at 00:00 UTC (07:00 Vietnam time). It fails if a project cannot return the expected row. Free projects may still be paused: Supabase does not guarantee that periodic requests prevent inactivity pauses.

## Setup

1. Restore each paused project in the Supabase dashboard.
2. Run [supabase/keep_alive.sql](supabase/keep_alive.sql) in the SQL Editor of **each** project. It creates a single public-readable row with no application data. The `public` schema must be exposed through the Data API. Review the script before running it, especially if a table named `keep_alive` already exists.
3. In GitHub repository **Settings → Secrets and variables → Actions**, add a URL and anonymous or publishable API key for each project, such as `SELLER_URL` and `SELLER_ANON_KEY`. Use matching prefixes. Do not use a service-role or secret key.
4. Enable **Keep Supabase Alive** under GitHub Actions, choose **Run workflow**, and verify that every project reports a successful database query. Configure GitHub notifications for failed workflows.

The workflow discovers secret pairs automatically. It updates `heartbeat.txt` after a successful run. Scheduled runs can be delayed or disabled by GitHub, so check their history periodically. A paused Supabase project must be restored manually before it can answer requests.
