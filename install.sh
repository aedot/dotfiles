#!/bin/zsh

echo "Setting up your Mac..."

# This installs homebrew itself, and also the command line tools in silent mode
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

## oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create a Sites directory
# This is an default directory for OS X user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Create a warp terminal directory
# This is an default directory for OS X user accounts but doesn't comes pre-installed
mkdir $HOME/.warp/themes

cp coolnight.yaml $HOME/.warp/themes/

# Set OS X preferences
# We will run this last because this will reload the shell
source .macos
