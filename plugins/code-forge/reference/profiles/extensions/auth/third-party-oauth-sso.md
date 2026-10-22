## Authorization: third-party OAuth or SSO
Compatible bases: all. It is the only option on `cloudflare-webapp-serverless`. On `webapp-angular` only the front-door form (Cloudflare Access) is possible, since there is no backend to hold a session.

Pick one shape.

Front door with Cloudflare Access (Zero Trust): Access sits in front of the whole app; users sign in with Google, GitHub, Microsoft or a one-time PIN; the app trusts the `Cf-Access-Jwt-Assertion` header and verifies it in the Worker or the API. No user table is needed; roles are Access groups or a small allow-list. Best for owner-only or small-group tools.

OIDC or OAuth inside the app: the backend (Worker or .NET) runs the authorization-code flow against Google, GitHub, Microsoft Entra, or a self-hosted Authentik or Keycloak; it keeps a session cookie or issues its own JWT, and maps provider claims to local roles stored in the database. Use this when the app has real users with per-user data.

Self-hosted IdP (Authentik or Keycloak on your own machine): the same as above with your own provider. Only worth it when two or more self-hosted apps should share logins.

Rules: never implement password storage in this extension; store only the provider's subject id, the email and the roles. Sandbox: a stub provider, or an Access bypass policy for `localhost`, plus seeded role mappings so `scripts/dev.sh` works offline.
