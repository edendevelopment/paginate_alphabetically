Gem::Specification.new do |gem|
  gem.name = %q{paginate_alphabetically}
  gem.version = "0.3.3"

  gem.required_rubygems_version = Gem::Requirement.new(">= 0") if gem.respond_to? :required_rubygems_version=
  gem.authors = ["Eden Development"]
  gem.date = %q{2010-12-22}
  gem.summary = %q{An easy way to paginate a list of ActiveRecord objects alphabetically by any given attribute.}
  gem.description = %q{Provides a list of available letters, and a way of fetching the records for each letter.}
  gem.email = %q{dev+paginate_alphabetically@edendevelopment.co.uk}
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

