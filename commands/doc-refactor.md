---
name: Documentation Refactor
description: Refactor and document messy C# or XAML code
tags: documentation, refactoring
---

# Documentation Refactor for .NET MAUI

Refactor and document the specified code:

1. **Analyze**: Read the target file, understand its purpose and dependencies
2. **Refactor**: Clean up naming, extract methods, reduce complexity
3. **Document**: Add XML doc comments to public classes, methods, and properties
4. **Verify**: Run `dotnet build` to confirm no breaking changes

Rules:
- Keep behavior identical — refactor structure only
- Follow C# XML documentation format (`/// <summary>`)
- Use meaningful method names that describe intent
- Keep XAML comments minimal — structure should be self-documenting
