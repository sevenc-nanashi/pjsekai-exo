require "json"
# require "ricecream"
# Ricecream.colorize = true
x_positions = [-559.0, -535.0, -511.0, -487.0, -463.0, -440.0, -416.0, -390.0]
# #region digit_base
digit_base = <<~'INI'
  [!num!]
  start=!start!
  end=!end!
  layer=!layer!
  overlay=1
  camera=0
  [!num!.0]
  _name=画像ファイル
  file=!!assets!!\score\!digit!.png
  [!num!.1]
  _name=標準描画
  X=!x!
  Y=-297.0
  Z=0.0
  拡大率=100.00
  透明度=0.0
  回転=0.00
  blend=0
INI
# #endregion
digits = [[], [], [], [], [], [], [], []]
scores = JSON.parse(File.read("score.json"))
scores.each do |time, score|
  score.floor.to_s.rjust(8, "n").split("").each_with_index do |digit, i|
    digits[i] << digit
  end
end
res = File.read("base/score_base.exo", encoding: "sjis").encode("utf-8")
res.gsub!(/!name!/, "スコア")
# #region add bar
res << <<~'INI'
  [0]
  start=1
  end=!vend!
  layer=1
  overlay=1
  camera=0
  [0.0]
  _name=画像ファイル
  file=!!assets!!\score\score.png
  [0.1]
  _name=標準描画
  X=-387.0
  Y=-317.0
  Z=0.0
  拡大率=70.00
  透明度=0.0
  回転=0.00
  blend=0
  [1]
  start=1
  end=!vend!
  layer=14
  overlay=1
  camera=0
  [1.0]
  _name=画像ファイル
  file=!!assets!!\score\bars.png
  [1.1]
  _name=標準描画
  X=-387.0
  Y=-317.0
  Z=0.0
  拡大率=70.00
  透明度=0.0
  回転=0.00
  blend=0
  [2]
  start=1
  end=!vend!
  layer=3
  overlay=1
  camera=0
  [2.0]
  _name=シーン
  再生位置=1
  再生速度=0.0,100.0,3
  ループ再生=0
  =5
  [2.1]
  _name=標準描画
  X=0.0
  Y=0.0
  Z=0.0
  拡大率=100.00
  透明度=0.0
  回転=0.00
  blend=0
