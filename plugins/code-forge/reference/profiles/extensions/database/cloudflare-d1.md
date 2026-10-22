## Data: Cloudflare D1, with KV and R2
Compatible bases: cloudflare-webapp-serverless only.

D1 is Cloudflare's SQLite-dialect SQL database, bound to the Worker. Access it through Drizzle ORM with checked-in migrations in `drizzle/`, applied with `wrangler d1 migrations apply`. Treat it as SQLite with replicas: no stored procedures, size limits per database, eventual read replicas. Model the data accordingly.

KV is for caches and small configuration; it is eventually consistent, so never use it for anything transactional. R2 holds files (S3-compatible API, no egress fees). Durable Objects only when a feature needs coordination or websockets, with an ADR.

Sandbox: `wrangler dev` emulates D1, KV and R2 locally. `scripts/sandbox-reset.sh` runs `wrangler d1 migrations apply --local` and then executes `environments/sandbox/seed/*.sql`. Bindings per environment live in `wrangler.toml`.

Backups: `wrangler d1 export` on a schedule (Cron Trigger or CI job) into R2 or a machine you control. Filesystem integration does not exist on Workers; files go to R2.
