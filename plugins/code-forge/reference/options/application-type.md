# Application type

The first block. It constrains all the others. Each type maps to a base profile in `reference/profiles/base/`.

| Type | Shape | Base profile | Pick when |
|---|---|---|---|
| Web app (default) | SPA plus API, one repo, two deployables | `webapp-api-dotnet-angular` | there is a UI and more than trivial server logic |
| UI only / static site | Angular SPA or prerendered HTML, no server | `webapp-angular` | content or client-only tools |
| API or service | headless .NET host or worker | `api-dotnet` | integrations, automation backends, things other apps call |
| CLI or scheduled job | one executable, timer-driven or run by hand | `api-dotnet` | one-off tooling, automation, snapshots, syncs |
| Cloudflare web app | Angular SPA plus TypeScript Workers | `cloudflare-webapp-serverless` | public, global, cheap, and a TypeScript backend is acceptable |
| Desktop | installable local app (Tauri or Electron shell) | none, ADR | needs the OS: tray, file watchers, native dialogs. Rare. |

Questions to ask: Is there a UI? If not, it is a service, CLI or job. Does the UI need server state or accounts? If not, it is UI only. Must it be public and cheap to run? Then Cloudflare. Does it need the OS? Only then desktop.
