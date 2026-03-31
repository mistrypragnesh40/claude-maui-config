#!/bin/bash

# Auto-format XAML and C# files after Claude writes or edits them
# Runs as a PostToolUse hook on Write|Edit events

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))" 2>/dev/null)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))" 2>/dev/null)

# Only run on Write or Edit
if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
    exit 0
fi

# Skip if file path is empty or file doesn't exist
if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

case "$FILE_PATH" in
    # C# files — format with dotnet format
    *.cs)
        if command -v dotnet &>/dev/null; then
            dotnet format whitespace --include "$FILE_PATH" --folder 2>/dev/null
            if [ $? -ne 0 ]; then
                # Fallback: try dotnet-csharpier if installed
                if command -v dotnet-csharpier &>/dev/null; then
                    dotnet-csharpier "$FILE_PATH" 2>/dev/null
                fi
            fi
        fi
        ;;

    # XAML files — format with xmllint (basic indent formatting)
    *.xaml)
        if command -v xmllint &>/dev/null; then
            TEMP_FILE=$(mktemp)
            xmllint --format "$FILE_PATH" > "$TEMP_FILE" 2>/dev/null
            if [ $? -eq 0 ] && [ -s "$TEMP_FILE" ]; then
                mv "$TEMP_FILE" "$FILE_PATH"
            else
                rm -f "$TEMP_FILE"
            fi
        fi
        ;;
esac

exit 0
