require "http"
require "json"
require "stringio"
require "zlib"
require "tty-prompt"

prompt = TTY::Prompt.new
puts "\e[93m譜面の情報を取得します。\e[m"
puts "譜面ID（譜面の左上の#から始まるID）を入力して下さい。"
chart_id = prompt.ask("譜面ID:") do |q|
  q.validate(/[A-Za-z0-9]{12}/, "譜面IDのフォーマットに沿っていません。")
end

get = HTTP.get("https://servers.purplepalette.net/levels/#{chart_id}")
if get.code != 200
  puts "\e[91m譜面が見つかりませんでした。\e[m"
  exit 1
end
chart_data = JSON.parse(get.body.to_s, symbolize_names: true)
puts "\e[90m譜面名：\e[m#{chart_data[:item][:title]}"
puts "\e[90m譜面作者：\e[m#{chart_data[:item][:author]}"
data = HTTP.get("https://servers.purplepalette.net" + chart_data[:item][:data][:url])
stream = StringIO.new(data.body.to_s)

Zlib::GzipReader.wrap(stream) do |gz|
  File.write("data/chart_data.json", gz.read)
end
File.write "data/chart_id.txt", chart_id
puts "\e[92m譜面データを取得しました。\e[m"
