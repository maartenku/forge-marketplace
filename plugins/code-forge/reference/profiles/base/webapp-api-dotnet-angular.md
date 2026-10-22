# Stack

Base profile `webapp-api-dotnet-angular` (code-forge), the default. Extensions are appended below by `architecture-4`. Deviations are ADRs in `decisions/`.

## Application type
Web app: an Angular SPA and a .NET Web API, one repo, two deployables.

## Frontend
Angular 21 LTS with standalone components and signals. NgRx Signal Store, one store per feature. Spartan NG (brain plus helm) with Tailwind. Tooling: pnpm, ESLint, Prettier, Vitest, Playwright.
Layout: `src/Web/src/app/{core,shared,features/[slug]}`. Design tokens live in `tailwind.config` (the house design system once it exists).

## Backend
.NET 10 Web API with minimal APIs grouped per feature. Mediator (martinothamar) for every use case. Clean Architecture: Domain, Application, Infrastructure, Api. ProblemDetails for errors, a health endpoint, structured JSON logging through `ILogger`. The API contract is described in the next section.

## API contract: OpenAPI, Scalar, NSwag
- The OpenAPI document comes from the built-in `Microsoft.AspNetCore.OpenApi` (`AddOpenApi()` and `MapOpenApi()`) at `/openapi/v1.json`. Every endpoint has a summary, a tag per feature, and typed request and response DTOs. The document is the contract.
- Scalar (`Scalar.AspNetCore`, `MapScalarApiReference()`) serves the interactive API reference at `/scalar`. Swagger UI and Swashbuckle are not used.
- NSwag generates the typed Angular client from that document. NSwag is a local dotnet tool (`.config/dotnet-tools.json`, package `NSwag.ConsoleCore`) driven by `nswag.json` at the repo root (template `Angular`, `injectionTokenType: InjectionToken`, one client class per tag). Output goes to `src/Web/src/app/core/api/api.generated.ts`. `scripts/generate-api.sh` exports the document from the built Api and runs `dotnet nswag run`. The generated file is committed; CI regenerates it and fails on a diff, so client and server cannot drift. Hand-written code wraps the generated client in feature services and never edits it.
- Scalar and the OpenAPI endpoint are mapped in Development only, unless the API is public by design.

## Testing
xUnit for Application (unit) and Api (one integration test group per endpoint group). Vitest for Web. One Playwright smoke test that follows the user journey. Everything runs through `scripts/test.sh`.

## Repo layout
```
src/Api  src/Application  src/Domain  src/Infrastructure  src/Web
src/Web/src/app/core/api/api.generated.ts   (NSwag output, committed)
nswag.json  .config/dotnet-tools.json
tests/Application.Tests  tests/Api.Tests  tests/e2e
```

## Dependency policy
Backend packages by default: `Mediator.SourceGenerator` and `Mediator.Abstractions`, `Microsoft.AspNetCore.OpenApi`, `Scalar.AspNetCore`, the EF Core provider from the database extension, Identity from the auth extension. NSwag only as a local dotnet tool. Lockfiles committed (`pnpm-lock.yaml`, `packages.lock.json`). pnpm `minimumReleaseAge = 10080` (7 days). NuGet `RestorePackagesWithLockFile`. Audits in `scripts/test.sh`. Every package justified in `dependencies.md`.

<!-- extensions (hosting, auth, database, source-control) are appended below -->
