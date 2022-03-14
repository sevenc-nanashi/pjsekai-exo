# frozen_string_literal: true
require_relative "level_data"
require_relative "calc_score"
require_relative "pack"
require_relative "configure"
require_relative "scale"
require_relative "http_lib"
require_relative "clean"
require_relative "console"

#
# .pedファイルを生成するモジュール。
#
class PEDWizard
  def start
    logo
    level_data
    calc_score
    pack
    configure
    cleanup
  rescue Interrupt
    puts
    CPuts.error "中断しました。"
  end

  def logo
    puts <<~LOGO
           #{color_escape 0x00bbd0}== pjsekai-exo ----------------------------------------------------------------\e[m
             pjsekai-exo - プロセカ風exoファイルジェネレーター
             Developed by #{color_escape 0x48b0d5}名無し｡(@sevenc-nanashi)\e[m

             https://github.com/sevenc-nanashi/pjsekai-exo
           #{color_escape 0xff5a91}-------------------------------------------------------------------------------\e[m
           
         LOGO
  end

  def color_escape(hex)
    _, red, green, blue = [hex].pack("L").unpack("C*").reverse
    "\e[38;2;#{red};#{green};#{blue}m"
  end
end

PEDWizard.new.start if (__FILE__ == $PROGRAM_NAME) && !defined? Ocra
