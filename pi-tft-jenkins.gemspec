# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pi/tft/jenkins/version'

Gem::Specification.new do |spec|
  spec.name          = "pi-tft-jenkins"
  spec.version       = Pi::Tft::Jenkins::VERSION
  spec.authors       = ["Yu Nejigane"]
  spec.email         = ["nejigane@preferred.jp"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://nzgn.net/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "rsvg2"
  spec.add_dependency "sinatra"
end
