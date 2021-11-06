require "json"

Encoding.default_external = Encoding::UTF_8

times = []
JSON.parse(File.read("score_data.json"), symbolize_names: true)[:entities][3..].each do |entity|
  next if entity[:data][:values].length > 5
  times << entity[:data][:values][0]
end

base = '
[!num!]
start=!start!
end=!mid!
layer=!layer!
overlay=1
camera=0
[!num!.0]
_name=画像ファイル
file=!!assets!!\combos\!dig!.png
[!num!.1]
_name=拡張描画
blend=0
X=474.0
Y=-64.0
Z=0.0
拡大率=50.00,!pers!,1
透明度=0.0
回転=0.00
blend=0
縦横比=0.0
X軸回転=0.00
Y軸回転=0.00
Z軸回転=0.00
中心X=!x!
中心Y=0.0
中心Z=0.0
裏面を表示しない=0
'
base2 = "[!num2!]
start=!mid2!
end=!end!
layer=!layer!
overlay=1
camera=0
chain=1
[!num2!.0]
_name=画像ファイル
[!num2!.1]
_name=拡張描画
X=474.0
Y=-64.0
Z=0.0
拡大率=100.00,100.00,1
透明度=0.0
回転=0.00
縦横比=0.0
X軸回転=0.00
Y軸回転=0.00
Z軸回転=0.00
中心X=!x!
中心Y=0.0
中心Z=0.0
裏面を表示しない=0
"

perf_base = '
[!num!]
start=!start!
end=!mid!
layer=5
overlay=1
camera=0
[!num!.0]
_name=画像ファイル
file=!!assets!!\perfect.png
[!num!.1]
_name=標準描画
X=0.0
Y=90.0
Z=0.0
拡大率=30.00,70.00,1
透明度=0.0
回転=0.00
blend=0'

perf_base2 = "
[!num2!]
start=!mid2!
end=!end!
layer=5
overlay=1
camera=0
chain=1
[!num2!.0]
_name=画像ファイル
[!num2!.1]
_name=標準描画
X=0.0
Y=90.0
Z=0.0
拡大率=70.00,70.00,1
透明度=0.0
回転=0.00
"
times.sort!
res = File.read("base/base.exo", encoding: Encoding::SJIS).encode(Encoding::UTF_8)
current_index = 2
ANIM = 8.0
PERF_ANIM = 2.0
combo = 0
COMBO_LAYER = 6
DW = 36
BASE = 60
times.each_with_index do |time, index|
  next_time = times[index + 1]
  combo += 1
  next if next_time == time
  next_time ||= time + 2
  if (next_time - (time + (ANIM / 60))) < 1.0 / 60
    left_x = combo.to_s.length - 1
    combo.to_s.split("").each_with_index do |c, i|
      res += base
        .gsub(/!num!/, (current_index).to_s)
        .gsub(/!start!/, (BASE + time * 60).floor.to_s)
        .gsub(/!mid!/, (BASE + next_time * 60 - 1).floor.to_s)
        .gsub(/!pers!/, (((next_time - time) / (ANIM / 60)) * 50 + 50).round(2).to_s)
        .gsub(/!x!/, ((left_x - i * 2) * DW).to_s)
        .gsub(/!dig!/, c)
        .gsub(/!layer!/, (COMBO_LAYER + i).to_s)
      current_index += 1
    end
  else
    left_x = combo.to_s.length - 1
    combo.to_s.split("").each_with_index do |c, i|
      res += base
        .gsub(/!num!/, (current_index).to_s)
        .gsub(/!start!/, (BASE + time * 60).floor.to_s)
        .gsub(/!mid!/, (BASE + ANIM + time * 60).floor.to_s)
        .gsub(/!pers!/, "100.00")
        .gsub(/!x!/, ((left_x - i * 2) * DW).to_s)
        .gsub(/!dig!/, c)
        .gsub(/!layer!/, (COMBO_LAYER + i).to_s)
      res += base2
        .gsub(/!num2!/, (current_index + 1).to_s)
        .gsub(/!mid2!/, (BASE + ANIM + 1 + time * 60).floor.to_s)
        .gsub(/!end!/, (BASE - 1 + next_time * 60).floor.to_s)
        .gsub(/!x!/, ((left_x - i * 2) * DW).to_s)
        .gsub(/!dig!/, c)
        .gsub(/!layer!/, (COMBO_LAYER + i).to_s)
      current_index += 2
    end
  end
  if (next_time - (time + (PERF_ANIM / 60))) < 4.0 / 60
    res += perf_base
      .gsub(/!num!/, (current_index).to_s)
      .gsub(/!start!/, (BASE + time * 60).floor.to_s)
      .gsub(/!mid!/, (BASE + time * 60 + [PERF_ANIM, (next_time - time) * 60 - 2].min + 1).floor.to_s)
      .gsub(/!pers!/, (((next_time - time) / (PERF_ANIM / 60)) * 40 + 30).round(2).to_s)
    current_index += 1
  else
    res += perf_base
      .gsub(/!num!/, (current_index).to_s)
      .gsub(/!start!/, (BASE + time * 60).floor.to_s)
      .gsub(/!mid!/, (BASE + PERF_ANIM + time * 60).floor.to_s)
      .gsub(/!pers!/, "70.00")
    res += perf_base2
      .gsub(/!num2!/, (current_index + 1).to_s)
      .gsub(/!mid2!/, (BASE + PERF_ANIM + 1 + time * 60).floor.to_s)
      .gsub(/!end!/, (BASE + time * 60 + [1, next_time - time].min * 60 - 1).floor.to_s)
    current_index += 2
  end
end
File.write("exos/06_combos.exo", res, encoding: Encoding::SJIS)
