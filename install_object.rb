# frozen_string_literal: true
require "fileutils"

class PSExo
  def install_object
    if File.exist?(obj_path)
      CPuts.warn "オブジェクトがスクリプトのディレクトリに見付かりません。オブジェクトの存在確認を行いません。"
      return
    end
    path = `powershell.exe -NoLogo -NoProfile -Command "Get-Process aviutl | select -expand path"`
      .force_encoding(Encoding::Windows_31J)
      .encode(Encoding::UTF_8)
      .gsub("\\", "/")
    if path.include?("NoProcessFoundForGivenName")
      CPuts.info "aviutlが起動されていません。オブジェクトの存在確認を行いません。"
    elsif obj_path = Dir.glob(File.dirname(path) + "/Plugins/script/**/@プロセカ.obj").first
      object_info = File.read(obj_path, encoding: Encoding::SJIS)
      if object_info.include?("--version: #{VERSION}")
        CPuts.success "現在のバージョンのオブジェクトが存在します。"
      elsif object_info.include?("--version: {version}")
        CPuts.success "開発バージョンのオブジェクトが存在します。"
      else
        CPuts.info "オブジェクトのバージョンが異なります。"
        write_object(File.dirname(path) + "/Plugins/script/@プロセカ.obj")
      end
    else
      CPuts.info "オブジェクトが存在しません。"
      write_object(File.dirname(path) + "/Plugins/script/@プロセカ.obj")
    end
  end

  def write_object(path)
    FileUtils.cp(
      obj_path,
      path
    )
    CPuts.success "オブジェクトを書き込みました。"
  end

  def obj_path
    "#{__dir__}/@main.obj"
  end
end
