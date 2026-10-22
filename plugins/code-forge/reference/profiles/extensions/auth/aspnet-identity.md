## Authorization: ASP.NET Core Identity
Compatible bases: webapp-api-dotnet-angular, api-dotnet. The default when the app has accounts.

`Microsoft.AspNetCore.Identity.EntityFrameworkCore` stores users and roles in the project database. The API issues a short-lived JWT access token and a rotating refresh token. Roles give coarse permissions; policies cover finer rules. For `api-dotnet` without users, use an API-key header or a client-credentials JWT instead of Identity.

On the Angular side: an NgRx auth store, an HTTP interceptor for the token and the refresh, route guards, and a `hasRole` directive.

Copy, do not build. Lift the slice from a project that already has it (see `foundations/README.md`) and record the source in `overview.md` under Reusable pieces. Only the first project builds it.

Sandbox: seeded `admin@dev.local` and `user@dev.local` with the dev passwords from `.env.example`. Hosted environments rotate `JWT_SIGNING_KEY` and seed no dev users.

This is ASP.NET Core Identity with self-hosted accounts, not Microsoft Entra ID or MSAL. Entra login belongs to the `third-party-oauth-sso` extension.
