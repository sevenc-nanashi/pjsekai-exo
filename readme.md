# プロセカ風exoファイルジェネレーター

## 必須事項
- [Ruby 3.0 以上](https://www.ruby-lang.org/ja/documentation/installation/)
- [AviUtl](http://spring-fragrance.mints.ne.jp/aviutl/)
- 拡張編集プラグイン

## 動画の作り方

1. [譜面を作る](https://wiki.purplepalette.net/create-charts)
2. Sonolusで譜面を撮影する
- [FriedPotato](https://fp.sevenc7c.com)での撮影を推奨しています。
- UIは消してください。不透明度を0%にするか、（FriedPotatoの場合は）`Hide UI`オプションを使えば消せます。
3. 動画を転送する
- Google Driveなどで。
4. [ffmpeg](https://www.ffmpeg.org/)で再エンコードする
- AviUtlで読み込むため。
5. 下の利用方法に従ってUIを後付けする。

## 新利用方法

0. 1334x750, 60fps でプレイ動画を作成
1. `setup.bat` を実行する
2. `generate.bat` を実行し、関係する情報を入力する
3. dist にある exo ファイルのうち、00、01、02、03を読み込む
4.  `@main.obj` ファイルをAviUtlのディレクトリの`/Plugins/scripts`に`@プロセカ.obj`としてコピーする
5.  シーンを設定する（ToDo：設定しなくてもいいようにする）
6.  カスタムオブジェクトの`判定@プロセカ`、`スコア@プロセカ`、`コンボ@プロセカ`を配置する 
7.  カスタムオブジェクトの`参照`を3で生成されたdata.txtにする

## 旧利用方法

0. 1334x750, 60fps でプレイ動画を作成
1. `gem install http` を実行する
2. `ruby level_data.rb` を実行し、関係する情報を入力する
3. `ruby calc_score.rb` を実行し、関係する情報を入力する
4. `ruby score_exo.rb` を実行する
5. `ruby combo.rb` を実行する
6. `ruby configure.rb` を実行し、関係する情報を入力する
9. dist にある exo ファイルを順に AviUtl に（拡張編集プラグインを入れた上、メニュー→「拡張機能の設定」から）読み込む
10. シーンを設定する（ToDo：設定しなくてもいいようにする）

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
