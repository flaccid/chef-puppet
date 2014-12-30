#!/usr/bin/env rake

require 'foodcritic'
require 'rubocop/rake_task'

namespace :test do
  RuboCop::RakeTask.new(:rubocop)
  FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
    t.options = { fail_tags: ['any'] }
  end

  task all: [:rubocop, :foodcritic]
end

task default: 'test:all'
