#
# Node via nvm
#

module NVMHelpers
  def nvm_path
    @nvm_path ||= shell "echo $(brew --prefix nvm)/nvm.sh"
  end

  def nvm_shell(command)
    shell "NVM_DIR=~/.nvm source #{nvm_path} && #{command}"
  end
end

dep "default-node-env-4" do
  requires "default-node-env".with(version: "4")
end

dep "default-node-env", :version do
  requires "node-default".with(version: version),
           "npm-libs".with(version: version)
end

dep "nvm.managed" do
  extend NVMHelpers

  met? {
    nvm_path.p.exist?
  }
end

dep "node", :version do
  extend NVMHelpers

  requires "nvm.managed"

  met? {
    nvm_shell("nvm ls").split.grep(/v#{version}/)
  }

  meet {
    nvm_shell "nvm install #{version}"
  }
end

dep "node-default", :version do
  extend NVMHelpers

  requires "node".with(version)

  met? { nvm_shell("nvm ls").split.grep(/default -> #{version}/) }
  meet {
    nvm_shell "nvm link default #{version}"
  }
end


LIBS = %w[bower gulp webpack webpack-dev-server js-beautify coffee-script tern elm-oracle grunt-cli jsonlint elm grasp]

LIBS.each do |lib|
  dep "#{lib}.npm"
end

dep "npm-libs", :version do
  requires "dotfiles", "node-default".with(version: version)
  requires LIBS.map {|lib| "#{lib}.npm" }
end
