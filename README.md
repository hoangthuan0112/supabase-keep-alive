# Supabase Keep Alive Cron Job

A standalone repository running scheduled GitHub Actions to prevent free-tier Supabase projects from automatically pausing due to inactivity.

## How It Works

1. **Database Ping:** Every 3 days (configured in `.github/workflows/keep-alive.yml`), GitHub Actions triggers a workflow that sends REST API requests to your Supabase databases.
2. **Prevent Cron Disabling:** Automatically writes the current timestamp to `heartbeat.txt` and commits the changes back to the repository. This keeps the repository active, preventing GitHub from automatically disabling scheduled `cron` workflows after 60 days of inactivity.

## Setup Instructions

### Step 1: Add Secrets on GitHub
To keep your project credentials secure:
1. Go to the **Settings** tab in your GitHub repository.
2. Select **Secrets and variables** > **Actions** from the left sidebar.
3. Click **New repository secret**.
4. Add the corresponding keys for your project:
   - **`[YOUR_PROJECT_NAME]_URL`**: The API URL of your Supabase project (e.g., `https://xxxxxxxxxxxxxx.supabase.co`).
   - **`[YOUR_PROJECT_NAME]_ANON_KEY`**: The public `anon` key of your project.

> [!NOTE]
> You can name the prefix anything you want (e.g., `SELLER_URL` & `SELLER_ANON_KEY`). The workflow will automatically normalize and pair them up as long as they share the same prefix (e.g. `SELLER`).

### Step 2: Trigger Manually (Optional for Testing)
1. Go to the **Actions** tab of your repository.
2. Select the **Keep Supabase Alive** workflow.
3. Click **Run workflow** -> Select the `main` branch and click the button to run.
4. Check the workflow logs to ensure the connection returns a `200` (Success) or `401` status.

### Step 3: Manage Multiple Projects
If you have multiple Supabase projects, you don't need to modify the code. Simply add more URL/Key pairs to GitHub Secrets following the same naming convention (e.g., `APP1_URL` & `APP1_ANON_KEY`, `APP2_URL` & `APP2_ANON_KEY`). The workflow will dynamically detect, pair, and ping all of them!
