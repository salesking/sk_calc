# encoding: utf-8
require 'simplecov'
require 'yaml'
require 'rspec'
require 'active_support'

SimpleCov.start do
  root File.join(File.dirname(__FILE__), '..')
  add_filter "/bin/"
  add_filter "/spec/"
end

require "#{File.dirname(__FILE__)}/../lib/sk_calc"
