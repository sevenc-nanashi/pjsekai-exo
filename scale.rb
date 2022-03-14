class PEDWizard
  SOF_SECOND_BYTE = 0xc0..0xcf

  def calc_scale(path)
    width = 0
    File.open(path, "rb") do |file|
      if file.read(4) == [0x89, 0x50, 0x4E, 0x47].pack("C*")
        file.seek(0x10, IO::SEEK_SET)
        width = file.read(4).unpack1("l>")
        next
      end
      file.seek(0, IO::SEEK_SET)
      if file.read(2) == [0xFF, 0xD8].pack("C*")
        until (file.read(1) == [0xFF].pack("C*")) &&
              (SOF_SECOND_BYTE === file.read(1).unpack1("C"))
          file.seek(file.read(2).unpack1("s>") - 2, IO::SEEK_CUR)
        end
        file.seek(3, IO::SEEK_CUR)
        width = file.read(2).unpack1("s>")
        next
      end
      CPuts.error("#{path}をパースできませんでした。pngかjpegのみ対応しています。")
      # height = file.read(4).unpack1("l>")
    end
    395.0 / width * 100
  end
end
