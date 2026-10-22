# Stack

Base profile `cloudflare-webapp-serverless` (code-forge): an Angular SPA with a TypeScript serverless backend, everything on Cloudflare. This deviates from the default backend language and hosting, so it needs an ADR.

## What Cloudflare can and cannot run (2026)
Cloudflare runs static assets (the Angular build) through a Worker or Cloudflare Pages, and TypeScript, JavaScript and WASM on Workers. Around that it offers D1 (SQLite-dialect SQL), KV (key-value cache), R2 (S3-style files), Durable Objects (stateful coordination and websockets), Queues, Cron Triggers, Workers AI, and Cloudflare Access for front-door auth.

It does not run .NET. There is no .NET runtime on Workers, so the backend is TypeScript. Keep the same discipline as the .NET side: feature folders, one handler per use case, validation at the edge.

A hybrid is allowed with an ADR: Angular on Cloudflare and a .NET API on a self-hosted machine exposed through a Cloudflare Tunnel. In that case use `webapp-api-dotnet-angular` and note `hosting/cloudflare` as frontend only.

Limits to design around: CPU time per request, no long-lived processes (use Queues or Durable Objects), and D1's SQLite semantics (no stored procedures, size limits per database).

## Application type
Web app: an Angular SPA and a Workers API, one repo, deployed as one Worker with static assets (preferred for new projects) or as Pages with Pages Functions.

## Frontend
Angular 21 LTS with standalone components and signals. NgRx Signal Store per feature. Spartan NG with Tailwind. Tooling: pnpm, ESLint, Prettier, Vitest, Playwright. Layout: `src/web/src/app/{core,shared,features/[slug]}`.

## Backend
Cloudflare Workers in TypeScript. Hono for routing. One module per feature under `src/worker/features/[slug]/` with a handler per use case. zod for input validation. `wrangler` for local development (`wrangler dev`) and deploys. Bindings (D1, KV, R2, secrets) are declared in `wrangler.toml`; secrets go in through `wrangler secret`, never into the repo. The API contract is described in the next section.

## API contract: OpenAPI, Scalar, NSwag
- The OpenAPI document is generated from the Worker routes with `@hono/zod-openapi`, so the zod schemas serve as both validation and schema. It is served at `/openapi.json`.
- Scalar, through `@scalar/hono-api-reference`, serves the interactive reference at `/scalar`. Swagger UI is not used.
- NSwag generates the typed Angular client from `/openapi.json` into `src/web/src/app/core/api/api.generated.ts`. Use the local dotnet tool with `nswag.json`, or the `nswag` npm CLI as a devDependency if no .NET SDK is wanted on the machine; pick one and record it in `dependencies.md`. `scripts/generate-api.sh` runs it; the generated file is committed; CI fails on drift.

## Testing
Vitest for web and worker (`@cloudflare/vitest-pool-workers` for the Worker). One Playwright smoke test against `wrangler dev`. `scripts/test.sh`.

## Repo layout
```
src/web      (Angular)
src/worker   (Workers API)
wrangler.toml
tests/e2e
```

## Dependency policy
Lockfile committed. pnpm `minimumReleaseAge = 10080`. `pnpm audit` in `scripts/test.sh`. Every package justified in `dependencies.md`.

<!-- extensions (hosting/cloudflare, auth/third-party-oauth-sso, database/cloudflare-d1, source-control) are appended below -->
