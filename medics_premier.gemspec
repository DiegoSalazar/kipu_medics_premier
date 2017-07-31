# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'medics_premier/version'

Gem::Specification.new do |spec|
  spec.name          = "medics_premier"
  spec.version       = MedicsPremierClient::VERSION
  spec.authors       = ["Diego Salazar"]
  spec.email         = ["diego.salazar@kipusystems.com"]

  spec.summary       = %q{API Client for the Medics Premier system.}
  spec.description   = %q{API Client for the Medics Premier system used by (currently just 1) Kipu client. Implements API authentication via HMAC and that's about it folks.}

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
end
