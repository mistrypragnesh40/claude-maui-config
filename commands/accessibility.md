---
name: Accessibility Check
description: Check XAML files for missing accessibility labels and properties
allowed-tools: Bash(grep:*), Bash(find:*)
---

# Accessibility Audit for MAUI XAML

Scan XAML files for accessibility issues:

1. **Missing SemanticProperties.Description** on interactive elements:
   - Button, ImageButton, Image, Entry, Picker, Switch, CheckBox, Slider
   - Every tappable element needs a screen reader description

2. **Missing SemanticProperties.Hint** on input fields:
   - Entry, Editor, Picker, DatePicker, TimePicker
   - Hints tell users what to enter

3. **Missing AutomationId** on key elements:
   - Needed for UI testing (Appium)
   - Every testable element should have one

4. **Images without descriptions**:
   - All Image and ImageButton need SemanticProperties.Description
   - Decorative images should use `SemanticProperties.Description=""`

5. **Color contrast issues**:
   - Check for light text on light backgrounds
   - Check for hardcoded colors that may not work in dark/light mode

6. **Touch target size**:
   - Buttons and tappable areas should be at least 44x44 points

Present findings grouped by file with line numbers and suggested fixes.
