#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

declare -a dependencies=("git" "curl" "cc")

missing_count=0
echo -e "${YELLOW}正在检查 macOS 依赖...${NC}"

# 检查 Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${RED}✗ Homebrew 未安装${NC}"
    echo -e "安装命令:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

for cmd in "${dependencies[@]}"; do
    if command -v $cmd &> /dev/null; then
        echo -e "${GREEN}✓ ${cmd} 已安装${NC}"
    else
        echo -e "${RED}✗ ${cmd} 未安装${NC}"
        ((missing_count++))
        install_cmds+=("brew install $cmd")
    fi
done

if [ $missing_count -gt 0 ]; then
    echo -e "\n${YELLOW}运行以下命令安装缺失依赖：${NC}"
    printf '%s\n' "${install_cmds[@]}"
else
    echo -e "\n${GREEN}所有依赖已安装，准备就绪！${NC}"
fi
