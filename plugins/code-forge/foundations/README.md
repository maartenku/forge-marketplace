# Foundations: copy instead of generating

A table of code worth lifting into a new project instead of generating it again: an auth slice, a Clean Architecture solution layout, Dockerfiles, a sandbox seeder, CI steps, the OpenAPI and NSwag wiring. Phase 3 (`architecture-4`) reads this table to fill "Reusable pieces" in `overview.md`; Phase 4 (`foundation-5`) copies the pieces first and generates only what is missing.

These are pointers, not code, so the kit stays small. Add a row whenever one of your projects produces something reusable, and point at the repo and paths where it lives.

| Piece | Where (repo and paths) | What to lift | Adapt |
|---|---|---|---|
| Example: auth slice (.NET Identity with JWT, Angular auth store, guards, interceptor) | your first project that has it | `src/Infrastructure/Identity/*`, `src/Api/Endpoints/Auth*`, `src/Web/src/app/core/auth/*`, seeded dev users | namespaces, project name, role names |
| Example: Clean Architecture solution layout | your first project that has it | `src/{Api,Application,Domain,Infrastructure}` project references, Mediator wiring, ProblemDetails, health endpoint | project name |
| Example: OpenAPI, Scalar and NSwag wiring | your first project that has it | `AddOpenApi` and `MapScalarApiReference` setup, `nswag.json`, `.config/dotnet-tools.json`, `scripts/generate-api.sh`, the CI drift check | output path, client namespace |
| Example: Dockerfiles and compose | your first project that deploys | `Dockerfile.api`, `Dockerfile.web`, `environments/prod/compose.yml` | ports, image names |
| Example: sandbox seeder (EF Core, JSON to entities) | your first project with EF | `src/Infrastructure/Seeding/*`, `scripts/sandbox-reset.sh` | entity names |

When lifting a piece: copy the files, rename namespaces and project names, delete what the new project does not need, then record the source and the adaptations in `docs/technical/architecture/overview.md` under "Reusable pieces".
