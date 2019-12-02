#!/usr/bin/env bash

set -ue

DOTFILES_DIR=$(dirname $(cd $(dirname $0); pwd))

if [ ! -d "$HOME/.dotbackup" ];then
  command echo "$HOME/.dotbackup not found. Auto Make it"
  command mkdir "$HOME/.dotbackup"
fi

# VSCode settings
VSCODE_SETTINGS_DIR=$HOME/Library/Application\ Support/Code/User
if [ -d $VSCODE_SETTINGS_DIR ];then
  command echo "Set vscode dotfiles."

  if [[ -L "$VSCODE_SETTINGS_DIR/settings.json" ]];then
    command rm -f "$VSCODE_SETTINGS_DIR/settings.json"
  fi
  if [[ -e "$VSCODE_SETTINGS_DIR/settings.json" ]];then
    command mv "$VSCODE_SETTINGS_DIR/settings.json" "$HOME/.dotbackup"
  fi
  
  command ln -snf "$DOTFILES_DIR/vscode/settings.json" $VSCODE_SETTINGS_DIR

  # install extentions
  command echo "Install vscode extentions."

  command cat "$DOTFILES_DIR/vscode/extensions" | while read line
  do
  command code --install-extension $line
  done

  command echo "Done\!"
fi

# Git settings
command echo "Set git dotfiles."

if [ ! -d "$DOTFILES_DIR/git" ];then
  command mkdir git
fi

if [ ! -f "$DOTFILES_DIR/git/.gitconfig" ];then
  command touch "$DOTFILES_DIR/git/.gitconfig"
fi

command ln -snf "$DOTFILES_DIR/git/.gitconfig" $HOME

command git config --global user.name "saccho"
command git config --global user.email "saccho956@yahoo.co.jp"
command git config --global core.editor "vim"

command echo "If you want to go get private repositories, you need to add the following settings."
command echo '$ git config --global url."https://<Personal_access_token>:x-oauth-basic@github.com/".insteadOf "https://github.com/"'

command echo "Done\!"

# Other settings
# Zsh
command echo "Set zsh dotfiles."

command git clone --recursive https://github.com/sorin-ionescu/prezto.git "$DOTFILES_DIR/zsh/.zprezto"

for f in $DOTFILES_DIR/zsh/.??*; do
  if [[ -L "$HOME/`basename $f`" ]];then
    command rm -f "$HOME/`basename $f`"
  fi
  if [[ -e "$HOME/`basename $f`" ]];then
    command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
  fi
  command ln -snf $f $HOME
done

command echo "Done\!"

# Vim
command echo "Set vim dotfiles."

for f in $DOTFILES_DIR/vim/.??*; do
  if [[ -L "$HOME/`basename $f`" ]];then
    command rm -f "$HOME/`basename $f`"
  fi
  if [[ -e "$HOME/`basename $f`" ]];then
    command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
  fi
  command ln -snf $f $HOME
done

command echo "Done\!"

echo -e "\e[34mInstall completed\U1F389 \e[m"
