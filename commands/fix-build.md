---
name: Fix Build
description: Auto-diagnose and fix build errors in MAUI solution
allowed-tools: Bash(dotnet build:*), Bash(dotnet restore:*), Bash(dotnet list:*)
---

# Fix Build Errors

1. Run `dotnet build` and capture all errors
2. For each error, diagnose the cause:
   - **CS0246** (type not found): Check missing using statements or NuGet packages
   - **CS1061** (member not found): Check if method/property was renamed or moved
   - **CS0103** (name not found): Check for missing variable declarations
   - **XLS/XAML errors**: Check for typos in bindings, missing xmlns declarations, wrong property names
   - **NETSDK errors**: Check target framework, SDK version issues
   - **NU1xxx** (NuGet errors): Run `dotnet restore`, check package versions
3. Fix each error — make the minimal change needed
4. Run `dotnet build` again to verify
5. Repeat until build succeeds or report what couldn't be auto-fixed
