# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sk_calc/version'

Gem::Specification.new do |s|
  s.name = %q{sk_calc}
  s.version = SK::Calc::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Georg Leciejewski"]
  s.date = %q{2011-12-17}
  s.description = %q{Calculate document and line item totals. This moule is used inside SalesKIng and outsourced for transparency and reusability.}
  s.email = %q{gl@salesking.eu}
  s.homepage = %q{http://github.com/salesking/sk_calc}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{SalesKing Calculation Module}

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'rake', '>= 0.9.2'

end

