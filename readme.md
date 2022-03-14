# プロセカ風exoファイルジェネレーター
![dark](https://user-images.githubusercontent.com/92153597/158165792-96244bd8-c553-4473-adcc-9efb0c5a71c8.png#gh-dark-mode-only)
![light](https://user-images.githubusercontent.com/92153597/158165798-5b1593ea-1ca4-4282-8529-4eee578a33ce.png#gh-light-mode-only)

pjsekai-exo とは、UI がないプレイ動画にプロセカ風の UI を付けた exo ファイルを生成するツールです。

## 必須事項
- [Ruby 3.0 以上(with DevKit)](https://www.ruby-lang.org/ja/documentation/installation/)
- [AviUtl](http://spring-fragrance.mints.ne.jp/aviutl/) + [拡張編集プラグイン](http://spring-fragrance.mints.ne.jp/aviutl/) （[導入方法](https://aviutl.info/dl-innsuto-ru/)）

## 動画の作り方

1. [譜面を作る](https://wiki.purplepalette.net/create-charts)
2. [Sonolus](https://sonolus.com/)で譜面を撮影する
   - [FriedPotato](https://fp.sevenc7c.com)での撮影を推奨しています
   - 以下の方法のいずれかを使って、UIは消してください。
     * Sonolus の設定で、それぞれの UI 項目の不透明度を0%にするか
     * （FriedPotatoの場合は）`Hide UI`オプションを使えば消せます
3. 撮影したプレイ動画のファイルをパソコンに転送する
   - Google Driveなどで
4. [ffmpeg](https://www.ffmpeg.org/)で再エンコードする
   - AviUtlで読み込むため
5. 下の利用方法に従ってUIを後付けする

## 利用方法

0. 1334x750, 60fps でaviutlのプロジェクトを作成する
1. 右のReleasesから最新のバージョンをダウンロードする
2. `pjsekai-exo.exe` を実行し、関係する情報を入力する
3. dist/譜面ID にある exo ファイルをファイル名の数字に対応したシーンで読み込む（例：`00_root.exo`はRootで、`01_main.exo`はシーン1で）
4.  `@main.obj` ファイルをAviUtlのディレクトリの`/Plugins/script`に`@プロセカ.obj`としてコピーする
5.  シーンを設定する（下を参照）

## シーンの対応

### Root

| オブジェクト | シーン |
| ---------- | ------ |
| Layer 1: 1..739 | シーン3（`背景用`） |
| Layer 2: 1..208 | シーン2（`情報表示`） |
| Layer 2: 209.. | シーン1（`メイン`） |

### シーン3（`情報表示`）

| オブジェクト | シーン |
| ---------- | ------ |
| Layer 5 | シーン3（`背景用`） |

## 注意
動画の概要欄などに、自分の
- 名前（`名無し｡`）
- Twitterのプロフィール
- このリポジトリへのリンク
- YouTubeのチャンネル
が分かる文章を載せて下さい。
#### 例
```
プロセカ風exoファイルジェネレーター：
  https://github.com/sevenc-nanashi/pjsekai-exo
  作成：名無し｡  
  Twitter: https://twitter.com/sevenc_nanashi
  YouTube: https://youtube.com/channel/UCv9Wgrqn0ovYhUggSSm5Qtg
```
