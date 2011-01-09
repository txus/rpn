# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rpn/version"

Gem::Specification.new do |s|
  s.name        = "rpn"
  s.version     = RPN::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/txus/rpn"
  s.summary     = %q{A simple Reverse Polish Notation calculator in Ruby}
  s.description     = %q{A simple Reverse Polish Notation calculator in Ruby}

  s.rubyforge_project = "rpn"

  s.add_development_dependency 'bundler', '~> 1.0.7'
  s.add_development_dependency 'rspec',   '~> 2.4.0'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
