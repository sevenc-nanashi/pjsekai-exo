require "json"

scores = File.read("./score.json").then { JSON.parse(_1, symbolize_names: true) }

def get_width(score)
  # 276
  #651..43
  # 380, 292, 200, 110
  case score
  when ..21500
    651 - score / 21500.0 * (651 - 380)
  when ..434000
    380 - (score - 21500) / (434000 - 21500.0) * (380 - 292)
  when ..940000
    292 - (score - 434000) / (940000 - 434000.0) * (292 - 200)
  when ..1165000
    200 - (score - 940000) / (1165000 - 940000.0) * (200 - 110)
  when ..1300000
    110 - (score - 1165000) / (1300000 - 1165000.0) * (110 - 43)
  else
    43
  end
end

ranks = { "c" => 21500, "b" => 434000, "a" => 940000, "s" => 1165000 }

File.open("./data.base.txt", "w") do |file|
  file.puts "p|!!assets!!"
  scores.each_with_index do |score, i|
    file.write "s|#{score[0]}:#{score[1]}:"
    file.write "#{score[1].round - scores[i - 1][1].round}:"
    file.write "#{get_width(score)}:"
    ranks.find { |rank, score| score[1] >= score }&.then(&:first).then do |rank|
      file.write "#{rank || "n"}"
    end
    file.puts
  end
end
