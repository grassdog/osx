dep "vim.managed" do
  meet {
    pkg_manager.install! packages, "--with-ruby --with-mzscheme --with-python"
  }
end

dep 'emacs-port-tap' do
  meet { shell 'brew tap railwaycat/emacsmacport' }
  met? { `brew tap`.include? 'railwaycat/emacsmacport' }
end


dep "emacs-mac.managed" do
  requires 'emacs-port-tap'
  meet {
    pkg_manager.install! packages, "--with-spacemacs-icon"
  }

  met? {
    '/Applications/Emacs.app'.p.exists?
  }

  after {
    "mv /usr/local/Cellar/emacs-mac/emacs-*/Emacs.app /Applications"
  }
end


dep "spacemacs" do
  requires "emacs-mac.managed"
  met? {
    "~/.emacs.d".p.exists?
  }

  meet {
    shell "git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d"
  }
end

dep "htop-osx.managed" do
  provides "htop"
  after {
    sudo "chown root:wheel /usr/local/Cellar/htop-osx/*/bin/htop"
    sudo "chmod u+s /usr/local/Cellar/htop-osx/*/bin/htop"
  }
end

# All brews ala https://github.com/quad/osx

parse = -> (l) {
  n, p = l.strip.split(':')
  p = [] if p == '_' # provides nothing
  [n, -> (t) { dep "#{n}.#{t}" do provides p if p end }]
}
brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map(&parse)

# Define our deps
brews.each { |n, p| p['managed'] }

dep "brews" do
  # Require our deps
  brews.each { |n, p| requires "#{n}.managed" }
end

dep "base-apps" do
  requires "vim.managed", "spacemacs", "all-osx-apps", "brews"
end

dep "personal-apps" do
  requires "Steam.app",
           "Transmission.app",
           "calibre.app"
end

dep "all-osx-apps" do
  requires "Airfoil.app",
           "Alfred.app",
           "Dropbox.installer",
           "Fantastical 2.app",
           "Firefox.app",
           "Flux.app",
           "Sequel Pro.app",
           "Postico.app",
           "basictex.app",
           "Google Chrome.app",
           "GrandPerspective.app",
           "GitUp.app",
           "ImageOptim.app",
           "Java",
           "Kaleidoscope.app",
           "LICEcap.app",
           "Marked.app",
           "Moom.app",
           "OmniFocus.app",
           "OmniGraffle.app",
           "Slack.app",
           "Skype.app",
           "SourceTree.app",
           "Spotify.app",
           "SuperDuper!.app",
           "VLC.app",
           "Vagrant.installer",
           "VirtualBox.installer",
           "iTerm.app"
end

dep "Java" do
  def filename
    "jdk-8u31-macosx-x64.dmg"
  end

  def download_path
    "~/.babushka/downloads/#{filename}"
  end

  def uri
    "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/#{filename}"
  end

  met? {
    "/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk".p.exist?
  }

  meet {
    log_shell "Downloading file", "curl -L -J -X GET --cookie oraclelicense=accept-securebackup-cookie #{uri} > #{download_path}" unless download_path.p.exist?

    Babushka::Asset.for(download_path).extract {|archive|
      Dir.glob("**/*pkg").select {|entry|
        entry[/\.m?pkg$/] # Everything ending in .pkg or .mpkg
      }.reject {|entry|
        entry[/\.m?pkg\//] # and isn't inside another package
      }.map {|entry|
        log_shell "Installing #{entry}", "installer -target / -pkg '#{entry}'", :sudo => true
      }
    }
  }

  after {
    download_path.p.remove
  }
end

dep "LICEcap.app" do
  source "http://www.cockos.com/licecap/licecap125.dmg"
end

dep "Moom.app" do
  requires "Moom Settings"
  source "https://dl.dropboxusercontent.com/u/103175/Installs/moom321.dmg"
end

dep "Moom Settings" do
  def dest_file
    "~/Library/Preferences/com.manytricks.Moom.plist"
  end

  def source_file
    "#{__FILE__.p.parent}/files/com.manytricks.Moom.plist"
  end

  met? {
    dest_file.p.exists? && dest_file.p.read == source_file.p.read
  }

  meet {
    shell "cp #{source_file} #{dest_file}"
  }
end

dep "VLC.app" do
  source "http://get.videolan.org/vlc/2.1.5/macosx/vlc-2.1.5.dmg"
end

dep "VirtualBox.installer" do
  source "http://download.virtualbox.org/virtualbox/5.0.16/VirtualBox-5.0.16-105871-OSX.dmg"
end

dep "Dropbox.installer" do
  source "https://www.dropbox.com/download?plat=mac&full=1"
end

dep "GitUp.app" do
  source "https://s3-us-west-2.amazonaws.com/gitup-builds/stable/GitUp.zip"
end

dep "Alfred.app" do
  source "https://cachefly.alfredapp.com/Alfred_2.5.1_308.zip"
end

dep "Fantastical 2.app" do
  source "https://flexibits.com/fantastical/download"
end

dep "Slack.app" do
  source "https://slack.com/ssb/download-osx"
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

dep "basictex.app" do
  source "http://tug.org/cgi-bin/mactex-download/BasicTeX.pkg"

  met? {
    "/usr/local/texlive/".p.exists?
  }
end

dep "Firefox.app" do
  source "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
end

dep "Flux.app" do
  source "https://justgetflux.com/mac/Flux.zip"
end

dep "ghc-7.8.4.app" do
  source "https://github.com/ghcformacosx/ghc-dot-app/releases/download/v7.8.4-r0/ghc-7.8.4-r0.zip"
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

dep "TextExpander.app" do
  source "http://dl.smilesoftware.com/com.smileonmymac.textexpander/TextExpander.zip"
end

dep "SuperDuper!.app" do
  source "http://www.shirt-pocket.com/downloads/SuperDuper!.dmg"
end

dep "Spotify.app" do
  source "http://download.spotify.com/Spotify.dmg"
end

dep "Kaleidoscope.app" do
  source "http://cdn.kaleidoscopeapp.com/releases/Kaleidoscope-2.1.0-134.zip"
end

dep "Marked.app" do
  source "http://marked2app.com/download/Marked.zip"
end

dep "OmniFocus.app" do
  source "https://www.omnigroup.com/download/latest/omnifocus"
end

dep "OmniGraffle.app" do
  source "https://www.omnigroup.com/download/latest/omnigraffle"
end

dep "SourceTree.app" do
  source "https://downloads.atlassian.com/software/sourcetree/SourceTree_2.0.4.dmg"
end

dep "Positco.app" do
  source "https://eggerapps.at/postico/download/"
end

dep "Sequel Pro.app" do
  source "http://www.sequelpro.com/download/"
end

dep "Steam.app" do
  source "http://media.steampowered.com/client/installer/steam.dmg"
end

dep "Yojimbo.app" do
  source "https://s3.amazonaws.com/BBSW-download/Yojimbo_4.0.3.dmg"
end

dep "Vagrant.installer" do
  requires 'VirtualBox.installer'

  met? {
    "/usr/local/bin/vagrant".p.exists?
  }

  source "https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1.dmg"
end

