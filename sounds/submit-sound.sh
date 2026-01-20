#!/bin/bash
# 回车音效 - 根据模式播放

# 检查是否静音
MUTE_FILE="$HOME/.claude/sounds/.muted"
if [ -f "$MUTE_FILE" ]; then
    exit 0
fi

# 读取当前模式
MODE_FILE="$HOME/.claude/sounds/.mode"
current_mode="quiet"
if [ -f "$MODE_FILE" ]; then
    current_mode=$(cat "$MODE_FILE")
fi

if [ "$current_mode" = "rock" ]; then
    # 摇滚模式：随机电吉他 (音量 0.3)
    sounds=(
        "$HOME/.claude/sounds/electric-guitar-86322.mp3"
        "$HOME/.claude/sounds/electric-guitar-metal-riff-107087.mp3"
        "$HOME/.claude/sounds/guitar-jingle-hard-rock-style-21867.mp3"
        "$HOME/.claude/sounds/guitar-plug-and-play-106347.mp3"
        "$HOME/.claude/sounds/rake-guitar-dry-83757.mp3"
    )
    random_index=$((RANDOM % ${#sounds[@]}))
    afplay -v 0.3 "${sounds[$random_index]}"
else
    # 安静模式：Pop
    afplay /System/Library/Sounds/Pop.aiff
fi
