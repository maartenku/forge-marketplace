# Stack

Base profile `api-dotnet` (code-forge): headless .NET, as an API, a worker, a scheduled job or a CLI. Extensions are appended below by `architecture`.

## Application type
Pick one: API or service, worker or scheduled job, CLI. A single .NET deployable with no UI.

## Frontend
None.

## Backend
.NET 10, as a Web API with minimal APIs, a Worker Service or a console (pick one). Mediator (martinothamar) for every use case. Clean Architecture (Domain, Application, Infrastructure, Api or Host) when the project has more than a handful of use cases; otherwise one project with the same folder names. ProblemDetails and a health endpoint for APIs. Structured JSON logging to stdout. The API contract is described in the next section.

## API contract: OpenAPI, Scalar, and NSwag when there is a consumer
- The OpenAPI document comes from the built-in `Microsoft.AspNetCore.OpenApi` at `/openapi/v1.json`, with summaries and tags per feature and typed DTOs. Worker services and CLIs have no HTTP contract; write "none" here.
- Scalar (`Scalar.AspNetCore`) at `/scalar` is the interactive reference. Swagger UI is not used.
- When another app consumes this API, NSwag generates a typed client (TypeScript/Angular or C#) into the consuming project: NSwag as a local dotnet tool (`.config/dotnet-tools.json`) with `nswag.json`, `scripts/generate-api.sh`, generated code committed, CI failing on drift.

## Testing
xUnit: unit tests for Application, one integration test per entrypoint (endpoint group, job, command). `scripts/test.sh`.

## Repo layout
```
src/Api (or src/Host)  src/Application  src/Domain  src/Infrastructure
tests/Application.Tests  tests/Api.Tests
```

## Dependency policy
Backend packages by default: `Mediator.SourceGenerator` and `Mediator.Abstractions`; for APIs also `Microsoft.AspNetCore.OpenApi` and `Scalar.AspNetCore`. NSwag only as a local dotnet tool, and only when there is a consumer. NuGet `RestorePackagesWithLockFile`. `dotnet list package --vulnerable --include-transitive` in `scripts/test.sh`. Every package justified in `dependencies.md`.

<!-- extensions (hosting; auth none, identity/JWT, API key, or third party; database; source-control) are appended below -->
