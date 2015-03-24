#
# Ruby via chruby
#

dep "default-ruby-env-2.2.0" do
  requires "default-ruby-env".with(version: "2.2.0")
end

dep "default-ruby-env", :version do
  requires "dotfiles",
           "ruby-env".with(version: version),
           "ruby-version".with(version: version),
           "gems".with(version: version)
end

dep "ruby-env", :version do
  version.ask("Which version of Ruby would you like to install?")

  requires "ruby".with(version: version),
           "gems".with(version: version)
end

GEMS = %w[bundler pry powder klipbook taskmeister]

GEMS.each do |gem|
  dep "#{gem}-gem", :version do
    "gem".with(gem_name: gem, ruby_version: version)
  end
end

dep "gems", :version do
  requires "dotfiles", "ruby".with(version: version)
  requires GEMS.map {|gem| "#{gem}-gem".with(version: version) }
end

dep "ruby-version", :version do
  def file
    "~/.ruby-version"
  end

  def contents
    "#{version}\n"
  end

  met? { file.p.read == contents }
  meet { file.p.write contents }
end

dep "rubies.dir" do
  path "~/.rubies"
end

dep "ruby", :version do
  requires "ruby-build up to date",
           "chruby.managed",
           "rubies.dir"

  def base_path
    "~/.rubies"
  end

  def build_path
    base_path / version
  end

  met? {
    build_path.p.exists?
  }

  meet {
    shell "mkdir -p #{base_path}", :sudo => true
    log_shell "Building via ruby-build", "/usr/local/bin/ruby-build #{version} #{build_path}"
  }
end

dep "ruby-build.managed"

dep "ruby-build up to date" do
  requires "ruby-build.managed"

  before {
    Babushka.host.pkg_helper.update_pkg_lists
  }

  meet {
    shell("brew upgrade ruby-build")
  }
end

# TODO Simplify this business if ww ensure we can source chruby before running it

dep "gem", :gem_name, :version, :ruby_version do
  version.default!(:unset)

  requires "chruby.managed"

  def version?
    version != :unset
  end

  def version_switch
    if version?
      "-v #{version}"
    else
      ""
    end
  end

  def version_test
    if version?
      /#{gem_name}\s+\([^(]*#{Regexp.escape version}/
    else
      /#{gem_name}/
    end
  end

  met? {
    log "Checking for gem #{gem_name} #{version_switch} under #{ruby_version}"
    shell("chruby-exec #{ruby_version} -- gem list #{gem_name}") =~ version_test
  }
  meet {
    log "Installing gem #{gem_name} #{version_switch} under #{ruby_version}"
    log_shell "gem install #{gem_name} #{version_switch}", "chruby-exec #{ruby_version} -- gem install #{gem_name} #{version_switch}"
  }
end

