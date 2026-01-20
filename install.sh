#!/bin/bash
# Claude Code Sounds Installer

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOUNDS_DIR="$HOME/.claude/sounds"
SETTINGS_FILE="$HOME/.claude/settings.json"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Claude Code Sounds Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for terminal-notifier
if ! command -v terminal-notifier &> /dev/null; then
    echo "⚠️  terminal-notifier not found. Install it for desktop notifications:"
    echo "   brew install terminal-notifier"
    echo ""
    read -p "Continue without notifications? [y/N]: " cont
    if [[ ! "$cont" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
fi

# Detect terminal app
echo "Which app do you use Claude Code in?"
echo "  1) Cursor"
echo "  2) VS Code"
echo "  3) Terminal"
echo "  4) iTerm"
echo "  5) Other (skip click-to-focus)"
read -p "Select [1-5]: " app_choice

case $app_choice in
    1) BUNDLE_ID="com.todesktop.230313mzl4w4u92" ;;
    2) BUNDLE_ID="com.microsoft.VSCode" ;;
    3) BUNDLE_ID="com.apple.Terminal" ;;
    4) BUNDLE_ID="com.googlecode.iterm2" ;;
    *) BUNDLE_ID="" ;;
esac

# Create sounds directory
echo ""
echo "📁 Creating sounds directory..."
mkdir -p "$SOUNDS_DIR"

# Copy sound files
echo "🎵 Copying sound files..."
cp "$SCRIPT_DIR/sounds/"*.sh "$SOUNDS_DIR/"
cp "$SCRIPT_DIR/sounds/"*.mp3 "$SOUNDS_DIR/"
chmod +x "$SOUNDS_DIR/"*.sh

# Update file paths in scripts
echo "🔧 Configuring scripts..."
for script in "$SOUNDS_DIR"/*.sh; do
    # Update mp3 paths (remove _副本 if present)
    sed -i '' 's/_副本\.mp3/.mp3/g' "$script" 2>/dev/null || true
done

# Create/update settings.json
echo "⚙️  Configuring Claude Code hooks..."

if [ -n "$BUNDLE_ID" ]; then
    ACTIVATE_FLAG=" -activate $BUNDLE_ID"
else
    ACTIVATE_FLAG=""
fi

# Backup existing settings
if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
    echo "   (Backed up existing settings to settings.json.backup)"
fi

cat > "$SETTINGS_FILE" << EOF
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/sounds/submit-sound.sh"
          }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/sounds/notification-sound.sh & terminal-notifier -title 'Claude Code' -message '需要你的注意'$ACTIVATE_FLAG"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/sounds/random-sound.sh & terminal-notifier -title 'Claude Code' -message '任务完成'$ACTIVATE_FLAG"
          }
        ]
      }
    ]
  }
}
EOF

# Add alias to shell config
echo "🐚 Adding shell alias..."
SHELL_RC="$HOME/.zshrc"
if [ -f "$HOME/.bashrc" ] && [ ! -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if ! grep -q "claude-sound" "$SHELL_RC" 2>/dev/null; then
    echo '' >> "$SHELL_RC"
    echo '# Claude Code Sounds' >> "$SHELL_RC"
    echo 'alias claude-sound="~/.claude/sounds/claude-sound.sh"' >> "$SHELL_RC"
fi

# Set default mode
echo "quiet" > "$SOUNDS_DIR/.mode"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Installation complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "  1. Run: source ~/.zshrc"
echo "  2. Restart Claude Code"
echo "  3. Use 'claude-sound' to switch modes"
echo ""
