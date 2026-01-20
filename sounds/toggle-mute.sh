#!/bin/bash
# 切换静音状态

MUTE_FILE="$HOME/.claude/sounds/.muted"

if [ -f "$MUTE_FILE" ]; then
    rm "$MUTE_FILE"
    echo "🔊 Claude 音效已开启"
else
    touch "$MUTE_FILE"
    echo "🔇 Claude 音效已静音"
fi
