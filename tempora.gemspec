# frozen_string_literal: true

require_relative "lib/tempora/version"

Gem::Specification.new do |spec|
  spec.name = "tempora"
  spec.version = Tempora::VERSION
  spec.authors = ["Max Power"]
  spec.email = ["kevin.melchert@gmail.com"]

  spec.summary = "Tempora is a lightweight Ruby library for handling months, weeks, quarters, and years."
  spec.description = "Tempora is a lightweight Ruby library for handling months, weeks, quarters, and years with intuitive date-based calculations and range support."
  spec.homepage = "https://github.com/max-power/tempora"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "i18n"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
