#!/usr/bin/env bash

# 定义颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # 重置颜色

# 依赖列表
declare -A dependencies=(
    ["gcc"]="build-essential"
    ["make"]="make"
    ["git"]="git"
    ["curl"]="curl"
    ["fzf"] = "fzf"
)

# 检测包管理器
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
else
    echo -e "${RED}✗ 无法检测到支持的包管理器${NC}"
    exit 1
fi

# 检查依赖项
missing_count=0
echo -e "${YELLOW}正在检查系统依赖...${NC}"

for cmd in "${!dependencies[@]}"; do
    if command -v $cmd &> /dev/null; then
        echo -e "${GREEN}✓ ${cmd} 已安装${NC}"
    else
        echo -e "${RED}✗ ${cmd} 未安装${NC}"
        ((missing_count++))
        install_cmds+=("sudo $PKG_MANAGER install ${dependencies[$cmd]}")
    fi
done

# 输出结果
if [ $missing_count -gt 0 ]; then
    echo -e "\n${YELLOW}需要安装以下依赖：${NC}"
    printf '%s\n' "${install_cmds[@]}"
else
    echo -e "\n${GREEN}所有依赖已安装，准备就绪！${NC}"
fi
