# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_five_push/version'

Gem::Specification.new do |spec|
  spec.name          = "cloud_five_push"
  spec.version       = CloudFivePush::VERSION
  spec.authors       = ["Brian Samson"]
  spec.email         = ["brian@tenforwardconsulting.com"]
  spec.summary       = %q{Wraps the API for push.cloudfiveapp.com}
  spec.description   = %q{Dead simple push notifications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "httparty"
end
