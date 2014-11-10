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
- Fantastical
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
- Slack
- Transmit
- White Noise
- Oyster
- Melo
- Valentina Studio
- Base
- Microsoft Remote Desktop

## 5. Manual Steps

- Copy across Dropbox and Music files from backup and `chown -R` them to new user
- Open and set up Dropbox and 1Password
    - Don't show desktop notifications
- Log into Chrome and set as default browser
    - Copy across from Homebrew cask so sandboxing works
- TotalFinder
    - Add ~/Dropbox/Notes and ~/code into Finder sidebar
    - New window opens in ~/Downloads
    - Hide icon in menu bar
    - Folders on top
    - Search the current folder
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
    - Trackpad > Disable Two finder click
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
- Moom
    - Install licence file from 1Password
    - Enable Move & Zoom grid with 8 x 6
    - Run as faceless app
    - Set up ![shortcuts](https://raw.githubusercontent.com/grassdog/osx/master/images/moom-settings.png)
- TextExpander
    - Setup Dropbox sync
    - Hide icon in Dock
    - Launch at login
    - Don't show main window at launch
- Fantastical
    - Disable alerts for boring events and calendars
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
- Calibre
    - Preferences > Install plugin from file > ~/Dropbox/Backups/Calibre DRM plugins
- Yojimbo
    - Link files `ln -s ~/Dropbox/Backups/Yojimbo  Library/Application\ Support/Yojimbo`
    - When handling links create web archives
- Install SSH Keys and config
    - Run Babushka tasks and install in Github and Forge

- Move any applications from /opt/Homebrew... to /Applications that bork when
symlinked.
    - Chrome
    - TextExpander
    - Sourcetree

## 6. Other manual installs and file copies

- Aircard Watcher and SierraWireless Drivers
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
- Photoshop
- MS Office
    - Customize install to not install cruft

