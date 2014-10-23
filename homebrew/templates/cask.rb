# Installs a particular Homebrew Cask package
#
#   * installs: The list of cask names to install (optional, defaults
#               to the base name of the dep)
meta :cask do
  accepts_list_for :installs, :basename, :choose_with => :via

  template {
    requires CaskHelper.manager_dep
    met? { installs.all? {|pkg| CaskHelper.has?(pkg) } }
    meet { CaskHelper.handle_install! installs }
  }
end
