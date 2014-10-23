#!/bin/bash

# https://github.com/sporkd/babushka-deps/blob/master/bootstrap.sh

echo
echo "During this installation, you will be prompted for your password a few times."
echo
echo "Waiting 5 seconds. Then going."
sleep 5

echo "We need to make sure you can write to some directories in /usr/local"
echo "We may need your user account password to invoke sudo to chgrp and chmod /usr/local to 'user:staff 775'"
echo "If prompted for your password, please enter it."
echo
sleep 2
echo "Checking to make sure you have a /usr/local directory"
if [ -d /usr/local ]
then
  echo "/usr/local exists. Awesome."
else
  sleep 1
  echo "Creating /usr/local."
  sudo mkdir -p /usr/local
  sudo chmod g+w /usr/local
  sudo chgrp staff /usr/local
fi

echo "Checking permissions in /usr/local/..."
# Make sure the current user can write to /usr/local/babushka
if [ -w /usr/local ]
then
  echo "/usr/local is writable. Awesome."
else
  sleep 1
  sudo chmod g+w /usr/local
  sudo chgrp staff /usr/local
fi

if [ -w /usr/local/bin ]
then
  echo "/usr/local/bin is writable. Also Awesome."
else
  sleep 1
  sudo chmod g+w /usr/local
  sudo chgrp staff /usr/local
fi

if [ -w /usr/local/babushka ]
then
  echo "/usr/local/babushka is writable."
elif [ -e /usr/local/babushka ]
then
  echo "/usr/local/babushka exists, but is not writable by you. Fixing that."
  sleep 1
  sudo chgrp staff /usr/local/babushka
  sudo chmod g+w /usr/local/babushka
else
  echo "/usr/local/babushka does not exist. That's OK. We'll create it later."
fi

sleep 2

if [ -w /usr/local/share/man ]
then
  echo "/usr/local/share/man is writable."
elif [ -e /usr/local/share/man ]
then
  echo "/usr/local/share/man exists, but is not writable by you. Fixing that."
  sleep 1
  sudo chgrp staff /usr/local/share/man
  sudo chmod g+w /usr/local/share/man
else
  echo "/usr/local/babushka does not exist. That's OK. We'll create it later."
fi

sleep 2

echo
echo "OK. Permissions are good to go. Next we need to accept the Xcode license."
echo

sudo xcodebuild -license

sleep 2

echo
echo "OK. Next we will install Babushka."
echo

sleep 2

bash -c "`curl babushka.me/up`"

echo
echo "Done. Babushka was installed sucessfully!"
echo

sleep 2

echo
echo "Adding OS X Source"
echo

babushka sources --add osx https://github.com/grassdog/osx.git

# TODO May be better to just run a specific dep here

echo
echo "Bootstrapping"
echo

babushka osx:bootstrap
