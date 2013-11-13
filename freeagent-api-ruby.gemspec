# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freeagent/version"

Gem::Specification.new do |s|
  s.name = 'freeagent-api-ruby'
  s.version = FreeAgent::VERSION
  s.date = '2012-08-16'
  s.summary = 'FreeAgent API 2 Client Library'
  s.description = 'Easily access the FreeAgent API 2'
  s.authors = ['Murray Summers']
  s.email = 'murray@freeagent.com'
  s.homepage = "https://github.com/murraysum/freeagent-api-ruby"

  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"

  s.add_runtime_dependency "oauth2", "~> 0.9.2"
  s.add_runtime_dependency "multi_json"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
