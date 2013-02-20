# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "carrierwave-aliyun-crud"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jiang Peng"]
  s.email       = ["pengj0520@gmail.com"]
  s.homepage    = "https://github.com/warmwind/carrierwave-aliyun-crud"
  s.summary     = %q{Aliyun OSS support for Carrierwave}
  s.description = %q{Aliyun OSS support for Carrierwave}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "carrierwave", [">= 0.5.7"]
  s.add_dependency "rest-client", [">= 1.6.7"]
end
