## Hosting: Cloudflare
Compatible bases: cloudflare-webapp-serverless (full), webapp-angular (static assets only). Not compatible with .NET backends; a .NET API can only sit behind a Cloudflare Tunnel on a self-hosted machine, which is the hybrid ADR.

The Angular build is served as Worker static assets (preferred for new projects) or through Cloudflare Pages; the API runs as Workers. `wrangler.toml` has one environment section each (`[env.sandbox]`, `[env.production]`).

Deploys run `wrangler deploy` from CI. With GitHub, Workers Builds or the Pages integration deploy on push and give preview URLs per branch. With `local-git`, run `wrangler deploy` from your machine.

The custom domain lives on Cloudflare DNS with automatic TLS. Cloudflare Access (Zero Trust) can sit in front of owner-only tools; the free tier covers a handful of users. The free tier also covers small projects' Workers requests, D1 rows and R2 storage; check the current limits before relying on them.

Sandbox: `wrangler dev` with local D1 and KV emulation; seeds in `environments/sandbox/seed/` are applied by `scripts/sandbox-reset.sh` through `wrangler d1 execute --local`.
