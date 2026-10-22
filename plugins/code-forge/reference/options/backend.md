# Backend

Default: .NET 10 Web API, with minimal APIs grouped per feature or controllers (pick one per project and write it down). Mediator (martinothamar) for every use case: each one is a Command or Query with a handler in Application, and pipeline behaviours cover validation and logging. Mediator is source-generated, so no reflection, and its licensing is simple; that is why it was chosen over MediatR. Clean Architecture in four projects: Domain (no references), Application (Mediator, validators, interfaces), Infrastructure (EF Core or the file store, Identity, external clients), Api (host, endpoints, DI). For a one-evening tool the four projects may collapse into one with the same folder names; keep the Mediator shape so it can be split later. Cross-cutting: `ILogger` JSON console logging, ProblemDetails, a health endpoint.

The API contract: an OpenAPI document from the built-in `Microsoft.AspNetCore.OpenApi`, Scalar (`Scalar.AspNetCore`) as the reference UI rather than Swagger UI or Swashbuckle, and NSwag (a local dotnet tool with `nswag.json`) generating the typed Angular client into `src/Web/src/app/core/api/`, committed and drift-checked.

Packages: `Mediator.SourceGenerator` and `Mediator.Abstractions`, `Microsoft.AspNetCore.OpenApi`, `Scalar.AspNetCore`, plus EF Core and Identity when chosen. NSwag is a dotnet tool, not a package reference. Validation is plain code or a small validator; a validation library only for form-heavy projects.

| Alternative | Pick when | Watch out |
|---|---|---|
| TypeScript on Cloudflare Workers with Hono (base `cloudflare-webapp-serverless`) | the app must live on Cloudflare, where .NET cannot run | a second ecosystem to patch; the base profile lists what Workers can and cannot do |
| No backend (base `webapp-angular`) | UI only: client-side tools, static sites, demos | once accounts, shared state or secrets appear, move to the .NET default or to Workers |

Questions to ask: Is there server logic at all? If not, no backend. Must it run on Cloudflare? Then TypeScript. Otherwise .NET.
