# プロセカ風exoファイルジェネレーター

## 必須事項
・[Ruby 3.0 以上](https://www.ruby-lang.org/ja/documentation/installation/)
・[AviUtl](http://spring-fragrance.mints.ne.jp/aviutl/)
・拡張編集プラグイン

## 新利用方法

0. 1334x750, 60fps でプレイ動画を作成
1. `gem install http` を実行する
2. `ruby level_data.rb` を実行し、関係する情報を入力する
3. `ruby calc_score.rb` を実行し、関係する情報を入力する
5. `ruby pack.rb` を実行する
6. `ruby configure.rb` を実行し、関係する情報を入力する
9. dist にある exo ファイルのうち、00、01、02、03を読み込む
11. `@main.obj` ファイルをAviUtlのディレクトリの`/Plugins/scripts`に`@プロセカ.obj`としてコピーする
12. シーンを設定する（ToDo：設定しなくてもいいようにする）
13. カスタムオブジェクトの`判定@プロセカ`、`スコア@プロセカ`、`コンボ@プロセカ`を配置する 


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