INI
# #endregion
times = scores.map { |time, score| time + 1 }
digit_last = [times[0]] * 8
num = 3
rank_time = 0
rank_last = 0
ranks = [21500, 434000, 940000, 1165000]
rank_name = "_cbas"
last_time = times[-1] + 1
times.each_with_index do |time, i|
  # next if i == 0
  time += 1 if i == times.size - 1
  digits.each_with_index do |digit, j|
    if (i == 0 ? "n" : digit[i - 1]) != digit[i] or i == times.size - 1
      unless i == 0
        res << "\n" + digit_base
          .gsub("!num!", num.to_s)
          .gsub("!digit!", i == 0 ? "n" : digit[i - 1])
          .gsub("!x!", x_positions[j].to_s)
          .gsub("!layer!", (j + 4).to_s)
          .gsub("!start!", ((digit_last[j] * 60).round + 1).to_s)
          .gsub("!end!", i == times.size - 1 ? "!vend!" : (time * 60).round.to_s)
        num += 1
      end
      digit_last[j] = time
    end
  end
  if i == times.size - 1 or ranks[rank_last] && scores[i][1] >= ranks[rank_last]
    if rank_time != 0
      res << <<~INI
        [#{num}]
        start=#{(rank_time * 60).floor + 1}
        end=#{i == times.size - 1 ? "!vend!" : (time * 60).floor}
        layer=2
        overlay=1
        camera=0
        [#{num}.0]
        _name=画像ファイル
        file=!!assets!!\\score\\#{rank_name[rank_last]}.png
        [#{num}.1]
        _name=標準描画
        X=-607.0
        Y=-317.0
        Z=0.0
        拡大率=70.00
        透明度=0.0
        回転=0.00
        blend=0
      INI
      num += 1
    end
    rank_time = time
    rank_last += 1
  end
end
8.times do |i|
  res << "\n" + digit_base
    .gsub("!num!", num.to_s)
    .gsub("!digit!", "n")
    .gsub("!x!", x_positions[i].to_s)
    .gsub("!layer!", (i + 4).to_s)
    .gsub("!start!", "1")
    .gsub("!end!", "60")
  num += 1
end
# 1240 - 810 = 430
bar_last_time = 0
before_clip_x = 654
# 362, 614
def get_width(score)
  # 276
  w = case score
    when ..21500
      score / 21500.0 * 276.0
    when ..434000
      (score - 21500) / (434000 - 21500) * 84.5 + 276.0
    when ..940000
      (score - 434000) / (940000 - 434000) * 84.5 + 84.5 + 276.0
    when ..1165000
      (score - 940000) / (1165000 - 940000) * 84.5 + 84.5 * 2 + 276.0
    when ..1300000
      (score - 1165000) / (1300000 - 1165000) * 84.5 + 84.5 * 3 + 276.0
    else
      614
    end
  w /= 614.0
  654 - (654 - 42) * w
end

scores.each do |time, score|
  clip_x = get_width(score)
  next if (time * 60).floor == 0 or bar_last_time.round == time.round
  res << <<~INI
    [#{num}]
    start=#{(bar_last_time * 60 + 61).floor}
    end=#{(time * 60).floor + 60}
    layer=12
    overlay=1
    camera=0
    #{"chain=1" if bar_last_time != 0}
    [#{num}.0]
    _name=画像ファイル
    file=!!assets!!\\score\\inner.png
    [#{num}.1]
    _name=クリッピング
    上=0
    下=0
    左=0
    右=#{before_clip_x},#{clip_x},3
    中心の位置を変更=0
    [#{num}.2]
    _name=標準描画
    X=-387.5
    Y=-317.0
    Z=0.0
    拡大率=70.00
    透明度=0.0
    回転=0.00
    blend=0
  INI
  num += 1
  bar_last_time = time
  before_clip_x = clip_x
end
# #region add last bar
res << <<~INI
  [#{num}]
  start=#{(bar_last_time * 60 + 1).floor}
  end=!vend!
  layer=12
  overlay=1
  camera=0
  chain=1
  [#{num}.0]
  _name=画像ファイル
  file=!!assets!!\\score\\inner.png
  [#{num}.1]
  _name=クリッピング
  上=0
  下=0
  左=0
  右=#{before_clip_x},#{before_clip_x},3
  中心の位置を変更=0
  [#{num}.2]
  _name=標準描画
  X=-387.5
  Y=-317.0
  Z=0.0
  拡大率=70.00
  透明度=0.0
  回転=0.00
  blend=0
INI
# #endregion
res.gsub!("!vend!", ((last_time) * 60).round.to_s)
File.write("exos/04_score.exo", res, encoding: "sjis")

res = File.read("base/score_base.exo", encoding: "sjis").encode("utf-8")
res.gsub!("!name!", "スコア追加")
# #region define base
add_base = <<~INI
  [!num!]
  start=!start!
  end=!end!
  layer=!layer!
  overlay=1
  camera=0
  [!num!.0]
  _name=画像ファイル
  file=!!assets!!\\score\\!image!.png
  [!num!.1]
  _name=標準描画
  X=!x1!.0,!x2!.0,1
  Y=-292.0,-292.0,1
  Z=0.0,0.0,1
  拡大率=65.00
  透明度=80.0,!alpha!,1
  回転=0.00
  blend=0
INI
add_base2 = <<~INI
  [!num!]
  start=!start!
  end=!end!
  layer=!layer!
  overlay=1
  camera=0
  chain=1
  [!num!.0]
  _name=画像ファイル
  [!num!.1]
  _name=標準描画
  X=!x!.0,!x!.0,1
  Y=-292.0,-292.0,1
  Z=0.0,0.0,1
  拡大率=65.00
  透明度=0.0,0.0,1
  回転=0.00
INI
# #endregion
ANIM = 8.0
prev_score = 0
SCORE_LAYER = 3
num = 0
scores.each_with_index do |(time, score), index|
  next_time = scores[index + 1]&.[](0)
  next_time ||= last_time
  add_score = "p" + (score.floor - prev_score.floor).to_s
  next prev_score = score if next_time == time

  if (next_time - (time + (ANIM / 60))) < 1.0 / 60
    pers = ((next_time - time) * 60) / ANIM

    add_score.to_s.split("").each_with_index do |c, i|
      x1 = -413 + 16 * i
      x2 = x1 + 50 * pers
      res += add_base
        .gsub(/!num!/, (num).to_s)
        .gsub(/!start!/, ((time * 60).floor + 1).to_s)
        .gsub(/!end!/, (next_time * 60 - 1).floor.to_s)
        .gsub(/!x1!/, x1.to_s)
        .gsub(/!x2!/, x2.to_s)
        .gsub(/!alpha!/, (pers * 80).to_s)
        .gsub(/!layer!/, (SCORE_LAYER + i).to_s)
        .gsub(/!image!/, "#{c}")
      num += 1
    end
  else
    add_score.to_s.split("").each_with_index do |c, i|
      x1 = -413.0 + 16 * i
      x2 = x1 + 50
      res += add_base
        .gsub(/!num!/, (num).to_s)
        .gsub(/!start!/, ((time * 60).floor + 1).to_s)
        .gsub(/!end!/, (time * 60 + ANIM - 1).floor.to_s)
        .gsub(/!x1!/, x1.to_s)
        .gsub(/!x2!/, x2.to_s)
        .gsub(/!alpha!/, "0.0")
        .gsub(/!layer!/, (SCORE_LAYER + i).to_s)
        .gsub(/!image!/, "#{c}")
      res += add_base2
        .gsub(/!num!/, (num + 1).to_s)
        .gsub(/!start!/, (time * 60 + ANIM).floor.to_s)
        .gsub(/!end!/, ([next_time, time + 0.5].min * 60 - 1).floor.to_s)
        .gsub(/!x!/, x2.to_s)
        .gsub(/!layer!/, (SCORE_LAYER + i).to_s)
        .gsub(/!image!/, "#{c}")
      num += 2
    end
  end
  prev_score = score
end
res.gsub!("!vend!", (last_time * 60).to_s)
File.write("exos/05_score_add.exo", res, encoding: "sjis")
