require 'rake'
require 'spec/rake/spectask'
require 'jeweler'

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :spec do
  desc "Run all specs in spec directory with RCov"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true
    t.rcov_opts = ["--exclude spec/*,gems/*,lib/tasks/*,app/analytics/application_metrics.rb"]
  end
end



Jeweler::Tasks.new do |gemspec|
  gemspec.name = "amikula-sprite"
  gemspec.summary = "generate your css sprites automagically"
  gemspec.description = "sprite is a rails/merb plugin that generates sprites for css, sass"
  gemspec.email = "amikula@gmail.com"
  gemspec.homepage = "http://github.com/amikula/sprite"
  gemspec.authors = ["Jacques Crocker", "Alf Mikula"]
  gemspec.files.exclude '.gitignore'

  # removing test files and specs from the gem to save space
  gemspec.files -= Dir.glob("spec/**/*")
  gemspec.test_files = []
end
Jeweler::GemcutterTasks.new

