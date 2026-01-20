# Claude Code Sounds 🎸

Sound effects and notifications for [Claude Code](https://claude.ai/code) - the official CLI for Claude.

## Features

- **Rock Mode** 🎸 - Electric guitar riffs for all events
- **Quiet Mode** 🎵 - Subtle system sounds (Pop, Glass, Ping)
- **Mute Toggle** 🔇 - Quickly silence all sounds
- **Desktop Notifications** - Click to focus Claude Code window
- **Interactive Menu** - Easy mode switching with `claude-sound`

## Sound Events

| Event | Quiet Mode | Rock Mode |
|-------|------------|-----------|
| Submit (Enter) | Pop | Electric Guitar |
| Task Complete | Glass | Electric Guitar |
| Needs Attention | Ping | Electric Guitar |

## Requirements

- macOS
- [Claude Code](https://claude.ai/code)
- [terminal-notifier](https://github.com/julienXX/terminal-notifier) (for desktop notifications)

```bash
brew install terminal-notifier
```

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/claude-code-sounds.git
cd claude-code-sounds
./install.sh
```

Then restart Claude Code.

## Usage

### Switch Modes

```bash
claude-sound
```

This opens an interactive menu:

```
━━━━━━━━━━━━━━━━━━━━━━
  Claude Code 音效控制
━━━━━━━━━━━━━━━━━━━━━━
  当前模式: 🎵 安静
  静音状态: 否
━━━━━━━━━━━━━━━━━━━━━━

  1) 🎸 摇滚模式 (电吉他)
  2) 🎵 安静模式 (Pop)
  3) 🔇 切换静音
  q) 退出
```

## Customization

### Add Your Own Sounds

Place `.mp3` or `.aiff` files in `~/.claude/sounds/` and edit the scripts to include them.

### Adjust Volume

Edit the scripts and change the `-v` parameter (0.0 - 1.0):

```bash
afplay -v 0.3 "sound.mp3"  # 30% volume
```

### Change Notification App

Edit `~/.claude/settings.json` and replace the bundle ID:

```bash
# Find your app's bundle ID
osascript -e 'id of app "Terminal"'
```

## Uninstall

```bash
rm -rf ~/.claude/sounds
# Remove the alias from ~/.zshrc
# Remove hooks from ~/.claude/settings.json
```

## Credits

- Electric guitar sounds from [Pixabay](https://pixabay.com/) (Free for commercial use)
- System sounds from macOS

## License

MIT
