# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crefo/version'

Gem::Specification.new do |spec|
  spec.name          = 'crefo'
  spec.version       = Crefo::VERSION
  spec.authors       = ['Timo Schilling']
  spec.email         = ['timo@schilling.io']

  spec.summary       = 'Ruby client for the Creditreform API.'
  spec.homepage      = 'https://github.com/COMPEON/crefo'

  spec.required_ruby_version = '>= 2.3.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'nori'
  spec.add_runtime_dependency 'mail'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.0'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry'
end
