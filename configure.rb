require "digest"
require "json"
require "tty-prompt"
require "http"

prompt = TTY::Prompt.new
exos = Dir.glob("./exos/*.exo")
CHART_ID = File.read("data/chart_id.txt")

answers = {
  background: "",
  jacket: "",
  assets: "",
  movie: "",
  data: File.expand_path("./#{CHART_ID}.ped").gsub("/", "\\\\\\\\"),
}
puts "\e[93mファイルの設定を行います。パスを入力して下さい。\e[m"
puts "\e[90mパスの両端の\"は取り除かれます。\e[m"

def process_path(value)
  value
    .gsub("/", "\\")
    .gsub("\\", "\\\\\\\\")
    .gsub(/^"|"$/, "")
    .gsub(/\\$/, "")
    .encode("SHIFT_JIS")
end

def download_background
  print "\e[90m背景画像をダウンロードしています...\e[m"
  File.write(
    "./data/background.png",
    HTTP.get("https://image-gen.sevenc7c.com/generate/#{CHART_ID}.png").body.to_s,
    mode: "wb",
  )
  puts "\e[92m 完了\e[m"
  File.expand_path("./data/background.png")
end

def download_jacket
  print "\e[90mジャケットをダウンロードしています...\e[m"
  data = JSON.parse(
    HTTP.get("https://servers.purplepalette.net/levels/#{CHART_ID}").body,
    symbolize_names: true,
  )
  File.write(
    "./data/jacket.png",
    HTTP.get("https://servers.purplepalette.net" + data[:item][:cover][:url]).body.to_s,
    mode: "wb",
  )
  puts "\e[92m 完了\e[m"
  File.expand_path("./data/jacket.png")
end

answers[:background] = prompt.ask("背景ファイル（省略で自動生成）:") || download_background
answers[:jacket] = prompt.ask("ジャケット（省略でダウンロード）:") || download_jacket
answers[:assets] = prompt.ask("assetsフォルダ（省略でこのフォルダのassets）:") || File.expand_path("./assets")
answers[:movie] = prompt.ask("プレイ動画:") do |q|
  q.validate ->(value) { File.exist?(process_path(value)) }, "プレイ動画が見付かりません。"
end

exos.each do |exo|
  contents = File.read(exo, encoding: Encoding::SJIS)
  answers.each do |key, value|
    contents.gsub!("!!#{key}!!", process_path(value))
  end
  File.write(exo.sub("exos", "dist"), contents, encoding: Encoding::SJIS)
end

content = File.read("./data/base.txt")
answers.each do |key, value|
  content.gsub!("!!#{key}!!", process_path(value))
end

puts "\e[92mファイルの設定が完了しました。\e[m"
File.write("./#{CHART_ID}.ped", content)
