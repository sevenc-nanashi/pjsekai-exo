# frozen_string_literal: true

desc "ocraでスクリプトをビルドします。"
task :build do
  require "digest"
  require "http"

  hashes = [
    *Dir.glob("*.rb"),
    *Dir.glob("exos/*.exo"),
  ].map do |file|
    Digest::SHA256.file(file).hexdigest
  end
  HTTP.get("https://curl.se/ca/cacert.pem").then do |cert|
    File.write("./cacert.pem", cert)
  end

  hash = hashes.sort.join("\n")
  if File.exist?("build.hash") && File.read("build.hash") == hash && File.exist?("pjsekai-exo.exe")
    puts "ハッシュが変更されていません。無視します。"
  else
    sh "ocra --gem-all --icon icon.ico --output pjsekai-exo.exe main.rb exos/* cacert.pem"
    File.write("build.hash", hash)
  end
end

desc "zipを作ります。"
task :pack do
  require "fileutils"
  require_relative "main"

  name = "pjsekai-exo@#{PSExo::VERSION}"
  FileUtils.mkdir_p("pack/#{name}") unless Dir.exist?("pack/#{name}")
  PSExo.new.replace_version
  FileUtils.mv("./replaced.tmp.obj", "pack/#{name}/@プロセカ.obj")
  FileUtils.cp_r("assets/.", "pack/#{name}/assets/.")
  FileUtils.cp_r("zip_readme.txt", "pack/#{name}/README.txt")
  Rake::Task["build"].invoke
  FileUtils.cp("pjsekai-exo.exe", "pack/#{name}/pjsekai-exo.exe")
  FileUtils.rm("#{name}.zip") if File.exist?("#{name}.zip")
  sh %{powershell -NoProfile -NoLogo -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('pack/#{name}', './#{name}.zip'); }"}
  puts "#{name}.zipを作成しました。"
end

desc "rubocopでLintします。"
task :lint do
  sh "rubocop *.rb"
end

desc "rubocopのエラーを修正します。"
task "lint:fix" do
  sh "rubocop *.rb -A"
end

desc "Gitのタグをつけます。"
task :tag do
  require_relative "main"
  sh "git tag #{PSExo::VERSION} -f"
end
