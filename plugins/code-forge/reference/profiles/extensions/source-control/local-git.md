## Source control: local git, no remote
Compatible bases: all. The default.

The repository lives only on your machine (and in your backups). `git init` on day one, `main` always green, one `feat/[slug]` branch per feature (or per implementation plan), Conventional Commits with the slug as scope. There is no CI: `scripts/test.sh` is run by hand before every merge into `main`, and the "Done" checklist in `CLAUDE.md` asks for it.

Back the repository up like any other folder (or push a mirror somewhere private when you want one; that is the moment to switch to `github`). Nothing is pushed anywhere without the user saying so, which with no remote is automatic.
