# frozen_string_literal: true

#
# 綺麗にログを出力するためのモジュール。
#
module CPuts
  module_function
  #
  # 警告ログを出力します。
  #
  # @param [#to_s] message メッセージ。
  #
  # @return [void]
  #
  def warn(message)
    puts "\e[93m!) \e[0m #{message}"
  end

  #
  # エラーログを出力します。
  #
  # @param [#to_s] message メッセージ。
  #
  # @return [void]
  #
  def error(message)
    puts "\e[91m×) \e[0m #{message}"
  end

  #
  # 情報ログを出力します。
  #
  # @param [#to_s] message メッセージ。
  #
  # @return [void]
  #
  def info(message)
    puts "\e[96mi) \e[0m #{message}"
  end

  #
  # 完了ログを出力します。
  #
  # @param [#to_s] message メッセージ。
  #
  # @return [void]
  #
  def success(message)
    puts "\e[92m✓) \e[0m #{message}"
  end

  #
  # 確認ログを出力します。
  #
  # @param [#to_s] message メッセージ。
  #
  # @return [void]
  #
  def ask(message)
    puts "\e[90m?) \e[0m #{message}"
  end
end
