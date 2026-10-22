# Sandbox: {{PROJECT}}

`environments/sandbox/` runs the app end to end with no real data or accounts. Rebuilt by `scripts/sandbox-reset.sh`.

| Part | Path | Notes |
|---|---|---|
| Database | `app.db` (SQLite) or `docker-compose.yml` | drop, migrate, seed |
| Seeds | `seed/` | realistic fakes |
| Filesystem | `fs/` | example tree the app reads/writes |
| Stubs | `stubs/` | faked external APIs |
| Dev users | seeded | `admin@dev.local` / `user@dev.local`, passwords in `.env.example` |
