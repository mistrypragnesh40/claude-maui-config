#!/bin/bash

# Usage: ./setup-project.sh /path/to/your-maui-project
#
# Links shared MAUI Claude config (commands, agents, hooks)
# to any project. No files are copied — all projects
# share the same source.

PROJECT_DIR="$1"
SHARED_DIR="$HOME/.claude/shared-maui"

if [ -z "$PROJECT_DIR" ]; then
    echo "Usage: ./setup-project.sh /path/to/your-maui-project"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: $PROJECT_DIR does not exist"
    exit 1
fi

# Create .claude directory if it doesn't exist
mkdir -p "$PROJECT_DIR/.claude"

# Symlink commands
if [ -e "$PROJECT_DIR/.claude/commands" ]; then
    echo "commands/ already exists — skipping (remove manually to re-link)"
else
    ln -s "$SHARED_DIR/commands" "$PROJECT_DIR/.claude/commands"
    echo "Linked: commands/"
fi

# Symlink agents
if [ -e "$PROJECT_DIR/.claude/agents" ]; then
    echo "agents/ already exists — skipping (remove manually to re-link)"
else
    ln -s "$SHARED_DIR/agents" "$PROJECT_DIR/.claude/agents"
    echo "Linked: agents/"
fi

# Symlink hooks
if [ -e "$PROJECT_DIR/.claude/hooks" ]; then
    echo "hooks/ already exists — skipping (remove manually to re-link)"
else
    ln -s "$SHARED_DIR/hooks" "$PROJECT_DIR/.claude/hooks"
    echo "Linked: hooks/"
fi

# Create settings.local.json with hook config if it doesn't exist
if [ ! -f "$PROJECT_DIR/.claude/settings.local.json" ]; then
    cat > "$PROJECT_DIR/.claude/settings.local.json" << 'EOF'
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\"",
            "timeout": 5
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\"",
            "timeout": 5
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/format-code.sh\"",
            "timeout": 30
          },
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.sh\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
EOF
    echo "Created: settings.local.json"
else
    echo "settings.local.json already exists — skipping"
fi

echo ""
echo "Done! Project linked to shared MAUI config."
echo "Note: CLAUDE.md should be created manually per project."
