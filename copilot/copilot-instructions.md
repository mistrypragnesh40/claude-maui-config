# .NET MAUI Development Instructions

You are assisting with a .NET MAUI mobile application. Follow these rules and guidelines strictly.

## Project Standards

- **Architecture**: MVVM pattern (ViewModels + XAML Views)
- **Language**: C# (.cs) and XAML (.xaml)
- **Naming**: PascalCase for classes, methods, properties. camelCase for local variables
- **ViewModels**: Inherit from BaseViewModel, use CommunityToolkit.Mvvm (ObservableObject, RelayCommand)
- **Navigation**: Shell navigation with registered routes
- **Async**: Always use async/await. NEVER block with `.Result` or `.Wait()`
- **DI**: Register services, ViewModels, and Pages in MauiProgram.cs

## Security Rules

- NEVER hardcode API keys, passwords, or connection strings in source code
- Always use `SecureStorage` for sensitive data, not `Preferences`
- Use HTTPS for all network calls — never HTTP
- Never log sensitive data (passwords, tokens, PII) via `Debug.WriteLine` or `Console.WriteLine`
- Validate all user input before processing
- Check for hardcoded secrets patterns: `password\s*=`, `apiKey\s*=`, `Bearer`, `connectionString\s*=`
- Never include private keys or service account JSON in source code

## Performance Rules

### Main Thread
- Never use `.Result` or `.Wait()` on async tasks (deadlock risk)
- Never use `Thread.Sleep()` on main thread
- Use `Task.Run()` for heavy computation

### ListView / CollectionView
- Prefer `CollectionView` over `ListView` (better performance)
- Always set `RecycleElement` caching strategy on ListView
- Avoid `HasUnevenRows="True"` unless necessary (forces re-measurement)
- Keep `ItemTemplate` lightweight — avoid deeply nested layouts

### Images
- Always set `WidthRequest`/`HeightRequest` on images
- Always set `Aspect` property
- Don't load full-size images for thumbnails
- Use image caching (FFImageLoading or equivalent)

### Layout
- Prefer `Grid` over deeply nested `StackLayout`
- Minimize use of `AbsoluteLayout` and `RelativeLayout`
- Elements with `IsVisible="False"` remain in layout tree — bind visibility

### Memory
- Always unsubscribe event handlers (`+=` must have matching `-=`)
- Implement `IDisposable` on pages with subscriptions
- Avoid static event references holding page instances

### Network
- Cache API responses where appropriate
- Use `Task.WhenAll` for multiple independent API calls (not sequential)
- Paginate large datasets

## XAML Rules

### Bindings
- `{Binding PropertyName}` must match a public property in the ViewModel
- Commands must be declared as `ICommand` or `[RelayCommand]`
- Collections bound to UI must be `ObservableCollection<T>`, not `List<T>`
- Always set `x:DataType` for compiled bindings
- BindingContext must be set correctly (DI constructor injection or code-behind)

### Accessibility
- Every interactive element (Button, ImageButton, Entry, Picker, Switch, CheckBox, Slider) must have `SemanticProperties.Description`
- Input fields (Entry, Editor, Picker, DatePicker, TimePicker) should have `SemanticProperties.Hint`
- All Image/ImageButton must have `SemanticProperties.Description` (use empty string for decorative images)
- Touch targets must be at least 44x44 points
- Avoid hardcoded colors that break in dark/light mode — use `AppThemeBinding` or `DynamicResource`
- Add `AutomationId` on key elements for UI testing (Appium)

## Code Quality

### Structure
- Methods should be under 50 lines
- Classes should be under 300 lines
- Methods should have fewer than 4 parameters — use parameter objects for more
- No duplicate code — extract to shared methods if repeated 3+ times
- Comments explain WHY, not WHAT

### SOLID Principles
- **Single Responsibility**: One class, one reason to change
- **Open/Closed**: Extend behavior without modifying existing code
- **Liskov Substitution**: Subclasses must be substitutable for base classes
- **Interface Segregation**: Small, focused interfaces
- **Dependency Inversion**: Depend on abstractions, not implementations

### Common Code Smells to Avoid
- Long methods (>50 lines) — extract methods
- Duplicate code — extract shared logic
- Large classes — split responsibilities
- Feature envy (method uses another class's data more than its own) — move the method
- Primitive obsession (strings for emails, ints for money) — create value types
- Switch statements on type codes — use polymorphism
- Dead code — remove it completely

## Testing Guidelines

- Use xUnit or NUnit with NSubstitute/Moq for mocking
- Test ViewModels: commands, property changes, INotifyPropertyChanged, navigation
- Test Services: API calls (mocked), data transformations, error handling
- Test Helpers/Utilities: pure logic, string formatting, calculations
- Test error paths, null inputs, and edge cases
- Follow Arrange-Act-Assert pattern
- Name tests: `MethodName_WhenCondition_ExpectedResult`
- Coverage targets: 80%+ ViewModels, 90%+ Services, 100% auth/data handling

## Commit Messages

Follow conventional commits:
- `feat:` new features
- `fix:` bug fixes
- `docs:` documentation changes
- `refactor:` code restructuring
- `test:` test additions
- `chore:` maintenance tasks

## MAUI-Specific Gotchas

- BindingContext must be set before bindings resolve
- `INotifyPropertyChanged` must fire for ALL bound properties
- Shell routes must be registered in `AppShell.xaml.cs` before navigation
- Platform-specific code uses `#if ANDROID`, `#if IOS`, `#if MACCATALYST`
- Images and resources must be in correct platform folders
- `Disposable` resources must be properly disposed
- `CommunityToolkit.Maui` must be initialized with `.UseMauiCommunityToolkit()` in MauiProgram.cs

## New Project Scaffold

When creating a new MAUI project, use this folder structure:
```
ProjectName/
  Models/
  ViewModels/
    BaseViewModel.cs
  Views/
  Services/
  Helpers/
  Converters/
  Controls/
  Resources/
    Styles/
    Fonts/
    Images/
  Platforms/
    Android/
    iOS/
  MauiProgram.cs
  App.xaml / App.xaml.cs
  AppShell.xaml / AppShell.xaml.cs
```

Essential packages:
- `CommunityToolkit.Mvvm` — MVVM infrastructure
- `CommunityToolkit.Maui` — UI helpers
- `System.Text.Json` — JSON serialization

## NuGet Package Safety

- Check `dotnet list package --vulnerable` regularly
- Check `dotnet list package --outdated` for updates
- Be cautious with major version upgrades (breaking changes)
- Never ignore Critical/High severity vulnerabilities

## Refactoring Approach

When refactoring:
1. Ensure tests exist and pass before starting
2. Make small, incremental changes
3. Test after every change
4. Use conventional commit messages for each refactoring step
5. Never combine refactoring with feature additions
6. Never refactor code you don't understand — read it first
