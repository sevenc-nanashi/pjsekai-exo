# frozen_string_literal: true

desc "ocraでスクリプトをビルドします。"
task :build do
  sh "ocra --gem-all --output pjsekai-exo.exe main.rb"
end

desc "rubocopでLintします。"
task :lint do
  sh "rubocop *.rb"
end

desc "rubocopのエラーを修正します。"
task "lint:fix" do
  sh "rubocop *.rb -A"
end
