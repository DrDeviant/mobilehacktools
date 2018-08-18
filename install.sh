#!/bin/sh


#check whether on 10.13
MOREF=`sw_vers | grep Prod`
if [[ $MOREF = *"Mac OS X"* ]]; then
  echo "Detected Mac OS X"
else
  echo "Please use Mac OS X"
  exit
fi

if [[ $MOREF = *"10.13"* ]] || [[$MOREF = *"10.14"* ]]; then
  echo "Detected compatible os x"
else
  echo "You need to use MAC OS X 10.13 or higher"
  exit
fi
#install brew to install ansible

which brew
if [ $? -eq 0 ]; then
    echo "proceeding: brew installed"
else
    echo "Installing brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

fi
echo "Installing Ansible"
brew list ansible|| brew install ansible || brew link --overwrite ansible

echo "installing necessary roles"
ansible-galaxy install -r requirements.yml
# ansible-galaxy install geerlingguy.dotfiles

echo "running toolchain for generic items"
ansible-playbook -K ./generic/generic_items.yml

echo "run iOS toolchain book"
ansible-playbook -K ./iOS/generic_items.yml

echo "run Android toolchain book"
ansible-playbook -K ./Android/generic_items.yml
