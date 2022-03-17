# frozen_string_literal: true
require "json"
require "stringio"
require "zlib"
require "fileutils"
require "tty-prompt"
require_relative "console"

class PSExo
  def level_data
    prompt = TTY::Prompt.new
    CPuts.info "譜面の情報を取得します。"
    CPuts.ask "譜面ID（譜面の左上の#から始まるID）を入力して下さい。"
    @chart_id = prompt.ask("譜面ID:") do |q|
      q.validate(/[A-Za-z0-9]{12}/, "譜面IDのフォーマットに沿っていません。")
    end

    get = http_get("https://servers.purplepalette.net/levels/#{@chart_id}")
    if get.code != 200
      CPuts.error "譜面が見つかりませんでした。"
      exit 1
    end
    FileUtils.mkdir_p("./dist/#{@chart_id}")
    chart_data = JSON.parse(get.body.to_s, symbolize_names: true)
    CPuts.info "譜面名：\e[m#{chart_data[:item][:title]}"
    CPuts.info "譜面作者：\e[m#{chart_data[:item][:author]}"
    data = http_get("https://servers.purplepalette.net" + chart_data[:item][:data][:url])
    stream = StringIO.new(data.body.to_s)

    Zlib::GzipReader.wrap(stream) do |gz|
      File.write("dist/#{@chart_id}/chart_data.json", gz.read)
    end
    # File.write "data/chart_id.txt", @chart_id
    CPuts.success "譜面データを取得しました。"
  end
end
