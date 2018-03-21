require File.expand_path('../lib/foreman_spacewalk/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'foreman_spacewalk'
  s.version     = ForemanSpacewalk::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Timo Goebel']
  s.email       = ['timo.goebel@dm.de']
  s.homepage    = 'https://github.com/dm-drogeriemarkt/foreman_spacewalk'
  s.summary     = 'Spacewalk integration for Foreman.'
  # also update locale/gemspec.rb
  s.description = 'Spacewalk integration for Foreman.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rubocop', '0.52.0'
end
