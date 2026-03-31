---
name: Performance Check
description: Find performance issues in MAUI C# and XAML code
allowed-tools: Bash(grep:*), Bash(find:*)
---

# Performance Audit for .NET MAUI

Scan for common MAUI performance issues:

1. **Main thread blocking**:
   - `.Result` or `.Wait()` on async tasks (deadlock risk)
   - `Thread.Sleep()` on main thread
   - Heavy computation without `Task.Run()`

2. **ListView/CollectionView issues**:
   - Using `ListView` instead of `CollectionView` (CollectionView is faster)
   - Missing `RecycleElement` caching strategy on ListView
   - `HasUnevenRows="True"` without need (forces re-measurement)
   - Large `ItemTemplate` with nested layouts

3. **Image issues**:
   - Large images without size constraints (WidthRequest/HeightRequest)
   - Missing `Aspect` property on images
   - Loading full-size images for thumbnails
   - Not using `CachedImage` or image caching

4. **Layout performance**:
   - Deeply nested StackLayouts (use Grid instead)
   - Excessive `AbsoluteLayout` or `RelativeLayout` usage
   - `IsVisible="False"` elements still in layout tree (use `IsVisible` with binding)

5. **Memory leaks**:
   - Event handlers not unsubscribed (`+=` without `-=`)
   - Missing `IDisposable` on pages with subscriptions
   - Static event references holding page instances

6. **Network**:
   - API calls without caching
   - Multiple sequential API calls (should be parallel with `Task.WhenAll`)
   - Large payloads without pagination

Present findings with file:line, severity (Critical/High/Medium), and suggested fix.
