# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{credit_card_validator}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Crawley"]
  s.date = %q{2009-03-17}
  s.description = %q{A gem that provides credit card validation. It is basically a ruby port of the javascript credit card validator by Thomas Fuchs (madrobby) (http://github.com/madrobby/creditcard_js).}
  s.email = ["tcrawley@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/credit_card_validator.rb", "lib/credit_card_validator/validator.rb", "test/test_credit_card_validator.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tobias/credit_card_validator}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{credit_card_validator}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A gem that provides credit card validation}
  s.test_files = ["test/test_credit_card_validator.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
