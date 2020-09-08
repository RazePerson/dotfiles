#!/bin/bash

set -euxo pipefail

install_before_reboot() {

	echo "Updating and installing vim, the tools for it"
  sudo apt update -y
	sudo apt install zsh -y
  sudo apt install powerline fonts-powerline -y

	echo "Cloning Oh My Zsh repo"
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

	echo "Changing shell to zsh"
	chsh -s /bin/zsh
}

install_after_reboot() {

	echo "Cofiguring zshrc in home dir"
	default_source_zsh="source ~/dotfiles/.zshrc"
	echo $default_source_zsh > ~/.zshrc

	echo "Configuring vimrc in home dir"
	default_source_vim="source ~/dotfiles/tools/vim/.vimrc"
	echo $default_source_vim > ~/.vimrc

	echo "Installing curl and pulling autoload vim plugin"
	sudo apt update -y
	sudo apt install curl -y

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	echo "Opening vimrc"
	vim ~/dotfiles/tools/vim/.vimrc

	echo "Linking colors to vim"
  ln -s ~/dotfiles/tools/vim/colors ~/.vim/colors
}

# filename: reload_bash_shell.sh

# check if the reboot flag file exists.
# We created this file before rebooting.
if [ ! -f /var/run/resume-after-reboot ]; then
  echo "Running script for the first time.."

  # run your scripts here
	install_before_reboot

  # Preparation for reboot
  script="gnome-terminal -- ~/dotfiles/setup.sh"

  # add this script to zsh so it gets triggered immediately after reboot
  # change it to .bashrc if using bash shell
  echo "$script" >> ~/.zshrc

  # create a flag file to check if we are resuming from reboot.
  sudo touch /var/run/resume-after-reboot

  echo "rebooting.."
  # reboot here
	echo
	echo "You are about to reboot"
	echo
	while true; do
	    read -p "Do you wish to reboot" yn
	    case $yn in
	        [Yy]* ) sudo reboot; break;;
	        [Nn]* ) exit;;
	        * ) echo "Please answer yes or no.";;
	    esac
	done
else
  echo "resuming script after reboot.."

  # Remove the line that we added in zshrc
  sed -i '/bash/d' ~/.zshrc

  # remove the temporary file that we created to check for reboot
  sudo rm -f /var/run/resume-after-reboot

	install_after_reboot
  # continue with rest of the script
fi
