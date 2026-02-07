#!/bin/bash
# Corne Keyboard ビルドスクリプト

set -e

# QMKディレクトリのパス（必要に応じて変更）
QMK_DIR="${QMK_DIR:-$HOME/qmk_firmware}"

# カラー出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Corne Keyboard ビルド ===${NC}"

# QMKディレクトリの確認
if [ ! -d "$QMK_DIR" ]; then
    echo -e "${RED}エラー: QMKディレクトリが見つかりません: $QMK_DIR${NC}"
    echo "QMK_DIR環境変数を設定するか、~/qmk_firmwareにQMKをクローンしてください。"
    exit 1
fi

echo -e "${YELLOW}QMKディレクトリ: $QMK_DIR${NC}"

# ファイルをコピー
echo -e "${YELLOW}カスタムファイルをコピー中...${NC}"
cp bongo.h "$QMK_DIR/keyboards/crkbd/"
cp crkbd.c "$QMK_DIR/keyboards/crkbd/"
cp rules.mk "$QMK_DIR/keyboards/crkbd/"
cp -r default "$QMK_DIR/keyboards/crkbd/keymaps/"

echo -e "${GREEN}ファイルのコピー完了${NC}"

# ビルド
echo -e "${YELLOW}ビルド中...${NC}"
cd "$QMK_DIR"

# ARM GCCのパスを設定（macOS）
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/opt/homebrew/opt/arm-gcc-bin@14/bin:$PATH"
fi

qmk compile -kb crkbd/rev1 -km default

echo -e "${GREEN}=== ビルド完了 ===${NC}"
echo -e "${YELLOW}ファームウェアファイル: $QMK_DIR/crkbd_rev1_default.hex${NC}"
echo -e "${YELLOW}フラッシュするには: ./flash.sh または qmk flash -kb crkbd/rev1 -km default${NC}"
