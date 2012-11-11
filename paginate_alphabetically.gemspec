Gem::Specification.new do |gem|
  gem.name = %q{paginate_alphabetically}
  gem.version = "0.4"

  gem.required_rubygems_version = Gem::Requirement.new(">= 0") if gem.respond_to? :required_rubygems_version=
  gem.authors = ["Steve Tooke", "Aimee Daniells", "Chris Parsons", "Jamie Cobbett"]
  gem.date = %q{2012-11-10}
  gem.summary = %q{An easy way to paginate a list of ActiveRecord objects alphabetically by any given attribute.}
  gem.description = %q{Provides a list of available letters, and a way of fetching the records for each letter.}
  gem.email = %q{chris+paginate_alphabetically@thinkcodelearn.com}
  gem.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.homepage = %q{http://github.com/edendevelopment/paginate_alphabetically}
  gem.rdoc_options = ["--charset=UTF-8"]
end

