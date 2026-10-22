# Stack profiles: base plus extensions

`docs/technical/architecture/stack.md` is composed, not written. Take one base profile (what kind of app, which frontend and backend) and add one extension per category (hosting, auth, database, source control). The `architecture` skill pastes the base, appends the chosen extension sections, and trims. The matrix below says which combinations work. Anything outside it needs an ADR.

## Base profiles (`base/`)

| Base | Frontend | Backend | Pick when |
|---|---|---|---|
| `webapp-api-dotnet-angular` (default) | Angular 21 LTS, NgRx Signal Store, Spartan NG | .NET 10 Web API, Mediator, Clean Architecture | there is a UI and real server logic; most projects |
| `webapp-angular` | Angular 21 LTS (NgRx only if state warrants it) | none | UI only: client-side tools, dashboards over static data, demos |
| `api-dotnet` | none | .NET 10 Web API, worker or console, with Mediator | integrations, automation, scheduled jobs, services other apps call |
| `cloudflare-webapp-serverless` | Angular 21 LTS SPA on Cloudflare (Workers static assets or Pages) | TypeScript on Cloudflare Workers (Hono) | public, global, near-zero hosting cost, and a TypeScript backend is acceptable |

## Extensions (`extensions/[category]/`)

| Category | Option | Default | Compatible bases |
|---|---|---|---|
| hosting | `local-machine`: your PC during development; a local Windows or Linux PC or server (direct install or Docker) when it should keep running | yes | all |
| hosting | `static-host`: prebuilt files on GitHub Pages, Cloudflare Pages or nginx | no | webapp-angular |
| hosting | `cloudflare`: Workers or Pages, `wrangler deploy` | no | cloudflare-webapp-serverless; webapp-angular (static only) |
| auth | `aspnet-identity`: ASP.NET Core Identity with JWT and roles | yes, when the app has accounts | webapp-api, api |
| auth | `third-party-oauth-sso`: Cloudflare Access, or OIDC/OAuth from Google, GitHub, Microsoft or Authentik; the app maps claims to roles | no | all (the only option on Cloudflare; webapp-angular can only do Access at the front door) |
| database | `files-only`: JSON or Markdown under a root folder the app owns | no default; `architecture` asks | webapp-api, api, webapp-angular (static JSON), cloudflare (R2) |
| database | `ef-sqlite`: EF Core with a SQLite file | no default | webapp-api, api |
| database | `ef-sqlexpress`: EF Core with SQL Server Express in Docker | no default | webapp-api, api |
| database | `cloudflare-d1`: D1 (SQLite dialect) via Drizzle, KV and R2 for cache and files | no default | cloudflare-webapp-serverless |
| source-control | `local-git`: a local repository, no remote, no CI | yes | all |
| source-control | `github`: GitHub with GitHub Actions | no | all; smoothest with Cloudflare |

"none" is a valid answer for auth (single-user tools) and for database on `webapp-angular`. Write "none" in that section rather than deleting it. The database category has no default on purpose: the choice follows from the features, so `architecture` always asks.

## Compatibility matrix

| Base | hosting | auth | database | source-control |
|---|---|---|---|---|
| webapp-api-dotnet-angular | local-machine | aspnet-identity, third-party-oauth-sso, none | files-only, ef-sqlite, ef-sqlexpress | local-git, github |
| webapp-angular | local-machine, static-host, cloudflare (static) | none, third-party-oauth-sso (Cloudflare Access at the front door) | none, files-only (static JSON) | local-git, github |
| api-dotnet | local-machine | none, aspnet-identity (JWT or API keys), third-party-oauth-sso | files-only, ef-sqlite, ef-sqlexpress | local-git, github |
| cloudflare-webapp-serverless | cloudflare | third-party-oauth-sso (Access, or OAuth in the Worker) | cloudflare-d1, files-only (R2) | github (recommended), local-git |

## How `architecture` composes `stack.md`

1. Paste the chosen `base/*.md` in full.
2. For each category, append the chosen `extensions/[category]/*.md`. Each file is one `##` section.
3. Trim to what the project uses. Keep every heading; write "none" instead of deleting.
4. Any pairing outside the matrix gets an ADR naming the risk.
