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
