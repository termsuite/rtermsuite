# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rtermsuite/version'

Gem::Specification.new do |spec|
  spec.name          = "rtermsuite"
  spec.version       = Rtermsuite::VERSION
  spec.authors       = ["Damien Cram"]
  spec.email         = ["damien.cram@univ-nantes.fr"]

  spec.summary       = %q{A JRuby wrapper for TermSuite}
  spec.description   = %q{Rtermsuite is a JRuby wrapper for TermSuite}
  spec.homepage      = "https://github.com/termsuite/rtermsuite"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
