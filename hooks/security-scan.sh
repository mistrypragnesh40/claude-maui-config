#!/bin/bash

# Security scan — checks for hardcoded secrets in C# and XAML files
# Runs as PostToolUse hook on Write|Edit events

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))" 2>/dev/null)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))" 2>/dev/null)

if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
    exit 0
fi

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

WARNINGS=""

# Hardcoded passwords
if grep -qiE "(password|passwd|pwd)\s*=\s*\"[^\"]+\"" "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}Potential hardcoded password. "
fi

# API keys
if grep -qiE "(api[_-]?key|apikey|access[_-]?token)\s*=\s*\"[^\"]+\"" "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}Potential hardcoded API key. "
fi

# Connection strings with passwords
if grep -qiE "Password=\w+" "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}Potential hardcoded connection string password. "
fi

# AWS keys
if grep -qE "AKIA[0-9A-Z]{16}" "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}AWS access key detected. "
fi

# Private keys
if grep -q "BEGIN.*PRIVATE KEY" "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}Private key detected. "
fi

# Firebase/Google service account
if grep -qE "\"private_key\":" "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}Service account key detected. "
fi

if [ -n "$WARNINGS" ]; then
    echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PostToolUse\",\"additionalContext\":\"SECURITY WARNING in $FILE_PATH: $WARNINGS\"}}"
fi

exit 0
