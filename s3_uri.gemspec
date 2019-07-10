# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "s3_uri"
  spec.version       = S3URI::VERSION
  spec.authors       = ['Brett Wilkins', 'Gabriel Rotbart']
  spec.email         = ['brett@hooroo.com', 'gabe@hooroo.com']
  spec.description   = %q{A quick and easy URI builder for an object in S3}
  spec.summary       = %q{A quick and easy URI builder for an object in S3}
  spec.homepage      = "https://github.com/hooroo/s3_uri"
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'aws-sdk', '~> 2'

  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
