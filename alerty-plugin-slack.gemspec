# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "alerty-plugin-slack"
  spec.version       = '0.0.1'
  spec.authors       = ["MacoTasu"]
  spec.email         = ["maco.tasu+github@gmail.com"]

  spec.summary       = %q{Slack plugin for alerty}
  spec.description   = %q{Slack plugin for alerty}
  spec.homepage      = "https://github.com/macotasu/alerty-plugin-slack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "alerty"
  spec.add_runtime_dependency "slack-notifier"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
