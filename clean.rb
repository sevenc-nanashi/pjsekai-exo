# frozen_string_literal: true
require "fileutils"

class PSExo
  def cleanup
    FileUtils.rm_rf("./dist/#{@chart_id}/chart_data.json")
    FileUtils.rm_rf("./dist/#{@chart_id}/score.json")
    FileUtils.rm_rf("./dist/#{@chart_id}/data.tmp.ped")
    CPuts.success "一時ファイルを削除しました。"
  end
end
