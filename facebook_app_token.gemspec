# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'facebook_app_token/version'

Gem::Specification.new do |spec|
  spec.name          = "facebook_app_token"
  spec.version       = FacebookAppToken::VERSION
  spec.authors       = ["Patrick Clery"]
  spec.email         = ["patrick.clery@gmail.com"]

  spec.summary       = %q{FacebookAppToken enables you to retrieve a Facebook authentication token, which is necessary to use Tinder API}
  spec.homepage      = "https://github.com/pwntrik/facebook_app_token"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mechanize", "~> 2.0"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
