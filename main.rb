# frozen_string_literal: true
require_relative "level_data"
require_relative "calc_score"
require_relative "pack"
require_relative "configure"
require_relative "scale"
require_relative "console"

#
# .pedファイルを生成するモジュール。
#
class PEDWizard
  def start
    level_data
    calc_score
    pack
    configure
  rescue Interrupt
    puts
    CPuts.error "中断しました。"
  end
end

if __FILE__ == $0
  PEDWizard.new.start
end
