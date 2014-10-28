dep "dev env in place" do
  requires "zsh as shell",
           "code folder is setup",
           "npm libs installed",
           "2.1.4.rubyenv",
           "dotfiles installed"
end

#
# Env
#

dep "zsh as shell", :username do
  username.default!(shell("whoami"))
  requires "zsh.managed"
  met? { shell("sudo su - '#{username}' -c 'echo $SHELL'") == which("zsh") }
  meet { sudo("chsh -s '#{which('zsh')}' #{username}") }
end

dep "code folder is setup" do
  requires "project directory is linked",
           "scripts directory is linked",
           "explorations directory is linked"

end

dep "code directory exists" do
  met? { "~/code".p.dir? }
  meet { log_shell "Creating ~/code", "mkdir ~/code" }
end

dep "project directory is linked" do
  requires "code directory exists"

  met? { "~/code/projects".p.readlink == "/Users/#{shell("whoami")}/Dropbox/Code/projects" }
  meet { shell "ln -s ~/Dropbox/Code/projects ~/code/projects" }
end

dep "scripts directory is linked" do
  requires "code directory exists"

  met? { "~/code/scripts".p.readlink == "/Users/#{shell("whoami")}/Dropbox/Code/scripts" }
  meet { shell "ln -s ~/Dropbox/Code/scripts ~/code/scripts" }
end

dep "explorations directory is linked" do
  requires "code directory exists"

  met? { "~/code/explorations".p.readlink == "/Users/#{shell("whoami")}/Dropbox/Code/explorations" }
  meet { shell "ln -s ~/Dropbox/Code/explorations ~/code/explorations" }
end

dep "dotfiles.repo" do
  source "https://github.com/grassdog/dotfiles"
  path "~/.dotfiles"
end

# TODO Migrate these rake tasks into deps
dep "dotfiles installed" do
  requires "dotfiles.repo"

  met? { "~/.zshrc".p.readlink == "/Users/#{shell("whoami")}/.dotfiles/zshrc" }
  meet {
    cd "~/.dotfiles" do
      shell "rake bootstrap"
    end
  }
end

#
# Npm
#

dep "npm libs installed" do
  requires "js-beautify.npm",
           "coffee-script.npm"
end

dep "js-beautify.npm" do
  requires "node.managed"
end

dep "coffee-script.npm" do
  requires "node.managed"
end


#
# Ruby
#

meta "rubyenv" do
  accepts_value_for :version, :basename

  template {
    requires "ruby".with(version: version),
             "gem".with(gem_name: "bundler",     ruby_version: version),
             "gem".with(gem_name: "pry",         ruby_version: version),
             "gem".with(gem_name: "powder",      ruby_version: version),
             "gem".with(gem_name: "klipbook",    ruby_version: version),
             "gem".with(gem_name: "taskmeister", ruby_version: version),
             "ruby version file".with(version: version)
  }
end

dep "2.1.4.rubyenv"

dep "ruby version file", :version do
  met? { "~/.ruby-version".p.read == version }
  meet { "~/.ruby-version".p.write version }
end

dep "rubies directory exists" do
  met? { "~/.rubies".p.dir? }
  meet { log_shell "Creating ~/.rubies", "mkdir ~/.rubies" }
end

dep "ruby", :version do
  requires "ruby-build.managed",
           "chruby.managed",
           "rubies directory exists"

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

# TODO Add dep to create ssh dir and chmod 700
# TODO Add dep to create ssh config

dep 'ssh keys generated', :ssh_dir, :ssh_password do
  ssh_dir.ask("Where do you keep your ssh keys").default!('~/.ssh')
  ssh_password.ask("Passphase to encrypt your SSH key")

  met? {
    (ssh_dir / 'id_rsa.pub').exists? && (ssh_dir / 'id_rsa').exists?
  }
  meet {
    shell "ssh-keygen -t rsa -N #{ ssh_password } -f #{ ssh_dir }/id_rsa"
  }
  after {
    shell "/usr/bin/ssh-add -K"
  }
end

dep "github has my public key", :github_username, :github_password do
  requires "ssh keys generated"

  def github_api
    "https://api.github.com"
  end

  def public_key
    shell("cat ~/.ssh/id_rsa.pub")
  end

  def hostname
    shell("hostname")
  end

  met? {
    raw_shell("ssh -T git@github.com 2>&1").stdout["successfully authenticated"]
  }
  meet {
    github_username.ask("What is your github username")
    github_password.ask("What is your github password")
    auth = "#{github_username}:#{github_password}"
    args = "{\"title\": \"#{hostname}\", \"key\": \"#{public_key}\"}"
    shell "curl -u '#{auth}' -d '#{args}' #{github_api}/user/keys"
  }
end

