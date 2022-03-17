# frozen_string_literal: true
require "json"
require "tty-prompt"
require_relative "console"

def note_fax(type)
  case type
  when 3, 4, 5, 7, 8
    1.0
  when 6, 17
    0.1
  when 10, 12, 14, 15
    2.0
  when 11
    3.0
  when 13
    0.2
  end
end

class PSExo
  def calc_score
    prompt = TTY::Prompt.new
    CPuts.info "スコアを計算します。"

    level = 30
    total_pow = prompt.ask("総合力を入力して下さい:") do |q|
      q.validate(/\d+/, "数値を入力してください。")
    end.to_i
    level_fax = (level - 5) * 0.005 + 1
    notes = []
    JSON.parse(File.read("dist/#{@chart_id}/chart_data.json"), symbolize_names: true)[:entities][3..].each do |entity|
      next if entity[:data][:values].length > 5
      notes << entity
    end
    notes.sort_by! { |note| note[:data][:values][0] }
    heavy_notes = 0.0
    notes.each do |note|
      heavy_notes += note_fax(note[:archetype])
    end

    scores = []
    notes.each.with_index(1) do |note, index|
      combo_bonus = 0.01 * (index / 100) + 1
      scores << [
        note[:data][:values][0],
        (scores[-1]&.[](1) || 0) + ((total_pow / heavy_notes) \
          * 4 \
          * note_fax(note[:archetype]) \
          * combo_bonus \
          * level_fax).round,
      ]
    end

    File.write("dist/#{@chart_id}/score.json", scores.to_json)
  end
end
