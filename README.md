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
- Log into Chrome and set as default browser
- TotalFinder
    - Add ~/Dropbox/Notes and ~/code into Finder sidebar
    - New window opens in ~/Downloads
    - Hide icon in menu bar
    - Folders on top
    - Search the current folder
- Command drag time machine icon off menu bar
- Settings
    - Users and groups > Change profile picture
    - Internet Accounts > Add them all
    - Accessibility > Reduce transparency
    - Keyboard > Set caps lock as control
    - Keyboard > Shortcuts > Change spotlight to `ctrl-option-cmd-space`
    - Keyboard > Shortcuts > Switch off show finder search window
    - Keyboard > Shortcuts > Disable all Mission Control key shortcuts
    - Desktop and ScreenSaver > Add Dropbox/Pictures/Wallpapers folder and
      change every day
    - Desktop and ScreenSaver > Arabesque screensaver
    - Security > Accessibility add apps
        - Dash
        - Fantastical
        - Moom
        - TextExpander
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
- Moom
    - Install Licence file from 1Password
    - Enable Move & Zoom grid with 8 x 6
    - Run as faceless app
    - Set up ![shortcuts](https://raw.githubusercontent.com/grassdog/osx/master/images/moom-settings.png)
- TextExpander
    - Setup Dropbox sync
    - Hide icon in Dock
    - Launch at login
    - Don't show main window at launch
- Install .secrets from 1Password
- Install SSH Keys and config

TODO Load Hazel Rules

TODO Write down steps to configure apps where non-trivial.

## 6. Other manual installs

- Lightroom
- Photoshop

