# Building-block checklist (Phase 3)

Answer in order, one line each, into `docs/technical/architecture/overview.md`. Take the default where there is one unless a feature or constraint argues otherwise; every non-default gets an ADR. Decision guides are in `reference/options/`. The composable `stack.md` pieces (base profiles, extensions, compatibility matrix) are in `reference/profiles/`.

| # | Block | Question | Default |
|---|---|---|---|
| 1 | Application type | Web app, UI only, API or service, CLI, scheduled job, desktop, Cloudflare web app? | web app (SPA plus API) |
| 2 | Frontend | Is there a UI, and which framework? | Angular 21 LTS, NgRx Signal Store, Spartan NG, Tailwind; or no frontend |
| 3 | Backend | Server logic, and how is it structured? | .NET 10 Web API, Mediator (martinothamar), Clean Architecture, OpenAPI with Scalar and an NSwag-generated client; or TypeScript on Cloudflare Workers; or no backend |
| 4 | Data and persistence | What survives a restart, and where? | no default: files only, EF Core with SQLite, EF Core with SQL Server Express, or Cloudflare D1 |
| 5 | Authorization | Accounts? Who may do what? | ASP.NET Core Identity with JWT and roles when there are accounts; or third-party OAuth/SSO; or none |
| 6 | Hosting | Where does it run? | a local Windows or Linux PC or server; or a static host; or Cloudflare |
| 7 | Source control | Where is the code, what runs on push? | local git with no remote; or GitHub with Actions |

Compose one base profile (`webapp-api-dotnet-angular` by default, or `webapp-angular`, `api-dotnet`, `cloudflare-webapp-serverless`) with one extension per category. In the same pass derive the dependencies per feature into `dependencies.md`, the test level into `stack.md`, the sandbox contents into `docs/technical/setup/sandbox.md`, and the reusable pieces into `overview.md` and `foundations/README.md`.
