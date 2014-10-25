# OS X Setup

A recipe for setting up a new OS X host how I like it.

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

- Enable apps in accessbility
- Symlink in ~/code
    - Install dotfiles and vim symlinks
- Set reduce transparency
- Disable trash and extension change warnings and view extensions in finder preferences
- Set up keyboard defaults, repeat rate, caps lock as control etc...
- Set desktop background to point to dropbox backgrounds folder
- Set default shell to zsh (in user menu)
- Don't play feedback when volume is changed
- Use github ssh key business for github
- Set up iTerm
    - Import Solarized theme
    - Set font to menlo 12pt bold and menlo 12pt
    - keys left option key acts as +esc
    - Disable confirm closing
- Disable contacts in Alfred
- Disable spaces keyboard shortcuts etc..
- Install Alfred extensions

- Copy large .vagrant boxes
- Install .secrets from 1Password
- Install SSH Keys


## TODO Steps to configure apps

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

## TODO
