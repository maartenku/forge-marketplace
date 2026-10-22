"""Check marketplace manifests and skill frontmatter. Run: python3 scripts/validate.py"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
errors = []


def load(path):
    try:
        return json.loads(path.read_text())
    except (OSError, json.JSONDecodeError) as e:
        errors.append(f"{path.relative_to(ROOT)}: {e}")
        return None


def frontmatter(path):
    text = path.read_text()
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        errors.append(f"{path.relative_to(ROOT)}: missing frontmatter")
        return {}
    fields, key = {}, None
    for line in m.group(1).splitlines():
        top = re.match(r"^([a-z-]+):\s*(.*)$", line)
        if top:
            key = top.group(1)
            fields[key] = top.group(2).lstrip(">|-").strip()
        elif key and line.startswith("  "):
            fields[key] = (fields[key] + " " + line.strip()).strip()
    return fields


def check_skill(skill_dir):
    rel = skill_dir.relative_to(ROOT)
    skill_md = skill_dir / "SKILL.md"
    if not skill_md.is_file():
        errors.append(f"{rel}: no SKILL.md")
        return
    fm = frontmatter(skill_md)
    name, desc = fm.get("name", ""), fm.get("description", "")
    if not NAME_RE.match(name) or len(name) > 64:
        errors.append(f"{rel}: invalid skill name {name!r}")
    if name != skill_dir.name:
        errors.append(f"{rel}: name {name!r} does not match folder")
    if not 1 <= len(desc) <= 1024:
        errors.append(f"{rel}: description must be 1-1024 chars (is {len(desc)})")


claude = load(ROOT / ".claude-plugin/marketplace.json") or {}
codex = load(ROOT / ".agents/plugins/marketplace.json") or {}

claude_plugins = {p["name"]: p["source"] for p in claude.get("plugins", [])}
codex_plugins = {p["name"]: p["source"]["path"] for p in codex.get("plugins", [])}
if set(claude_plugins) != set(codex_plugins):
    errors.append(f"marketplaces list different plugins: {sorted(claude_plugins)} vs {sorted(codex_plugins)}")

for name, source in claude_plugins.items():
    plugin_dir = ROOT / source
    if not plugin_dir.is_dir():
        errors.append(f"{name}: source {source} not found")
        continue
    versions = set()
    for manifest in (".claude-plugin/plugin.json", ".codex-plugin/plugin.json"):
        data = load(plugin_dir / manifest)
        if data is None:
            continue
        if data.get("name") != name:
            errors.append(f"{name}/{manifest}: name is {data.get('name')!r}")
        versions.add(data.get("version"))
    if len(versions) > 1:
        errors.append(f"{name}: plugin.json versions differ: {versions}")
    skills = [d for d in (plugin_dir / "skills").glob("*") if d.is_dir()]
    if not skills:
        errors.append(f"{name}: no skills found")
    for skill_dir in skills:
        check_skill(skill_dir)

if errors:
    print("\n".join(f"FAIL {e}" for e in errors))
    sys.exit(1)
print(f"OK: {len(claude_plugins)} plugin(s) valid")
