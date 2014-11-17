# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_traceable/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise_traceable'
  spec.version       = DeviseTraceable::VERSION
  spec.authors       = ['Anand Bait']
  spec.email         = ['anand.bait@allerin.com']
  spec.summary       = %q{A Ruby gem to trace devise user session details}
  spec.description   = %q{A Ruby gem to trace devise user session details like sign_in_at, sign_out_at, ip_address}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'devise'
end
