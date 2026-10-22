# Forge Marketplace

A plugin marketplace for Claude, Codex and GitHub Copilot.

## Plugins

| Plugin | What it does | Built for |
| --- | --- | --- |
| [no-ai-speak](plugins/no-ai-speak) | Keeps prose sounding human by avoiding common AI-writing patterns. | all three |
| [code-forge](plugins/code-forge) | A phase-gated workflow kit for AI-assisted side projects: functional docs, technical docs, stack profiles and the skills that run each phase. | Claude Code (installs elsewhere, but its skills use Claude Code paths) |

## Install

Replace `<github-user>` with the GitHub account that hosts this repo. The examples install no-ai-speak; use `code-forge` in place of `no-ai-speak` for the other plugin.

### Claude Code

```
/plugin marketplace add <github-user>/forge-marketplace
/plugin install no-ai-speak@forge-marketplace
```

### Claude desktop and claude.ai

Go to Customize > Plugins > Add > Add marketplace and enter `<github-user>/forge-marketplace`.

### GitHub Copilot CLI

```bash
copilot plugin marketplace add <github-user>/forge-marketplace
```

```bash
copilot plugin install no-ai-speak@forge-marketplace
```

### OpenAI Codex

```bash
codex plugin marketplace add <github-user>/forge-marketplace
```

```bash
codex plugin add no-ai-speak@forge-marketplace
```

You can also browse and install from `/plugins` inside Codex.

### Skill only

Tools without plugin support can still use the skill. Copy the skill folder into one of these:

- `~/.agents/skills/` (Codex, Copilot)
- `~/.claude/skills/` (Claude Code)
- `~/.copilot/skills/` (Copilot)

## Repo layout

```
.claude-plugin/marketplace.json     Claude Code, Claude desktop, Copilot CLI
.agents/plugins/marketplace.json    Codex
plugins/<name>/
  .claude-plugin/plugin.json        Claude and Copilot manifest
  .codex-plugin/plugin.json         Codex manifest
  skills/<skill>/SKILL.md
```

## Adding a plugin

1. Create `plugins/<name>/` with both `plugin.json` files and a `skills/` folder.
2. Add an entry to both marketplace files.
3. Run `python3 scripts/validate.py`.

The skill folder name must match the `name` in its `SKILL.md`. Keep the version the same in both `plugin.json` files.

## License

The repo scaffolding is MIT. Each plugin has its own license in its folder. no-ai-speak is CC BY-SA 4.0 because it is adapted from Wikipedia's [Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing).
