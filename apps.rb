dep "vim.managed" do
  meet {
    pkg_manager.install! packages, "--with-ruby --with-mzscheme --with-python"
  }
end

dep "emacs.managed" do
  meet {
    pkg_manager.install! packages, "--srgb --cocoa"
  }
end

dep "htop-osx.managed" do
  provides "htop"
  after {
    "sudo chown root:wheel /usr/local/Cellar/htop-osx/*/bin/htop"
    "sudo chmod u+s /usr/local/Cellar/htop-osx/*/bin/htop"
  }
end

# All brews and casks ala https://github.com/quad/osx

parse = -> (l) {
  n, p = l.strip.split(':')
  p = [] if p == '_' # provides nothing
  [n, -> (t) { dep "#{n}.#{t}" do provides p if p end }]
}
brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map &parse

# Define our deps
brews.each { |n, p| p['managed'] }

dep "all-apps" do
  requires "vim.managed", "emacs.managed", "all-osx-apps"

  # Require our deps
  brews.each { |n, p| requires "#{n}.managed" }
end

dep "all-osx-apps" do
  requires "VLC.app",
           "VirtualBox.installer",
           # "Vagrant.app",
           "Dropbox.app",
           "Alfred.app",
           "iTerm.app",
           # "Moom.app",
           "Transmission.app",
           "Airfoil.app",
           "calibre.app",
           # "Firefox.app",
           "Flux.app",
           "ghc-7.8.3",
           "GitHub.app",
           "Google Chrome.app",
           "GrandPerspective.app",
           "ImageOptim.app",
           "Skype.app"
end



dep "Moom.app" do
  source "http://manytricks.com/download/_do_not_hotlink_/moom321.dmg"
end

dep "Vagrant.app" do
  requires 'VirtualBox.installer'

  met? {
    "/usr/bin/vagrant".p.exists?
  }

  source "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg"
end

dep "VLC.app" do
  source "http://get.videolan.org/vlc/2.1.5/macosx/vlc-2.1.5.dmg"
end

dep "VirtualBox.installer" do
  source "http://download.virtualbox.org/virtualbox/4.3.4/VirtualBox-4.3.4-91027-OSX.dmg"
end

dep "Dropbox.app" do
  source 'http://cdn.dropbox.com/Dropbox%201.1.35.dmg'
end

dep "Alfred.app" do
  source "https://cachefly.alfredapp.com/Alfred_2.5.1_308.zip"
end

dep "iTerm.app" do
  source "https://iterm2.com/downloads/stable/iTerm2_v2_0.zip"
end

dep "Transmission.app" do
  source "https://transmission.cachefly.net/Transmission-2.84.dmg"
end

dep "Airfoil.app" do
  source "http://neutral.rogueamoeba.com/mirror/files/Airfoil.zip"
end

dep "calibre.app" do
  source "http://status.calibre-ebook.com/dist/osx32"
end

dep "Firefox.app" do
  source "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
end

dep "Flux.app" do
  source "https://justgetflux.com/mac/Flux.zip"
end

dep "ghc-7.8.3" do
  source "https://github.com/ghcformacosx/ghc-dot-app/releases/download/v7.8.3/ghc-7.8.3.zip"
end

dep "GitHub.app" do
  source "https://central.github.com/mac/latest"
end

dep "Google Chrome.app" do
  source "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
end

dep "GrandPerspective.app" do
  source "http://sourceforge.net/projects/grandperspectiv/files/grandperspective/1.5.1/GrandPerspective-1_5_1.dmg/download"
end

dep "ImageOptim.app" do
 source "https://imageoptim.com/ImageOptim.tbz2"
end

dep "Skype.app" do
  source "http://www.skype.com/go/getskype-macosx.dmg"
end

# TODO

# betterzipql
# java
# kaleidoscope
# licecap
# marked
# moom
# omnifocus
# omnigraffle
# postgres
# qlcolorcode
# qlmarkdown
# qlprettypatch
# quicklook-csv
# quicklook-json
# sourcetree
# spotify
# steam
# superduper
# textexpander
# vmware-fusion
# yojimbo
