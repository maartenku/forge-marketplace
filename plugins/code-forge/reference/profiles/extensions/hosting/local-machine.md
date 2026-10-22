## Hosting: local Windows or Linux PC or server
Compatible bases: all. The default.

The app runs on a machine you control: your own PC during development (`scripts/dev.sh` against `environments/sandbox/`), and, when it should keep running, a local server or an always-on PC on the same network, Windows or Linux. Nothing is exposed to the internet unless you put a reverse proxy or a tunnel in front of it.

Two ways to run it there. Direct: `scripts/build.sh` produces a publish folder (`dotnet publish` plus the Angular `dist/`), installed as a Windows service or a systemd unit, documented in `docs/technical/setup/environments.md`. Docker: a multi-stage `Dockerfile.api` and a `Dockerfile.web` (nginx serving the Angular build) with `environments/prod/compose.yml`; the database container from the database extension lives in the same stack. Pick direct for one small app on a Windows box, Docker when the machine hosts several apps or runs Linux anyway.

Deploy path: with `local-git`, build on the development PC and copy the publish folder or run `docker compose up -d --build` on the server. With `github`, the `release.yml` workflow builds images on a tag and pushes them to GHCR; the server pulls over SSH. Secrets stay on the server in `.env`. Backups: a database dump plus named volumes (or the data folder) into whatever backup the machine has.

Sandbox is unaffected. When "reach it from outside the house" comes up, add a reverse proxy with TLS or a Cloudflare Tunnel in front, or move static parts to `cloudflare`.
