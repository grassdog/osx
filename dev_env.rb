dep "dev-env" do
  requires "zsh as shell",
           "code-folder",
           "dotfiles",
           "npm-libs",
           "default-node-env-4",
           "default-ruby-env-2.2.0",
           "mongodb-service-installed",
           "rust",
           "dev colour picker",
           "secrets",
           "klipbookrc",
           "proselint.pip"
end

#
# Env
#

dep "zsh as shell", :username do
  username.default!(shell("whoami"))
  requires "zsh.managed", "zshenv fixed"
  met? { shell("sudo su - '#{username}' -c 'echo $SHELL'") == which("zsh") }
  meet { sudo("chsh -s '#{which('zsh')}' #{username}") }
end

dep "zshenv fixed" do
  on :osx do
    met? { !"/etc/zshenv".p.exists? && "/etc/zprofile".p.exists? }
    meet {
      shell "sudo mv /etc/zshenv /etc/zprofile"
    }
  end
end

dep "code-folder" do
  requires "project.dir",
           "scripts directory is linked",
           "explorations.dir"

end

dep "code.dir" do
  path "~/code"
end

dep "project.dir" do
  requires "code.dir"
  path "~/code/projects"
end

dep "scripts directory is linked" do
  requires "code.dir"

  met? { "~/code/scripts".p.readlink == "/Users/#{shell("whoami")}/Dropbox/Code/scripts" }
  meet { shell "ln -s ~/Dropbox/Code/scripts ~/code/scripts" }
end

dep "explorations.dir" do
  requires "code.dir"
  path "~/code/explorations"
end

dep "dotfiles.repo" do
  source "https://github.com/grassdog/dotfiles"
  path "~/.dotfiles"
end

# TODO Migrate these rake tasks into deps
dep "dotfiles" do
  requires "dotfiles.repo"

  met? { "~/.zshrc".p.readlink == "/Users/#{shell("whoami")}/.dotfiles/zshrc" }
  meet {
    cd "~/.dotfiles" do
      shell "rake bootstrap"
    end
  }
end


dep "pow" do
  met? {
    "~/Library/Application Support/Pow/Current".p.exists?
  }

  meet {
    shell "curl get.pow.cx | sh"
  }
end

dep "rust" do
  met? { shell? "rustc" }
  meet {
    log_shell "Installing Rust. This takes a while.", "curl -sSf https://static.rust-lang.org/rustup.sh | sh"
  }
end

dep "mongodb-service-installed" do
  requires "mongodb-launchagents-linked",
           "mongodb-launchctl-loaded"
end

dep "mongodb-launchagents-linked" do
  requires "mongodb.managed"

  met? { "~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist".p.exist? }
  meet {
    shell "ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents"
  }
end

dep "mongodb-launchctl-loaded" do

  met? {
    !shell("launchctl list").split("\n").grep(/homebrew\.mxcl\.mongodb/).empty?
  }
  meet {
    shell "launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
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

dep "read_only file", :file, :contents do
  met? {
    file.p.exist? && shell("stat #{file}")["-rw-------"]
  }
  meet {
    shell "echo #{contents} > #{file}"
    shell "chmod 600 #{file}"
  }
end

# Colour pickers

dep "colorpickers.dir" do
  path "~/Library/ColorPickers"
end

dep "dev colour picker", template: "file" do
  requires "colorpickers.dir"

  source "http://download.panic.com/picker/developercolorpicker.zip"
  name "DeveloperColorPicker.colorPicker"
  target "~/Library/ColorPickers/DeveloperColorPicker.colorPicker"
end

# Insert \\n at prompt to inject newlines

dep "secrets" do
  requires "read_only file".with(file: "~/.secrets")
end

dep "klipbookrc" do
  requires "read_only file".with(file: "~/.klipbookrc")
end

dep 'proselint.pip'
