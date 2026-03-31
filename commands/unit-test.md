---
name: Expand Unit Tests
description: Generate unit tests for C# ViewModels, Services, and logic
allowed-tools: Bash(dotnet test:*), Bash(dotnet build:*)
tags: testing, coverage, unit-tests
---

# Expand Unit Tests for .NET MAUI

Generate unit tests for the project using NUnit or xUnit:

1. **Analyze coverage**: Identify untested ViewModels, Services, and helpers
2. **Identify gaps**: Look for untested logic branches, error paths, null inputs, edge cases
3. **Write tests** using project's test framework (NUnit/xUnit/MSTest):
   - Test ViewModel commands and property changes
   - Test Service methods and API calls
   - Test data transformations and mappers
   - Test navigation logic
4. **Target specific scenarios**:
   - Error handling and exceptions
   - Null/empty input handling
   - INotifyPropertyChanged firing correctly
   - Command CanExecute logic
   - Async method behavior
5. **Follow existing patterns**: Match naming conventions and project structure

Present new test code. Follow existing test project patterns.
