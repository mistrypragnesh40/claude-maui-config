#!/bin/bash

# Usage: ./setup-copilot.sh /path/to/your-maui-project
#
# Sets up GitHub Copilot custom instructions for a .NET MAUI project.
# Copies copilot-instructions.md into the project's .github/ folder
# and optionally copies .editorconfig and .gitignore templates.

PROJECT_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "$PROJECT_DIR" ]; then
    echo "Usage: ./setup-copilot.sh /path/to/your-maui-project"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: $PROJECT_DIR does not exist"
    exit 1
fi

# Create .github directory if it doesn't exist
mkdir -p "$PROJECT_DIR/.github"

# Copy copilot instructions
if [ -f "$PROJECT_DIR/.github/copilot-instructions.md" ]; then
    echo "copilot-instructions.md already exists — skipping (remove manually to replace)"
else
    cp "$SCRIPT_DIR/copilot-instructions.md" "$PROJECT_DIR/.github/copilot-instructions.md"
    echo "Copied: .github/copilot-instructions.md"
fi

# Copy .editorconfig if not present
if [ ! -f "$PROJECT_DIR/.editorconfig" ]; then
    if [ -f "$REPO_DIR/templates/.editorconfig" ]; then
        cp "$REPO_DIR/templates/.editorconfig" "$PROJECT_DIR/.editorconfig"
        echo "Copied: .editorconfig"
    fi
else
    echo ".editorconfig already exists — skipping"
fi

# Copy .gitignore if not present
if [ ! -f "$PROJECT_DIR/.gitignore" ]; then
    if [ -f "$REPO_DIR/templates/.gitignore" ]; then
        cp "$REPO_DIR/templates/.gitignore" "$PROJECT_DIR/.gitignore"
        echo "Copied: .gitignore"
    fi
else
    echo ".gitignore already exists — skipping"
fi

echo ""
echo "Done! Copilot is configured for your MAUI project."
echo ""
echo "Make sure you have the GitHub Copilot extension installed in VS Code."
echo "Copilot will automatically read .github/copilot-instructions.md."
