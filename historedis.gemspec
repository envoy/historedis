
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "historedis"

Gem::Specification.new do |spec|
  spec.name          = "historedis"
  spec.version       = Historedis::VERSION
  spec.authors       = ["arunthampi"]
  spec.email         = ["arun.thampi@gmail.com"]

  spec.summary       = %q{Gem which can be used to track/visualize simple stats in Redis}
  spec.description   = %q{Gem which can be used to track/visualize simple stats in Redis}
  spec.homepage      = "https://github.com/envoy/historedis.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             "redis"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "fakeredis", "~> 0.7.0"
  spec.add_development_dependency "activesupport", "~> 5.2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
