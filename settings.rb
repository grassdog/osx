dep "all settings in place" do
  requires "auto hide dock",
           "full keyboard access to controls",
           "short key repeat delay",
           "fast key repeat rate",
           "show users Library folder",
           "expanded save panel",
           "expanded print panel",
           "no launch warnings",
           "no press and hold",
           "no auto-correct",
           "Copy from Quicklook windows",
           "full path in window titles",
           "debug menu in safari enabled",
           "timezone is perth"

  after {
    shell "killall -u `whoami` Dock"
    shell "killall -u `whoami` Finder"
  }
end

dep "auto hide dock" do
  met? { shell("defaults read com.apple.dock autohide") == "1" }
  meet { shell "defaults write com.apple.dock autohide -bool true" }
end

dep "full keyboard access to controls" do
  met? { `defaults read NSGlobalDomain AppleKeyboardUIMode`.strip == "3" }
  meet { shell "defaults write NSGlobalDomain AppleKeyboardUIMode -int 3" }
end

dep "fast key repeat rate" do
  met? { `defaults read NSGlobalDomain KeyRepeat`.strip == "2" }
  meet { shell "defaults write NSGlobalDomain KeyRepeat -int 2" }
end

dep "short key repeat delay" do
  met? { `defaults read NSGlobalDomain InitialKeyRepeat`.strip == "12" }
  meet { shell "defaults write NSGlobalDomain InitialKeyRepeat -int 12" }
end

dep "show users Library folder" do
  meet { shell "chflags nohidden ~/Library" }
end

dep "expanded save panel" do
  met? { `defaults read NSGlobalDomain NSNavPanelExpandedStateForSaveMode`.strip == "1" }
  meet { shell "defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true" }
end

dep "expanded print panel" do
  met? { `defaults read NSGlobalDomain PMPrintingExpandedStateForPrint`.strip == "1" }
  meet { shell "defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true" }
end

dep "no launch warnings" do
  met? { `defaults read com.apple.LaunchServices LSQuarantine`.strip == "0" }
  meet { shell "defaults write com.apple.LaunchServices LSQuarantine -bool false" }
end

dep "no press and hold" do
  met? { `defaults read NSGlobalDomain ApplePressAndHoldEnabled`.strip == "0" }
  meet { shell "defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false" }
end

dep "no auto-correct" do
  met? { `defaults read NSGlobalDomain NSAutomaticSpellingCorrectionEnabled`.strip == "0" }
  meet { shell "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false" }
end

dep "Copy from Quicklook windows" do
  met? { `defaults read com.apple.finder QLEnableTextSelection`.strip == "1" }
  meet { shell "defaults write com.apple.finder QLEnableTextSelection -bool true" }
end

dep "full path in window titles" do
  met? { `defaults read com.apple.finder _FXShowPosixPathInTitle`.strip == "1" }
  meet { shell "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" }
end

dep "debug menu in safari enabled" do
  met? { `defaults read com.apple.Safari IncludeDebugMenu`.strip == "1" }
  meet { shell "defaults write com.apple.Safari IncludeDebugMenu -bool true" }
end

dep "timezone is perth" do
  met? { `sudo systemsetup -gettimezone`.strip == "Time Zone: Australia/Perth" }
  meet { shell "sudo systemsetup -settimezone Australia/Perth" }
end

dep 'osx computer name set', :computer_name, :local_hostname, :for => :osx do
  # Set computer name (as done via System Preferences -> Sharing)
  computer_name.ask("OS X Computer Name").default(shell('scutil --get ComputerName'))
  local_hostname.ask("OS X Local Hostname").default(computer_name.to_s.downcase.gsub(' ', '-'))

  met? {
    shell("scutil --get ComputerName") == computer_name &&
    shell("scutil --get HostName") == computer_name &&
    shell("scutil --get LocalHostName") == local_hostname &&
    shell("defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName") == local_hostname
  }
  meet {
    sudo "scutil --set ComputerName '#{computer_name}'"
    sudo "scutil --set HostName '#{computer_name}'"
    sudo "scutil --set LocalHostName '#{local_hostname}'"
    sudo "defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string '#{local_hostname}'"
  }
end

### NEW SETTINGS ###

# TODO More from https://github.com/sporkd/babushka-deps/blob/master/osx_prefs.rb
# TODO More from https://github.com/ptb/Mac-OS-X-Lion-Setup/blob/master/setup.sh
# TODO https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# defaults -currentHost read com.apple.screensaver
# {
#     CleanExit = YES;
#     PrefsVersion = 100;
#     mainScreenOnly = 0;
#     moduleDict =     {
#         moduleName = Arabesque;
#         path = "/System/Library/Screen Savers/Arabesque.qtz";
#         type = 1;
#     };
#     moduleName = Fliqlo;
#     modulePath = "/Users/rgrasso/Library/Screen Savers/Fliqlo.saver";
# }
