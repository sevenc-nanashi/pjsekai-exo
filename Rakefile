# frozen_string_literal: true

desc "ocraでスクリプトをビルドします。"
task :build do
  sh "ocra --gem-all --icon icon.ico --output pjsekai-exo.exe main.rb exos/*"
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
  sh "git tag #{PEDWizard::VERSION} -f"
end
