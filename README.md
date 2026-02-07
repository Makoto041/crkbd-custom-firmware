# Corne Keyboard Custom Firmware

Corne Cherry v3用のカスタムファームウェア設定

## 機能

- **Bongo Cat**: 右側OLEDにBongo Catアニメーション表示
- **キーカウンター**: 押したキーの総数をカウント表示
- **レイヤー表示**: 左側OLEDに現在のレイヤーを表示 (L 0, L 1, L 2, L 3)
- **VIA対応**: VIAアプリでキーマップをGUIで編集可能

## ファイル構成

```
crkbd-custom-firmware/
├── README.md           # このファイル
├── bongo.h            # Bongo Catアニメーション
├── crkbd.c            # メインコード（レイヤー表示など）
├── rules.mk           # ビルド設定
├── build.sh           # ビルドスクリプト
├── flash.sh           # フラッシュスクリプト
└── default/           # デフォルトキーマップ
    ├── config.h
    ├── keymap.c
    └── rules.mk
```

## セットアップ

### 1. QMKファームウェアのクローン

```bash
git clone https://github.com/qmk/qmk_firmware.git
cd qmk_firmware
qmk setup
```

### 2. カスタムファイルの配置

```bash
# このリポジトリをクローン
git clone https://github.com/YOUR_USERNAME/crkbd-custom-firmware.git

# ファイルをコピー
cp crkbd-custom-firmware/bongo.h qmk_firmware/keyboards/crkbd/
cp crkbd-custom-firmware/crkbd.c qmk_firmware/keyboards/crkbd/
cp crkbd-custom-firmware/rules.mk qmk_firmware/keyboards/crkbd/
cp -r crkbd-custom-firmware/default qmk_firmware/keyboards/crkbd/keymaps/
```

### 3. ビルド

```bash
cd qmk_firmware
export PATH="/opt/homebrew/opt/arm-gcc-bin@14/bin:$PATH"
qmk compile -kb crkbd/rev1 -km default
```

または、このリポジトリの`build.sh`を使用：

```bash
./build.sh
```

### 4. フラッシュ

```bash
qmk flash -kb crkbd/rev1 -km default
```

RESETボタンを押すとフラッシュが開始されます。

または、このリポジトリの`flash.sh`を使用：

```bash
./flash.sh
```

## 表示内容

### 左側OLED
```
L 0          # レイヤー番号
[キーログ]   # 最後に押したキー
```

### 右側OLED
```
K:12345     # キーカウント
[Bongo Cat] # アニメーション
```

## カスタマイズ

### レイヤー表示の変更

[crkbd.c](crkbd.c)の`oled_render_layer_state()`関数を編集してください。

### Bongo Catの無効化

[default/config.h](default/config.h)の`#define BONGO_ENABLE`をコメントアウトしてください。

### VIAの無効化

[default/rules.mk](default/rules.mk)の`VIA_ENABLE = yes`を`no`に変更してください。

## トラブルシューティング

### ビルドエラー: ファームウェアサイズが大きすぎる

容量を削減するために、以下を試してください：
- RGB Matrixを無効化（既に無効）
- Mousekeyを無効化（既に無効）
- LTOを有効化（既に有効）

### VIAでライティングエラーが出る

RGB Matrix機能を無効化しているため、VIAでバックライト設定のエラーが表示されますが、キーマップ機能は正常に動作します。エラーは無視してください。

## 必要なツール

- QMK CLI
- arm-none-eabi-gcc (v14)
- avr-gcc

macOSでのインストール：

```bash
brew install qmk/qmk/qmk
brew install osx-cross/arm/arm-gcc-bin@14
brew install avr-gcc
```

## ライセンス

QMK Firmwareのライセンスに準拠（GPL v2）

## 参考

- [QMK Firmware](https://qmk.fm/)
- [Corne Keyboard](https://github.com/foostan/crkbd)
- [Bongo Cat OLED Guide](https://linuslab.com/corne-bongo-cat-oled/)
