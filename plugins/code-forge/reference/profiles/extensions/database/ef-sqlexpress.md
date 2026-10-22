## Data: EF Core with SQL Server Express in Docker
Compatible bases: webapp-api-dotnet-angular, api-dotnet. Use it when the app runs on a local server for several users, or when the data outgrows a SQLite file.

`Microsoft.EntityFrameworkCore.SqlServer` with the same `DbContext` and migrations as `ef-sqlite`; the provider is chosen by `DB_PROVIDER=sqlserver`. The container is `mcr.microsoft.com/mssql/server` with `MSSQL_PID=Express` in the project's compose stack (`environments/prod/compose.yml`), data in a named volume, `SA_PASSWORD` from the server-side `.env`. Express limits (10 GB per database, one socket or four cores, about 1.4 GB buffer pool) are plenty for side projects.

For parity testing, `environments/sandbox/docker-compose.yml` can run the same image locally. The sandbox default stays SQLite so `scripts/dev.sh` needs no Docker. Run the migration check against SQL Server in CI before a release, with `dotnet ef migrations script` or a throwaway container.

Backups: `sqlcmd` with `BACKUP DATABASE` to the backup volume on a schedule, and include that volume in the machine's backups. Anything else (PostgreSQL, say) is an ADR.
