# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rb_reloader/version"

Gem::Specification.new do |s|
  s.name        = "rb_reloader"
  s.version     = RbReloader::VERSION
  s.authors     = ["arkxu"]
  s.email       = ["ark.work@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Reload the ruby file timely if it has been changed}
  s.description = %q{You set the path that needs monitored, and the gem will do the reload for you automatically if the file has been changed}

  s.rubyforge_project = "rb_reloader"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec", ">= 1.3.0"
  s.add_development_dependency "ruby-debug"
end
