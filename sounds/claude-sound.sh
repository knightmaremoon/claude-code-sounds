#!/bin/bash
# Claude Code 音效控制

MODE_FILE="$HOME/.claude/sounds/.mode"
MUTE_FILE="$HOME/.claude/sounds/.muted"

# 读取当前状态
current_mode="quiet"
if [ -f "$MODE_FILE" ]; then
    current_mode=$(cat "$MODE_FILE")
fi

is_muted="否"
if [ -f "$MUTE_FILE" ]; then
    is_muted="是"
fi

# 显示当前状态
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo "  Claude Code 音效控制"
echo "━━━━━━━━━━━━━━━━━━━━━━"
if [ "$current_mode" = "rock" ]; then
    echo "  当前模式: 🎸 摇滚"
else
    echo "  当前模式: 🎵 安静"
fi
echo "  静音状态: $is_muted"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  1) 🎸 摇滚模式 (电吉他)"
echo "  2) 🎵 安静模式 (Pop)"
echo "  3) 🔇 切换静音"
echo "  q) 退出"
echo ""
read -p "  选择 [1/2/3/q]: " choice

case $choice in
    1)
        echo "rock" > "$MODE_FILE"
        echo "🎸 已切换到摇滚模式"
        ;;
    2)
        echo "quiet" > "$MODE_FILE"
        echo "🎵 已切换到安静模式"
        ;;
    3)
        if [ -f "$MUTE_FILE" ]; then
            rm "$MUTE_FILE"
            echo "🔊 已取消静音"
        else
            touch "$MUTE_FILE"
            echo "🔇 已静音"
        fi
        ;;
    q|Q)
        echo "退出"
        ;;
    *)
        echo "无效选项"
        ;;
esac
