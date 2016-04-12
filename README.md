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
babushka osx:host hostname=fred
```

Restart host to ensure all settings are in effect.

## 4. Install more apps from the Mac App Store

- 1Password
- Zen Timer
- Ulysses
- Dash 3
    - Set up synching to `~/Dropbox/Backups/Dash`
- Day One
- White Noise

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
    - Keyboard > Shortcuts > Spotlight > Change spotlight to `ctrl-option-cmd-space`
    - Keyboard > Shortcuts > Spotlight > Switch off show finder search window
    - Keyboard > Shortcuts > Mission Control > Disable all Mission Control key shortcuts
    - Trackpad > Disable Two finger click
    - Trackpad > Disable Smart zoom and Rotate
    - Trackpad > Disable swipe between pages
    - Desktop and ScreenSaver > Add Dropbox/Pictures/Wallpapers folder and change every hour
    - Desktop and ScreenSaver > Arabesque screensaver
    - Security > Accessibility add apps
        - Dash
        - Fantastical 2
        - Moom
- Place Chrome, Omnifocus, Slack, Soulver, MacVim, Hollywood.inetloc, and iTerm into the Dock
- iTerm
    - Preferences > Set as default terminal
    - Sync preferences ~/Dropbox/Backups/iterm
- 1Password
    - Security > Don't lock when screensaver activated
    - Switch on third party integration under advanced settings
- Alfred
    - Install Powerpack from 1Password
    - Set sync folder to ~/Dropbox/Backups/Alfred
    - General > Set shortcut to `cmd-space`
    - Enable 1Password
    - Enable Clipboard history
    - Disable contacts in Alfred
    - Appearance > Yosemite Light
    - Appearance > Hide Menu Bar Icon
- Calendar.app
    - Disable notifications
- Fantastical 2
    - Menu bar icon date and weekday
    - Defaults to last selected calendar and list
    - Change key shortcut to `shift-f12`
    - General > Start week on Today or selected day
    - General > Start Month on current or selected week
- Flux
    - Set wake up time
- Airfoil
    - Only show in menu bar
    - Install extras for instant on
- DayOne
    - Setup sync
    - Baskerville 18pt, no auto bold, no twitter names
    - Disable reminders
    - Disable popover previews
    - Disable spelling corrections
- Install SSH Keys and config
    - Run Babushka tasks and install in Github and Forge
    - Alternatively install Deus keys

## 6. Personal Apps

Extra apps for more personal hosts.

```sh
$ babushka osx:personal-apps
```

- Caffeine
- Color Picker
- Monosnap
- Xscope
- Byword
- Kindle
- Capo 3
- Lingo
- Transmit
- Oyster
- Melo
- TextExpander
    - Setup Dropbox sync
    - Hide icon in Dock
    - Launch at login
    - Don't show main window at launch
- Calibre
    - Preferences > Install plugin from file > `~/Dropbox/Backups/Calibre DRM plugins/tools_v6.0.9/DeDRM_calibre_plugin/DeDRM_plugin.zip`
- Yojimbo
    - Link files `ln -s ~/Dropbox/Backups/Yojimbo ~/Library/Application\ Support/Yojimbo`
    - When handling links create web archives

## 7. Other manual installs and file copies

- [GPGTools](https://gpgtools.org/)
- Copy across or clone projects into `~/code/projects`
- Copy across from USB backup
    - ~/code/old
    - ~/code/scratch
- Lightroom
    - Copy across Lightroom catalog and masters from USB backup
    - Copy across Lightroom presets from backup into new location `~/Library/Application Support/Adobe/Lightroom/{Develop Preset,Export Presets,Filename Templates}`
- Photoshop
- MS Office
    - Customize install to not install cruft
- Copy across development VMs
