---
name: NuGet Audit
description: Check for vulnerable or outdated NuGet packages
allowed-tools: Bash(dotnet list:*), Bash(dotnet restore:*)
---

# NuGet Security Audit

1. Run `dotnet list package --vulnerable` to find packages with known security vulnerabilities
2. Run `dotnet list package --outdated` to find packages with newer versions available
3. Present findings:

   **Vulnerable packages** (fix immediately):
   - Package name, current version, vulnerability severity, advisory URL

   **Outdated packages** (update when possible):
   - Package name, current version, latest version

4. For vulnerable packages, suggest the safe version to upgrade to
5. Warn about major version upgrades that may have breaking changes (e.g., Syncfusion, CommunityToolkit)
