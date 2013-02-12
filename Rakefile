# encoding: utf-8

require 'yaml'
require 'rake'

desc 'Run skeptic on all files'
task :style do
  opts = YAML.load_file('skeptic.yml')
      .map { |key, value| [key, (value == true ? nil : value)].compact }
      .map { |key, value| "--#{key.tr('_', '-')} #{value}".strip }
      .join(' ')

  librbfiles = File.join("**", "lib", "**", "*.rb")
  Dir.glob(librbfiles).each do |file|
    system("skeptic  #{opts} #{file}") or exit(1)
  end
end


desc 'Starts watchr'
task :watch do
  system 'watchr watchr.rb'
end


require 'rspec/core'
require 'rspec/core/rake_task'
desc 'Run unit specs'
RSpec::Core::RakeTask.new('unit') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end