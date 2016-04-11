dep "host", :hostname  do
  requires "osx computer name set".with(computer_name: hostname, local_hostname: hostname),
           "all-settings",
           "all-fonts",
           "all-apps",
           "dev-env"
end
