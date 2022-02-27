# プロセカ風exoファイルジェネレーター
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

0. 1334x750, 60fps でプレイ動画を作成
1. `setup.bat` を実行する
2. `generate.bat` を実行し、関係する情報を入力する
3. dist にある exo ファイルのうち、00、01、02、03を読み込む
4.  `@main.obj` ファイルをAviUtlのディレクトリの`/Plugins/script`に`@プロセカ.obj`としてコピーする
5.  シーンを設定する（ToDo：設定しなくてもいいようにする）
6.  カスタムオブジェクトの`判定@プロセカ`、`スコア@プロセカ`、`コンボ@プロセカ`を配置する 
7.  カスタムオブジェクトの`参照`を3で生成された`譜面ID.ped`にする

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
