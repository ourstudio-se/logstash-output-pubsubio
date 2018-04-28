Gem::Specification.new do |s|
  s.name          = 'logstash-output-pubsubio'
  s.version       = '0.0.1'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'A logstash output plugin to publish events to a Google Cloud PubSub topic'
  s.description   = ''
  s.homepage      = 'https://github.com/ourstudio/logstash-output-pubsubio'
  s.authors       = ['Björn Vikström', 'Martin Bergqvist']
  s.email         = ['bjorn@ourstudio.se', 'martin@ourstudio.se']
  s.require_paths = ['lib']

  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE']
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "logstash-codec-plain", "~> 3.0"
  s.add_runtime_dependency "logstash-codec-json", "~> 3.0"
  s.add_runtime_dependency "google-api-client", "~> 0.9"
  s.add_development_dependency "logstash-devutils", "~> 0"
end
