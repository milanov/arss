Gem::Specification.new do |s|
  s.name        = "arss"
  s.version     = File.open('VERSION').read
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Milan Milanov"]
  s.email       = ["whizzer.me@gmail.com"]
  s.homepage    = 'https://github.com/milanov/arss'
  s.summary     = %q{Simple feed parser.}
  s.description = %q{Arss is a simple parser for news feeds that currently suppors only RSS 2.0}

  rbfiles = File.join("**", "*.rb")
  s.files = Dir.glob(rbfiles)

  s.require_paths = ["lib"]
end