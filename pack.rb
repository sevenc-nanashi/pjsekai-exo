# frozen_string_literal: true
require "json"

RANKS = { "c" => 21_500, "b" => 434_000, "a" => 940_000, "s" => 1_165_000 }.freeze

class PEDWizard
  def pack
    scores = File.read("./dist/#{@chart_id}/score.json")
      .then { JSON.parse(_1, symbolize_names: true) }
    scores = scores
      .map.with_index(1) { |s, i| [*s, i == 1 ? 0 : s[1].round - scores[i - 2][1].round, i] }
      .reverse.uniq { |s| s[0] }.reverse

    File.open("./dist/#{@chart_id}/data.tmp.ped", "w") do |file|
      file.puts "p|!!assets!!"
      file.puts "a|!!ap!!"
      scores.each_with_index do |score, _i|
        file.write "s|#{score[0]}:#{score[1]}:"
        file.write "#{score[2]}:"
        file.write "#{calc_width(score[1])}:"
        RANKS.to_a.select { |_rank, l_score| score[1] >= l_score }.last&.then(&:first).then do |rank|
          file.write "#{rank || "n"}:"
        end
        file.write("#{score[3]}")
        file.puts
      end
    end
  end

  def calc_width(score)
    case score
    when ..21_500
      651 - score / 21_500.0 * (651 - 380)
    when ..434_000
      380 - (score - 21_500) / (434_000 - 21_500.0) * (380 - 292)
    when ..940_000
      292 - (score - 434_000) / (940_000 - 434_000.0) * (292 - 200)
    when ..1_165_000
      200 - (score - 940_000) / (1_165_000 - 940_000.0) * (200 - 110)
    when ..1_300_000
      110 - (score - 1_165_000) / (1_300_000 - 1_165_000.0) * (110 - 43)
    else
      43
    end.then { |i| 1 - (i - 43) / 608.0 }
  end
end
