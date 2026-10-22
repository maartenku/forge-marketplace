## Data: files only
Compatible bases: webapp-api-dotnet-angular, api-dotnet, webapp-angular (static JSON in the build), cloudflare-webapp-serverless (R2 only).

No database. State is JSON, Markdown or other files under a root folder the app owns. In .NET, put an `IFileSystem`-style interface in Application with one Infrastructure implementation, take the root from `.env` (`FS_ROOT`), and keep writes atomic (write to a temp file, then rename). On Workers the equivalent is R2.

Fits configuration-sized state, tools that read and write the user's own folders, and anything a human may also edit by hand. Does not fit concurrent writers, queries across many records, or anything that needs transactions; when those appear, move to `ef-sqlite` (same interface, different implementation).

Sandbox: `environments/sandbox/fs/` holds a representative tree and example files, restored by `scripts/sandbox-reset.sh`. Never point the sandbox at real user folders.
