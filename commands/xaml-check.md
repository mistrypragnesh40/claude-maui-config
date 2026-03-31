---
name: XAML Binding Check
description: Validate XAML bindings match ViewModel properties
allowed-tools: Bash(grep:*), Bash(find:*)
---

# XAML Binding Validator

For each XAML file and its code-behind/ViewModel pair:

1. **Find all bindings** in the XAML file:
   - `{Binding PropertyName}`
   - `{Binding Path=PropertyName}`
   - `Command="{Binding CommandName}"`
   - `ItemsSource="{Binding CollectionName}"`

2. **Find the corresponding ViewModel**:
   - Check `x:DataType` attribute in XAML
   - Check `BindingContext` assignment in code-behind
   - Match by naming convention (MyPage.xaml → MyViewModel.cs)

3. **Verify each binding exists** in the ViewModel:
   - Property exists with matching name
   - Property is public
   - Commands exist as ICommand or RelayCommand
   - Collections are ObservableCollection (not List)

4. **Report mismatches**:
   - Binding references a property that doesn't exist in ViewModel
   - Property exists but is private (not accessible from XAML)
   - Collection bound but not ObservableCollection (won't update UI)
   - Command bound but not declared as ICommand
   - Typos in binding names (suggest closest match)

Present findings as: XAML file:line → expected property → status (found/missing/typo)
