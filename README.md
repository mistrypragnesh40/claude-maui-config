# Shared MAUI AI Config

Shared configuration for AI-assisted .NET MAUI development. Supports **Claude Code** and **GitHub Copilot**.

## What's Included

### Claude Code (full feature set)

| Feature | Contents |
|---------|----------|
| **Commands** | `/build`, `/fix-build`, `/commit`, `/pr`, `/unit-test`, `/optimize`, `/doc-refactor`, `/nuget-audit`, `/accessibility`, `/xaml-check`, `/perf` |
| **Agents** | `debugger`, `code-reviewer`, `secure-reviewer`, `test-engineer` |
| **Hooks** | Auto-format on save, security scan on save, context tracker |
| **Skills** | Code review (with scripts + templates), Refactoring (Fowler methodology) |
| **Templates** | `CLAUDE.md`, `.editorconfig`, `.gitignore` |

### GitHub Copilot

| Feature | Contents |
|---------|----------|
| **Instructions** | `.github/copilot-instructions.md` — consolidated MAUI rules covering security, performance, accessibility, code quality, testing, XAML bindings, and refactoring |
| **Templates** | `.editorconfig`, `.gitignore` (shared with Claude) |

> Copilot doesn't support slash commands, agents, hooks, or skills — all guidance is consolidated into a single instructions file that Copilot reads automatically.

---

## Setup — Claude Code

### 1. Clone the config

```bash
git clone https://github.com/mistrypragnesh40/claude-maui-config.git ~/.claude/shared-maui
```

### 2. Link to any MAUI project

```bash
~/.claude/shared-maui/setup-project.sh /path/to/your-maui-project
```

### 3. Copy templates (optional)

```bash
cp ~/.claude/shared-maui/templates/.editorconfig /path/to/your-project/
cp ~/.claude/shared-maui/templates/.gitignore /path/to/your-project/
cp ~/.claude/shared-maui/templates/CLAUDE.md.template /path/to/your-project/CLAUDE.md
# Then edit CLAUDE.md with project-specific details
```

### 4. Install global skills (optional)

```bash
cp -r ~/.claude/shared-maui/skills/code-review ~/.claude/skills/
cp -r ~/.claude/shared-maui/skills/refactor ~/.claude/skills/
```

---

## Setup — GitHub Copilot

### 1. Clone the config (if not already done)

```bash
git clone https://github.com/mistrypragnesh40/claude-maui-config.git ~/.claude/shared-maui
```

### 2. Run the Copilot setup script

```bash
~/.claude/shared-maui/copilot/setup-copilot.sh /path/to/your-maui-project
```

This copies:
- `.github/copilot-instructions.md` — Copilot reads this automatically
- `.editorconfig` — shared formatting rules
- `.gitignore` — MAUI-specific ignores

### 3. That's it

Copilot in VS Code will automatically pick up the instructions from `.github/copilot-instructions.md`. No extension configuration needed.

---

## Using Both Together

You can set up both Claude Code and Copilot for the same project:

```bash
# Clone once
git clone https://github.com/mistrypragnesh40/claude-maui-config.git ~/.claude/shared-maui

# Set up Claude Code
~/.claude/shared-maui/setup-project.sh /path/to/your-project

# Set up Copilot
~/.claude/shared-maui/copilot/setup-copilot.sh /path/to/your-project
```

They don't conflict — Claude uses `.claude/` and Copilot uses `.github/`.

---

## Feature Comparison

| Feature | Claude Code | Copilot |
|---------|:-----------:|:-------:|
| Custom instructions | CLAUDE.md | copilot-instructions.md |
| Slash commands | 11 commands | Not supported |
| AI agents | 4 agents | Not supported |
| Auto-format on save | Hook | Not supported |
| Security scan on save | Hook | Not supported |
| Context tracking | Hook | Not supported |
| Code review skill | Full workflow | Instructions only |
| Refactoring skill | Fowler methodology | Instructions only |
| .editorconfig | Shared | Shared |
| .gitignore | Shared | Shared |

---

## No Auto-Commits

Nothing in this config commits automatically. The only way a commit happens is if you explicitly request it.

| Type | Auto-runs? | Commits? |
|------|-----------|----------|
| Hooks | Yes (Claude only) | Never |
| Commands | Only when you type them (Claude only) | Only `/commit` and `/pr`, with your approval |
| Agents | When Claude needs them | Never |
| Copilot instructions | Always active | Never |
