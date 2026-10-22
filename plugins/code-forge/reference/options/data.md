# Data and persistence

There is no default for this block. The choice follows from the features, so `architecture` always asks. The four options are extensions under `profiles/extensions/database/`:

| Option | What | Pick when | Sandbox | Watch out |
|---|---|---|---|---|
| `files-only` | JSON or Markdown under a root folder (`FS_ROOT`), behind an `IFileSystem`-style interface | configuration-sized state, tools over the user's own folders, files a human may edit | an example tree in `environments/sandbox/fs/` | no concurrent writers, no queries across many records; move to SQLite when they appear |
| `ef-sqlite` | EF Core with a SQLite file | single-user apps and tools on a local machine; always the sandbox database when EF Core is used | `environments/sandbox/app.db`, reseeded by `scripts/sandbox-reset.sh` | one writer at a time; back up by copying the file |
| `ef-sqlexpress` | EF Core with SQL Server Express in Docker | several users on a local server, or data that outgrows a SQLite file | the same image in `environments/sandbox/docker-compose.yml` for parity; the sandbox default stays SQLite | Express limits (10 GB per database) are fine for side projects |
| `cloudflare-d1` | D1 (SQLite dialect) via Drizzle, with KV and R2 | only with the Cloudflare base | `wrangler dev` with local emulation | SQLite dialect; KV is eventually consistent |

With EF Core: one `DbContext` in Infrastructure, migrations checked in, no repository layer over EF, and the provider registered from `DB_PROVIDER` so SQLite and SQL Server are a configuration change apart. Seeds are realistic fakes, never exported real data. Never point the sandbox at real user folders.
