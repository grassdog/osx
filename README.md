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
- 1Password

## 2. Bootstrap Babushka environment

```sh
bash <(curl -s https://raw.githubusercontent.com/grassdog/osx/master/bootstrap.sh)
```

## 3. Install deps for host

```sh
babushka osx:deus
```

## 4. Manual Steps

- Open and set up Dropbox and 1Password

- Enable apps in accessibility
- Set reduce transparency
- Set caps lock as control
- Add Notes and code into Finder sidebar
- Set desktop background to point to Dropbox wallpaper folder
- Don't play feedback when volume is changed
- Set up iTerm
    - Import Solarized theme
    - Set font to menlo 12pt bold and menlo 12pt
    - Keys left option key acts as +esc
    - Disable confirm closing
- Disable contacts in Alfred
- Disable spaces keyboard shortcuts
- Install Alfred extensions
- Install .secrets from 1Password
- Install SSH Keys
- Setup dock and login items
- Copy across Music files and change owner

TODO Write down steps to configure apps where non-trivial.

## 5. Install more apps from the Mac App Store

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

## 6. Other manual installs

- Lightroom
- Photoshop

