---
name: New MAUI Project
description: Scaffold a new .NET MAUI project with proper MVVM architecture using CommunityToolkit.Mvvm
allowed-tools: Bash(dotnet new:*), Bash(dotnet add:*), Bash(dotnet restore:*), Bash(dotnet build:*), Bash(mkdir:*), Bash(chmod:*)
argument-hint: <project-name> [--path /optional/path]
---

# Scaffold New .NET MAUI Project

Create a production-ready .NET MAUI project with proper MVVM architecture.

## Arguments
- `$ARGUMENTS` should contain the project name (e.g., `MyApp`)
- Optional: `--path /custom/path` to specify location

## Steps

### 1. Create MAUI Project
```bash
dotnet new maui -n <ProjectName> -o <path>
```

### 2. Add Essential NuGet Packages
```bash
# MVVM
dotnet add package CommunityToolkit.Mvvm
dotnet add package CommunityToolkit.Maui

# Navigation & DI (built into MAUI but ensure latest)
# Already included in MAUI template

# Networking
dotnet add package System.Text.Json

# Secure Storage (built into MAUI Essentials)
# Already included

# Image caching (optional but recommended)
# dotnet add package FFImageLoading.Maui
```

### 3. Create MVVM Folder Structure
```
<ProjectName>/
├── Models/
│   └── BaseModel.cs
├── ViewModels/
│   ├── BaseViewModel.cs
│   └── MainViewModel.cs
├── Views/
│   ├── MainPage.xaml
│   └── MainPage.xaml.cs
├── Services/
│   ├── INavigationService.cs
│   ├── NavigationService.cs
│   ├── IApiService.cs
│   └── ApiService.cs
├── Helpers/
│   └── Constants.cs
├── Converters/
│   └── BoolToColorConverter.cs
├── Controls/
│   └── (custom controls go here)
├── Resources/
│   ├── Styles/
│   ├── Fonts/
│   ├── Images/
│   └── Raw/
├── Platforms/
│   ├── Android/
│   └── iOS/
├── MauiProgram.cs
├── App.xaml
├── App.xaml.cs
├── AppShell.xaml
└── AppShell.xaml.cs
```

### 4. Create BaseViewModel

```csharp
// ViewModels/BaseViewModel.cs
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace <ProjectName>.ViewModels;

public partial class BaseViewModel : ObservableObject
{
    [ObservableProperty]
    private bool _isBusy;

    [ObservableProperty]
    private string _title = string.Empty;

    [ObservableProperty]
    private bool _isRefreshing;

    public bool IsNotBusy => !IsBusy;

    protected async Task ExecuteAsync(Func<Task> operation, Action<Exception>? onError = null)
    {
        if (IsBusy) return;

        try
        {
            IsBusy = true;
            await operation();
        }
        catch (Exception ex)
        {
            onError?.Invoke(ex);
            await Shell.Current.DisplayAlert("Error", ex.Message, "OK");
        }
        finally
        {
            IsBusy = false;
        }
    }
}
```

### 5. Create Sample MainViewModel

```csharp
// ViewModels/MainViewModel.cs
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace <ProjectName>.ViewModels;

public partial class MainViewModel : BaseViewModel
{
    public MainViewModel()
    {
        Title = "Home";
    }

    [RelayCommand]
    private async Task LoadDataAsync()
    {
        await ExecuteAsync(async () =>
        {
            // Load your data here
            await Task.Delay(100); // Replace with actual API call
        });
    }
}
```

### 6. Create ApiService

```csharp
// Services/IApiService.cs
namespace <ProjectName>.Services;

public interface IApiService
{
    Task<T?> GetAsync<T>(string endpoint);
    Task<T?> PostAsync<T>(string endpoint, object data);
}

// Services/ApiService.cs
using System.Net.Http.Json;

namespace <ProjectName>.Services;

public class ApiService : IApiService
{
    private readonly HttpClient _httpClient;

    public ApiService()
    {
        _httpClient = new HttpClient
        {
            BaseAddress = new Uri(Constants.ApiBaseUrl)
        };
    }

    public async Task<T?> GetAsync<T>(string endpoint)
    {
        var response = await _httpClient.GetAsync(endpoint);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadFromJsonAsync<T>();
    }

    public async Task<T?> PostAsync<T>(string endpoint, object data)
    {
        var response = await _httpClient.PostAsJsonAsync(endpoint, data);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadFromJsonAsync<T>();
    }
}
```

