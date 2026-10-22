# Authorization

Default when the app has accounts: ASP.NET Core Identity with EF Core stores, a short-lived JWT access token with a rotating refresh token, roles for coarse permissions and policies for finer ones. On the Angular side an NgRx auth store, an interceptor for token and refresh, route guards and a `hasRole` directive. The sandbox seeds `admin@dev.local` and `user@dev.local` with known dev passwords. Copy the slice from a project that already has it (`foundations/README.md`). In the kit this is `profiles/extensions/auth/aspnet-identity.md`; it is ASP.NET Core Identity, not Entra or MSAL. The other extension is `third-party-oauth-sso.md`: Cloudflare Access or an OIDC/OAuth provider, and the only option on Cloudflare.

| Alternative | Pick when | Watch out |
|---|---|---|
| No accounts | single-user local tools, static sites, CLIs, anything on a private network | say so in `overview.md`; the Identity slice is the upgrade path if sharing comes up |
| Front-door auth (Cloudflare Access, or basic auth at a reverse proxy) | a self-hosted or Cloudflare-hosted tool only a few named people reach | zero auth code; the app has no notion of users |
| External IdP over OIDC (Authentik or Keycloak self-hosted, or Google, GitHub, Microsoft login) | SSO across two or more apps, or users must not create yet another password | another service to run, or a dependency on the provider; the app only maps claims to roles |

Questions to ask: Will anyone but the owner use it? If not, no accounts (or front-door auth if exposed). Do users have different rights? Then Identity with roles. Do several apps need the same users? Then OIDC, with an ADR.
