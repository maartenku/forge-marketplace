# Hosting

Default: a local Windows or Linux PC or server (`profiles/extensions/hosting/local-machine.md`). During development that is your own PC running `scripts/dev.sh` against the sandbox; when the app should keep running it is a local server or an always-on PC on the same network, either a direct install (`dotnet publish` plus the Angular build as a Windows service or a systemd unit) or Docker with `environments/prod/compose.yml`. Nothing is exposed to the internet unless you add a reverse proxy with TLS or a Cloudflare Tunnel. Hosting details for a deployed project live in `docs/technical/setup/environments.md`.

| Alternative | Composition | Pick when | Watch out |
|---|---|---|---|
| Static host only (`static-host.md`) | prebuilt files on GitHub Pages, Cloudflare Pages or nginx | UI-only projects, demos | the first form, account or secret needs a backend |
| Cloudflare (`cloudflare.md`) | Workers (or Pages) with D1, KV and R2, Access for auth | public, globally fast, cheap, nothing at home exposed | the backend becomes TypeScript on Workers; .NET does not run there. A hybrid, SPA on Cloudflare and a .NET API at home through a Cloudflare Tunnel, is valid with an ADR |

Questions to ask: Does it need to be reachable from outside your network? If not, a local machine. Is it UI only? Then a static host. Public with a backend and cheap? Then Cloudflare.
