source "https://rubygems.org"
require 'resolv-replace'
gem "ethon", ">=0.13.0"
gem "ffi"
gem "fastlane"
gem "cocoapods"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
