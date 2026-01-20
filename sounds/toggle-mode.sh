#!/bin/bash
# 切换音效模式：rock(电吉他) / quiet(安静)
# 用法: toggle-mode.sh [status] - 加 status 参数只显示当前模式不切换

MODE_FILE="$HOME/.claude/sounds/.mode"

# 读取当前模式，默认 quiet
current_mode="quiet"
if [ -f "$MODE_FILE" ]; then
    current_mode=$(cat "$MODE_FILE")
fi

# 如果参数是 status，只显示当前模式
if [ "$1" = "status" ]; then
    if [ "$current_mode" = "rock" ]; then
        echo "🎸 当前: 摇滚模式"
    else
        echo "🎵 当前: 安静模式"
    fi
    exit 0
fi

# 切换模式
if [ "$current_mode" = "rock" ]; then
    echo "quiet" > "$MODE_FILE"
    echo "🎵 已切换到安静模式 (Pop)"
else
    echo "rock" > "$MODE_FILE"
    echo "🎸 已切换到摇滚模式 (电吉他)"
fi
