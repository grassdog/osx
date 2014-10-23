dep 'homebrew-cask' do
  requires 'homebrew'

  meet { shell 'brew install caskroom/cask/brew-cask' }
  met? { shell? 'brew cask' }
end

dep 'alfred cask integration' do
  requires 'alfred.cask'

  meet { shell 'brew cask alfred link' }
  met? { `brew cask alfred status`.include? 'is happily linked' }
end
