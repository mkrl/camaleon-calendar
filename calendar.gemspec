$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "calendar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "calendar"
  s.version     = Calendar::VERSION
  s.authors     = ["mkrl"]
  s.email       = ["tradecontent@gmail.com"]
  s.homepage    = ""
  s.summary     = ": Summary of Calendar."
  s.description = ": Description of Calendar."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "camaleon_cms", "~> 2.0"

  s.add_development_dependency "sqlite3"
end
