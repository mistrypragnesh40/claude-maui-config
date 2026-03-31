---
description: Review changes, run build, and prepare a pull request
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(dotnet build:*), Bash(dotnet test:*)
---

# Pull Request Preparation

Before creating a PR, execute these steps:

1. Run build: `dotnet build`
2. Run tests (if available): `dotnet test`
3. Review git diff: `git diff HEAD`
4. Stage changes: `git add .`
5. Create commit message following conventional commits:
   - `fix:` for bug fixes
   - `feat:` for new features
   - `docs:` for documentation
   - `refactor:` for code restructuring
   - `test:` for test additions
   - `chore:` for maintenance

6. Generate PR summary including:
   - What changed and which files
   - Why it changed
   - Testing performed
   - Potential impacts on iOS/Android
