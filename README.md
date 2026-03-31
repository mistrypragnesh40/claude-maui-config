# Claude Code — Shared MAUI Config

Shared commands, agents, hooks, and templates for all .NET MAUI projects.

## What's Included

### Commands (type `/command` in Claude Code)

| Command | What It Does |
|---------|-------------|
| `/build` | Build solution, show errors in clean format |
| `/fix-build` | Auto-diagnose and fix build errors |
| `/commit` | Auto-generate commit message |
| `/pr` | Build, test, prepare pull request summary |
| `/unit-test` | Generate unit tests for ViewModels/Services |
| `/optimize` | Optimize selected code |
| `/doc-refactor` | Refactor + add XML documentation |
| `/nuget-audit` | Check for vulnerable/outdated NuGet packages |
| `/accessibility` | Check XAML for missing accessibility labels |
| `/xaml-check` | Validate XAML bindings match ViewModel properties |
| `/perf` | Find performance issues (main thread blocking, memory leaks, layout) |

### Agents (Claude uses when needed)

| Agent | What It Does |
|-------|-------------|
| `debugger` | Diagnose MAUI build errors, binding issues, crashes |
| `code-reviewer` | Review C#/XAML for quality and MAUI-specific issues |
| `secure-reviewer` | Read-only security audit (hardcoded keys, insecure storage) |
| `test-engineer` | Write xUnit/NUnit tests for ViewModels and Services |

### Hooks (run automatically)

| Hook | What It Does |
|------|-------------|
| `format-code.sh` | Auto-format .cs and .xaml files after every write/edit |
| `security-scan.sh` | Warn about hardcoded secrets |
| `context-tracker.py` | Show context window usage |

### Templates

| Template | What It Is |
|----------|-----------|
| `CLAUDE.md.template` | Reusable CLAUDE.md template for new MAUI projects |
| `.editorconfig` | C#/XAML formatting rules (copy to project root) |
| `.gitignore` | MAUI-specific gitignore (copy to project root) |

## Setup

### New Machine (Restore from Git)

```bash
git clone https://github.com/mistrypragnesh40/claude-maui-config.git ~/.claude/shared-maui
```

### Link to Any MAUI Project

```bash
~/.claude/shared-maui/setup-project.sh /path/to/your-maui-project
```

### Copy Templates to Project (Optional)

```bash
cp ~/.claude/shared-maui/templates/.editorconfig /path/to/your-project/
cp ~/.claude/shared-maui/templates/.gitignore /path/to/your-project/
cp ~/.claude/shared-maui/templates/CLAUDE.md.template /path/to/your-project/CLAUDE.md
# Then edit CLAUDE.md with project-specific details
```

### Global Skills (Separate Setup)

```bash
git clone https://github.com/luongnv89/claude-howto.git /tmp/claude-howto
cp -r /tmp/claude-howto/03-skills/code-review ~/.claude/skills/
cp -r /tmp/claude-howto/03-skills/refactor ~/.claude/skills/
rm -rf /tmp/claude-howto
```

## No Auto-Commits

Nothing in this config commits automatically. The only way a commit happens is if you type `/commit` and approve it.

| Type | Auto-runs? | Commits? |
|------|-----------|----------|
| Hooks | Yes | Never |
| Commands | Only when you type them | Only `/commit` and `/pr`, with your approval |
| Agents | When Claude needs them | Never |
