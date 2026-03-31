# Claude Code — Shared MAUI Config

Shared commands, agents, and hooks for all .NET MAUI projects.

## What's Included

### Commands (type `/command` in Claude Code)
- `/commit` — auto-generate commit messages
- `/pr` — build, test, prepare pull request
- `/unit-test` — generate unit tests for ViewModels/Services
- `/optimize` — optimize selected code
- `/doc-refactor` — refactor + add XML documentation

### Agents (Claude uses automatically when needed)
- `debugger` — diagnose MAUI build errors, binding issues, crashes
- `code-reviewer` — review C#/XAML for quality and MAUI-specific issues
- `secure-reviewer` — read-only security audit (hardcoded keys, insecure storage)
- `test-engineer` — write xUnit/NUnit tests

### Hooks (run automatically, no commit)
- `format-code.sh` — auto-format .cs and .xaml files after every write/edit
- `security-scan.sh` — warn about hardcoded secrets
- `context-tracker.py` — show context window usage

## Setup on a New Machine

```bash
# 1. Clone this repo
git clone git@github.com:YOUR_USERNAME/claude-maui-config.git ~/.claude/shared-maui

# 2. Link to any MAUI project
~/.claude/shared-maui/setup-project.sh /path/to/your-maui-project

# 3. Create CLAUDE.md manually in each project (unique per project)
```

## Link a New Project

```bash
~/.claude/shared-maui/setup-project.sh /path/to/your-maui-project
```

## Global Skills (separate setup)

These are installed globally at `~/.claude/skills/`:
- `code-review`
- `refactor`

To restore: copy from the `claude-howto` repo:
```bash
git clone https://github.com/luongnv89/claude-howto.git /tmp/claude-howto
cp -r /tmp/claude-howto/03-skills/code-review ~/.claude/skills/
cp -r /tmp/claude-howto/03-skills/refactor ~/.claude/skills/
rm -rf /tmp/claude-howto
```
