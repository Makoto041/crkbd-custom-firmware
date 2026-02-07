#!/bin/bash
# Corne Keyboard フラッシュスクリプト

set -e

# QMKディレクトリのパス
QMK_DIR="${QMK_DIR:-$HOME/qmk_firmware}"

# カラー出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== Corne Keyboard フラッシュ ===${NC}"

# QMKディレクトリの確認
if [ ! -d "$QMK_DIR" ]; then
    echo -e "${RED}エラー: QMKディレクトリが見つかりません: $QMK_DIR${NC}"
    exit 1
fi

cd "$QMK_DIR"

# ARM GCCのパスを設定（macOS）
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/opt/homebrew/opt/arm-gcc-bin@14/bin:$PATH"
fi

echo -e "${YELLOW}キーボードをブートローダーモードにしてください：${NC}"
echo -e "  1. BOOTSELボタンを押しながらUSB接続"
echo -e "  2. または RESETボタンを2回素早く押す"
echo -e ""
echo -e "${YELLOW}準備ができたら、次のプロンプトでRESETボタンを押してください...${NC}"
echo -e ""

qmk flash -kb crkbd/rev1 -km default

echo -e ""
echo -e "${GREEN}=== フラッシュ完了 ===${NC}"
echo -e "${YELLOW}もう片方のキーボードにも同じ手順でフラッシュしてください。${NC}"
