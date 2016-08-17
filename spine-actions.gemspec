lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spine/actions/version'

Gem::Specification.new do |spec|
  spec.name          = "spine-actions"
  spec.version       = Spine::Actions::VERSION
  spec.authors       = ["TOGGL LLC"]
  spec.email         = ["support@toggl.com"]
  spec.summary       = 'Web application request handlers.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/rspine/actions'
  spec.license       = 'BSD-3-Clause'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack', ">= 1.6"
  spec.add_dependency 'spine-content_types', ">= 0.1"

  spec.add_development_dependency 'bundler', ">= 1.10"
  spec.add_development_dependency 'rake', ">= 10.0"
end
