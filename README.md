# OS X Setup

A recipe for setting up a new OS X host how I like it. With liberal pilfering
from:

- https://github.com/quad/osx
- https://github.com/sporkd/babushka-deps
- https://github.com/ptb/Mac-OS-X-Lion-Setup
- https://github.com/bradfeehan/babushka-deps
- https://github.com/dgoodlad/babushka-deps

## Kick things off

Get a fresh OS X install, set up your user, and enable full disk encryption.

## 1. Go to the purchases tab of the Mac App Store and install the following:

- XCode

## 2. Bootstrap Babushka environment

```sh
bash <(curl -s https://raw.githubusercontent.com/grassdog/osx/master/bootstrap.sh)
```

## 3. Install deps for host

```sh
babushka osx:deus
```

Restart host to ensure all settings are in effect.

## 4. Install more apps from the Mac App Store

- 1Password
- Airmail
- Caffeine
- Color Picker
- Monosnap
- Xscope
- Dash
- Day One
- Folding Text
- Byword
- Scrivener
- Soulver
- Kindle
- Capo 3
- Lingo
- Slack
- Transmit
- White Noise
- Oyster
- Melo
- Valentina Studio
- Base
- Microsoft Remote Desktop

## 5. Manual Steps

- Open and set up Dropbox then pause syncing
    - Don't show desktop notifications
- Copy across Dropbox and Music files from backup and `chown -R` them to new user
- Resume Dropbox syncing
- Open and set up 1Password
- Log into Chrome and set as default browser
- Finder
    - Add ~/Dropbox/Notes and ~/code into Finder sidebar
    - New window opens in ~/Dropbox
    - View options on home folder and "show Library folder"
- Command drag time machine icon off menu bar
- Settings
    - Users and groups > Change profile picture
    - Internet Accounts
        - Add Google for mail and messages only
        - Add TW for calendar
        - Add Twitter account
    - Accessibility > Reduce transparency
    - Keyboard > Set caps lock as control
    - Keyboard > Shortcuts > Change spotlight to `ctrl-option-cmd-space`
    - Keyboard > Shortcuts > Switch off show finder search window
    - Keyboard > Shortcuts > Disable all Mission Control key shortcuts
    - Trackpad > Disable Two finger click
    - Trackpad > Disable Smart zoom and Rotate
    - Trackpad > Disable swipe between pages
    - Desktop and ScreenSaver > Add Dropbox/Pictures/Wallpapers folder and
      change every day
    - Desktop and ScreenSaver > Arabesque screensaver
    - Security > Accessibility add apps
        - Dash
        - Fantastical
        - Moom
        - TextExpander and TextExpanderHelper
- Place Airmail, Chrome, Omnifocus, Slack, Soulver, MacVim, Hollywood.inetloc, and iTerm into the Dock
- iTerm
    - Preferences > Set as default terminal
    - Sync preferences ~/Dropbox/Backups/iterm
- Alfred
    - Install Powerpack from 1Password
    - Set sync folder to ~/Dropbox/Backups/Alfred
    - General > Set shortcut to `cmd-space`
    - Enable 1Password
    - Enable Clipboard history
    - Disable contacts in Alfred
    - Appearance > Yosemite Light
    - Appearance > Hide Menu Bar Icon
- 1Password
    - Security > Don't lock when screensaver activated
- TextExpander
    - Setup Dropbox sync
    - Hide icon in Dock
    - Launch at login
    - Don't show main window at launch
- Fantastical
    - Disable alerts for boring events and calendars
    - Menu bar icon date and weekday
    - Defaults to last selected calendar and list
    - Change key shortcut to `shift-f12`
- Airmail
    - Add accounts
    - Disable interaction sounds
    - General > Dock only
    - Disable Notifications
    - For each account > Mapping > Remove custom folders
    - For each account > Clear out signature
- Flux
    - Set wake up time
- Airfoil
    - Only show in menu bar
    - Install extras for instant on
- DayOne
    - Setup dropbox sync
    - Baskerville 18pt, no auto bold, no twitter names
    - Disable reminders
    - Disable popover previews
    - Disable spelling corrections
- Calibre
    - Preferences > Install plugin from file > `~/Dropbox/Backups/Calibre DRM plugins/tools_v6.0.9/DeDRM_calibre_plugin/DeDRM_plugin.zip`
- Yojimbo
    - Link files `ln -s ~/Dropbox/Backups/Yojimbo ~/Library/Application\ Support/Yojimbo`
    - When handling links create web archives
- Install SSH Keys and config
    - Run Babushka tasks and install in Github and Forge

## 6. Other manual installs and file copies

- Copy across Emacs Daemon.app from Dropbox to /Applications
    - Add Daemon to startup items
- Aircard Watcher and SierraWireless Drivers
- Copy across or clone projects into `~/code/projects`
- Copy across from USB backup
    - ~/Pictures/Lightroom
    - ~/code/tools
    - ~/code/old
    - ~/code/scratch
    - ~/code/interesting
    - ~/Movies/Learning
    - ~/Movies/To Watch
- Lightroom
    - Copy across Lightroom catalog and masters from USB backup
    - Copy across Lightroom presets from backup into new location `~/Library/Application Support/Adobe/Lightroom/{Develop Preset,Export Presets,Filename Templates}`
- Photoshop
- MS Office
    - Customize install to not install cruft
- Copy across development VMs