### 7. Create Constants

```csharp
// Helpers/Constants.cs
namespace <ProjectName>;

public static class Constants
{
    // NEVER hardcode secrets here — use SecureStorage or backend config
    public const string ApiBaseUrl = "https://api.example.com/";
}
```

### 8. Create Sample Converter

```csharp
// Converters/BoolToColorConverter.cs
using System.Globalization;

namespace <ProjectName>.Converters;

public class BoolToColorConverter : IValueConverter
{
    public object Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        if (value is bool boolValue)
            return boolValue ? Colors.Green : Colors.Red;
        return Colors.Gray;
    }

    public object ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}
```

### 9. Update MainPage.xaml with MVVM Binding

```xml
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:vm="clr-namespace:<ProjectName>.ViewModels"
             x:Class="<ProjectName>.Views.MainPage"
             x:DataType="vm:MainViewModel"
             Title="{Binding Title}">

    <RefreshView Command="{Binding LoadDataCommand}"
                 IsRefreshing="{Binding IsRefreshing}">
        <VerticalStackLayout Padding="20" Spacing="15">

            <Label Text="Welcome to <ProjectName>"
                   FontSize="24"
                   HorizontalOptions="Center"
                   SemanticProperties.HeadingLevel="Level1"
                   SemanticProperties.Description="Welcome heading" />

            <ActivityIndicator IsRunning="{Binding IsBusy}"
                               IsVisible="{Binding IsBusy}"
                               Color="{StaticResource Primary}" />

        </VerticalStackLayout>
    </RefreshView>
</ContentPage>
```

### 10. Register DI in MauiProgram.cs

```csharp
// MauiProgram.cs
using CommunityToolkit.Maui;
using <ProjectName>.Services;
using <ProjectName>.ViewModels;
using <ProjectName>.Views;

namespace <ProjectName>;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            .UseMauiApp<App>()
            .UseMauiCommunityToolkit()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
            });

        // Services
        builder.Services.AddSingleton<IApiService, ApiService>();

        // ViewModels
        builder.Services.AddTransient<MainViewModel>();

        // Pages
        builder.Services.AddTransient<MainPage>();

        return builder.Build();
    }
}
```

### 11. Register Shell Route

```csharp
// AppShell.xaml.cs
using <ProjectName>.Views;

namespace <ProjectName>;

public partial class AppShell : Shell
{
    public AppShell()
    {
        InitializeComponent();

        // Register routes for navigation
        // Routing.RegisterRoute(nameof(DetailPage), typeof(DetailPage));
    }
}
```

### 12. Create Test Project

```bash
dotnet new xunit -n <ProjectName>.Tests -o tests/<ProjectName>.Tests
dotnet add tests/<ProjectName>.Tests/package NSubstitute
dotnet add tests/<ProjectName>.Tests/package FluentAssertions
dotnet add tests/<ProjectName>.Tests reference <path-to-main-project>
```

### 13. Create CLAUDE.md for the New Project

Copy from template and fill in project-specific details.

### 14. Link to Shared Claude Config

```bash
~/.claude/shared-maui/setup-project.sh <project-path>
```

### 15. Copy Templates

```bash
cp ~/.claude/shared-maui/templates/.editorconfig <project-path>/
cp ~/.claude/shared-maui/templates/.gitignore <project-path>/
```

### 16. Initialize Git

```bash
cd <project-path>
git init
git add -A
git commit -m "Initial scaffold: .NET MAUI with MVVM architecture"
```

### 17. Verify

```bash
dotnet build
```

Build should succeed with zero errors. The project is ready for development.
