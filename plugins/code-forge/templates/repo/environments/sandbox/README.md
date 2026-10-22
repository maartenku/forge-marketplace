# sandbox

Fake data, example files, stubs. Never real data. Must be rebuildable by `scripts/sandbox-reset.sh`.

```
docker-compose.yml   # or app.db for SQLite
seed/                # applied on reset
fs/                  # example filesystem tree, if the app touches folders
stubs/               # faked external APIs
```
