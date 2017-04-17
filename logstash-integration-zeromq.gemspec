Gem::Specification.new do |s|
  s.name          = 'logstash-integration-zeromq'
  s.version       = '0.1.0'
  s.licenses      = ['Apache License (2.0)']
  s.summary       = 'Logstash integration with ZeroMQ with input filter and output plugins'
  s.homepage      = 'https://elastic.co'
  s.authors       = ['Joao Duarte']
  s.email         = 'jsvduarte@gmail.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "pack" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "ffi-rzmq", "~> 2.0"
  s.add_development_dependency 'logstash-devutils'
  s.add_development_dependency 'logstash-codec-json'
end
