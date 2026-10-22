## Hosting: static host only
Compatible bases: webapp-angular only.

Prebuilt HTML, CSS and JavaScript served by a static host: GitHub Pages, Cloudflare Pages, or nginx on a local machine. No server process of your own. `scripts/build.sh` produces `dist/`; with `github` the `ci.yml` workflow publishes it on push to `main`; with `local-git` you copy `dist/` to the host.

Client state lives in the browser or in static JSON shipped with the build. When a form, an account or a secret appears, the project needs a backend: move to `cloudflare` (Workers) or to `webapp-api-dotnet-angular` on a local machine.
