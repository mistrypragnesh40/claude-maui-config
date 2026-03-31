---
name: Build
description: Build the MAUI solution and show errors in a clean format
allowed-tools: Bash(dotnet build:*), Bash(dotnet restore:*)
---

# Build .NET MAUI Solution

1. Run `dotnet restore` if needed
2. Run `dotnet build` and capture output
3. Parse the output and present:
   - Total errors and warnings count
   - Each error: file path, line number, error code, message
   - Each warning: file path, line number, warning code, message
4. If build succeeds: confirm with "Build succeeded" and warning count
5. If build fails: list errors grouped by project, suggest fixes for common MAUI errors like:
   - Missing NuGet packages
   - XAML parsing errors
   - Missing platform targets
   - Resource generation failures
