#!/usr/bin/env rake
require 'rake'
require 'rdoc/task'
require 'rspec'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

desc 'Generate documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SalesKing Calculation'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

#require "bundler/gem_tasks"
########### to be dropped when we go public
require "bundler/gem_helper"
puts "\n== INFO: == \n'rake release' does NOT release to rubygems and just tags/build into git origin\n\n"
module Bundler
  class GemHelper
    def rubygem_push(path)
      Bundler.ui.confirm "No Push to rubygems.org yet!"      
    end
  end
end
Bundler::GemHelper.install_tasks