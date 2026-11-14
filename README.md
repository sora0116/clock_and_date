# 時計と日付

Android のホーム画面に置く、4x2 サイズの時計・日付ウィジェットです。

```
 9:41                11月15日(日)
```

- 左に現在時刻(`h:mm`、端末が24時間表示なら `H:mm`)、右に日付(`MM月dd日(E)`)を表示します
- 背景はなく、壁紙の上に白い文字を直接置きます。読みやすさのために薄い影を付けています
- タップすると端末の時計アプリ(アラーム画面)が開きます
- 幅が狭い端末では、文字が自動で小さくなります

## 動作環境

- Android 8.0(API 26)以降
- 4x2 の初期サイズ指定(`targetCellWidth` / `targetCellHeight`)は Android 12 以降で有効です。それより前の端末では最小サイズ(250dp x 110dp)から近いマス数が選ばれます

## ビルド

Docker を使ってビルドします。PC に Java や Android SDK を入れる必要はありません。

```powershell
./build.ps1
```

APK は `app/build/outputs/apk/debug/app-debug.apk` に出力されます。

- 初回は Android SDK と Gradle 入りのイメージ(`clock-and-date-builder`)を作るため時間がかかります
- Gradle のキャッシュは Docker ボリューム `clock-and-date-gradle-cache` に保存され、2回目以降のビルドが速くなります

PowerShell 以外から実行する場合は、次の2つのコマンドと同じです。

```bash
docker build -t clock-and-date-builder docker
docker run --rm -v "$PWD:/project" -v clock-and-date-gradle-cache:/root/.gradle clock-and-date-builder
```

## インストールと設置

1. `app-debug.apk` をスマホにコピーし、「ファイル」アプリなどから開いてインストールします(提供元不明のアプリの許可が必要です)
2. ホーム画面の何もないところを長押しし、「ウィジェット」→「時計と日付」を選んで配置します

ウィジェット専用のアプリなので、アプリ一覧にはアイコンが表示されません。

## 仕組み

時刻と日付は `TextClock` で表示しています。表示の更新はホーム画面アプリ側が行うため、このアプリが1分ごとに起動することはなく、電池への影響はほとんどありません。

## ファイル構成

| ファイル | 内容 |
| --- | --- |
| `app/src/main/res/layout/widget_clock.xml` | ウィジェットのレイアウト(文字サイズ・配置) |
| `app/src/main/res/values/styles.xml` | 文字色・影・自動縮小の設定 |
| `app/src/main/res/values/strings.xml` | 時刻・日付の表示形式 |
| `app/src/main/res/xml/clock_widget_info.xml` | ウィジェットのサイズ・リサイズ設定 |
| `app/src/main/java/com/example/clockanddate/ClockWidgetProvider.kt` | タップ時の動作 |
| `docker/Dockerfile` | ビルド用イメージ |
| `build.ps1` | ビルドスクリプト |

## 注意点

- 曜日の表記は端末の言語設定に従います。英語設定の端末では `(Sun)` のようになります
- 現在はデバッグ署名の APK のみです。Google Play で配布するにはリリース署名の設定が必要です
