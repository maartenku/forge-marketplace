## Data: EF Core with SQLite
Compatible bases: webapp-api-dotnet-angular, api-dotnet. The sandbox database whenever EF Core is used, and the production database for single-user deployments on a local machine.

`Microsoft.EntityFrameworkCore.Sqlite` with one `DbContext` in Infrastructure, migrations checked in, and no repository layer over EF. The file is `environments/sandbox/app.db` (git-ignored). `scripts/sandbox-reset.sh` deletes it, runs `dotnet ef database update`, and seeds from `environments/sandbox/seed/*.json` through a small seeder in Infrastructure. Seeds are realistic fakes, never exported real data.

Connection from `.env`: `DB_PROVIDER=sqlite` and `DB_CONNECTION=Data Source=environments/sandbox/app.db`.

Limits to respect: one writer at a time (fine for single-user tools and small APIs), no concurrent migrations, and backups by copying the file. Register the provider from `DB_PROVIDER` so that moving to `ef-sqlexpress` is a configuration change plus a migration check, not a rewrite.
