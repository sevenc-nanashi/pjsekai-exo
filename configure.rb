require "digest"

exos = Dir.glob("./exos/*.exo")

questions = {
  "background": "背景のファイルの場所はどこですか？（FriedPotatoで作成することをお勧めします）",
  "assets": "assetsフォルダはどこですか？",
  "movie": "プレイ動画はどこですか？",
  "jacket": "ジャケット画像はどこですか？",
}
puts "\e[93mexoファイルの設定を行います。\e[m"
answers = {}
questions.each do |key, value|
  puts value
  print "\e[90m>> \e[m"
  answer = gets.chomp
  answers[key] = answer.gsub("/", "\\")
end

def process_path(value)
  value
    .gsub("/", "\\")
    .gsub("\\", "\\\\\\\\")
    .gsub(/^"|"$/, "")
end

exos.each do |exo|
  contents = File.read(exo, encoding: Encoding::SJIS).encode("UTF-8")
  answers.each do |key, value|
    contents.gsub!("!!#{key}!!", process_path(value))
  end
  File.write(exo.sub("exos", "dist"), contents, encoding: Encoding::SJIS)
end

puts "\e[92mexoファイルの設定が完了しました。\e[m"
