# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flood/version'

Gem::Specification.new do |spec|
  spec.name          = "flood"
  spec.version       = Flood::Version
  spec.authors       = ["Moski Doski"]
  spec.email         = ["moski.doski@gmail.com"]
  spec.summary       = %q{Torrent client written in Ruby}
  spec.description   = %q{Torrent client written in Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "bencode"
  spec.add_dependency 'equalizer', '~> 0.0.9'
  spec.add_dependency 'naught', '~> 1.0'
  

  spec.required_ruby_version = '>= 1.9.3'
  spec.required_rubygems_version = '>= 1.3.5'
end
