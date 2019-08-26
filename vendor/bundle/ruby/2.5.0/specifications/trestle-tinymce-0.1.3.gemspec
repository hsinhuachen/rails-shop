# -*- encoding: utf-8 -*-
# stub: trestle-tinymce 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "trestle-tinymce".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sam Pohlenz".freeze]
  s.date = "2018-09-18"
  s.description = "TinyMCE integration plugin for the Trestle admin framework.".freeze
  s.email = ["sam@sampohlenz.com".freeze]
  s.homepage = "https://www.trestle.io".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "TinyMCE integration plugin for the Trestle admin framework".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<trestle>.freeze, ["~> 0.8", ">= 0.8.8"])
      s.add_runtime_dependency(%q<tinymce-rails>.freeze, ["~> 4.6"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<trestle>.freeze, ["~> 0.8", ">= 0.8.8"])
      s.add_dependency(%q<tinymce-rails>.freeze, ["~> 4.6"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<trestle>.freeze, ["~> 0.8", ">= 0.8.8"])
    s.add_dependency(%q<tinymce-rails>.freeze, ["~> 4.6"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
