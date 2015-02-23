# coding: utf-8

name, version = 'traveler 0.0.1'.split
Gem::Specification.new do |spec|
  spec.name          = name
  spec.version       = version
  spec.authors       = ['Slee Woo']
  spec.email         = ['mail@sleewoo.com']
  spec.description   = 'Easily embrace Traveling Ruby awesomeness'
  spec.summary       = [name, version]*'-'
  spec.homepage      = 'https://github.com/sleewoo/' + name
  spec.license       = 'MIT'

  spec.files = Dir['**/{*,.[a-z]*}'].reject {|e| e =~ /\.(gem|lock)\Z/}
  spec.require_paths = ['lib']

  spec.executables = Dir['bin/*'].map {|f| File.basename(f)}

  spec.required_ruby_version = '>= 2.1'

  spec.add_runtime_dependency 'mustache', '~> 1'
  spec.add_runtime_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10'
end
