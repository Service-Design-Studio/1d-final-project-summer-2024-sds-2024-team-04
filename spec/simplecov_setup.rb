# spec/simplecov_setup.rb
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/' # Exclude test files from coverage calculation
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
end