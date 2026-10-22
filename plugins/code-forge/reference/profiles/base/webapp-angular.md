# Stack

Base profile `webapp-angular` (code-forge): UI only, no backend of our own. Extensions are appended below by `architecture-4`.

## Application type
Web app, frontend only: an Angular SPA or a prerendered static site with no server logic. State lives in the browser or in static JSON shipped with the build. If accounts, shared state or secrets appear, move to `webapp-api-dotnet-angular` or `cloudflare-webapp-serverless`.

## Frontend
Angular 21 LTS with standalone components and signals. NgRx Signal Store only when a feature holds real client state; otherwise component signals. Spartan NG with Tailwind. Tooling: pnpm, ESLint, Prettier, Vitest, Playwright. Prerender through `@angular/ssr` static output for content-heavy sites.
Layout: `src/app/{core,shared,features/[slug]}`; static data in `src/assets/data/`.

## Backend
None. External APIs are called from the browser and must be public and CORS-enabled. Anything that needs a secret is out of scope for this profile.

## Testing
Vitest for components and services. One Playwright smoke test for the user journey. `scripts/test.sh`.

## Repo layout
```
src/   (Angular workspace at the repo root)
tests/e2e
```

## Dependency policy
Lockfile committed. pnpm `minimumReleaseAge = 10080`. `pnpm audit` in `scripts/test.sh`. Every package justified in `dependencies.md`.

<!-- extensions (hosting; auth none or front door; database none; source-control) are appended below -->
