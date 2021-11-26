require "http"
require "json"
require "stringio"
require "zlib"

puts "\e[93m譜面の情報を取得します。\e[m"
puts "譜面ID（譜面の左上の#から始まるID）を入力して下さい。"
print "\e[90m>> \e[m"
score_id = gets.chomp

get = HTTP.get("https://servers.purplepalette.net/levels/#{score_id}")
if get.code != 200
  puts "\e[91m譜面が見つかりませんでした。\e[m"
  exit 1
end
score_data = JSON.parse(get.body.to_s, symbolize_names: true)
puts "\e[90m譜面名：\e[m#{score_data[:item][:title]}"
puts "\e[90m譜面作者：\e[m#{score_data[:item][:author]}"
data = HTTP.get("https://servers.purplepalette.net" + score_data[:item][:data][:url])
stream = StringIO.new(data.body.to_s)

Zlib::GzipReader.wrap(stream) do |gz|
  File.write("score_data.json", gz.read)
end
puts "\e[92m譜面データを取得しました。\e[m"
