# 自分用 Corne Keyboard カスタムファームウェア

Corne Cherry v3用のカスタム設定。Bongo Cat表示とキーカウンター付き。

## 表示内容

### 左側OLED
- `L 0` レイヤー番号表示
- キーログ（最後に押したキーの位置とキーコード）

### 右側OLED
- `K:12345` キーカウント（起動からの総キー押下数）
- Bongo Cat アニメーション（タイピングに合わせて動く）

## クイックスタート

### ファイルを配置
```bash
cd ~/qmk_firmware/keyboards/crkbd
cp ~/crkbd-custom-firmware/bongo.h .
cp ~/crkbd-custom-firmware/crkbd.c .
cp ~/crkbd-custom-firmware/rules.mk .
cp -r ~/crkbd-custom-firmware/default keymaps/
```

### ビルド
```bash
cd ~/qmk_firmware
export PATH="/opt/homebrew/opt/arm-gcc-bin@14/bin:$PATH"
qmk compile -kb crkbd/rev1 -km default
```

### フラッシュ
```bash
qmk flash -kb crkbd/rev1 -km default
# RESETボタンを押す
```

**注意**: 左右両方にフラッシュすること！

## スクリプト使用

### ビルド
```bash
cd ~/crkbd-custom-firmware
./build.sh
```

### フラッシュ
```bash
cd ~/crkbd-custom-firmware
./flash.sh
# RESETボタンを押す
```

## ファイル説明

| ファイル | 説明 |
|---------|------|
| `bongo.h` | Bongo Catアニメーション + キーカウンター |
| `crkbd.c` | レイヤー表示とキーログ |
| `rules.mk` | キーボード全体の設定（OLED有効化など） |
| `default/config.h` | `BONGO_ENABLE`定義 |
| `default/keymap.c` | キーマップ（VIAで変更可能） |
| `default/rules.mk` | VIA有効、RGB無効など |

## カスタマイズメモ

### レイヤー名を変更したい
[crkbd.c](crkbd.c) の49-63行目を編集：
```c
static void oled_render_layer_state(void) {
    oled_write_P(PSTR("L "), false);
    switch (get_highest_layer(layer_state)) {
        case 0:
            oled_write_P(PSTR("0\n"), false);  // ← ここを変更
```

### キーカウント表示を変更したい
[bongo.h](bongo.h) の504-508行目：
```c
oled_write_P(PSTR("K:"), false);  // ← ラベル変更
char buf[8];
itoa(key_count, buf, 10);
oled_write(buf, false);
```

### Bongo Catを無効にしたい
[default/config.h](default/config.h) の23行目をコメントアウト：
```c
// #define BONGO_ENABLE
```

## VIAについて

- VIA有効化済み
- キーマップはVIAアプリで変更可能
- ライティング設定のエラーは無視してOK（RGB無効化のため）

## 容量制限

Pro Micro（28672バイト）はギリギリ。現在1208バイトの余裕。

**有効な機能:**
- OLED表示
- VIA
- WPMカウント
- LTO最適化

**無効化した機能（容量節約のため）:**
- RGB Matrix
- Mousekey
- Space Cadet

## トラブルシューティング

### ビルドエラー「firmware is too large」
→ 容量オーバー。機能を減らすかLTO最適化を確認。

### VIAでエラーが出る
→ ライティング機能のエラーは無視。キーマップ変更は問題なく動作。

### 片方しか動かない
→ 左右両方にフラッシュする必要あり。

### Bongo Catが表示されない
→ `BONGO_ENABLE`が定義されているか確認。右側（非マスター側）に表示される。

## 環境

- キーボード: Corne Cherry v3 (rev1)
- マイコン: Pro Micro
- OS: macOS 15.3.1 (Apple Silicon)
- QMK: 0.31.9
- arm-gcc: 14.2.Rel1
- avr-gcc: 9.5.0

## 参考

- [QMK公式](https://qmk.fm/)
- [Corne](https://github.com/foostan/crkbd)
- [Bongo Cat Guide](https://linuslab.com/corne-bongo-cat-oled/)

## 更新履歴

- 2026-02-08: 初回作成
  - Bongo Cat + キーカウンター
  - シンプルなレイヤー表示 (L 0, L 1, L 2, L 3)
  - VIA対応
