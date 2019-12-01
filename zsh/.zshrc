#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#
# Path
alias brew="env PATH=${PATH/${HOME}\/\.anyenv\/envs\/pyenv\/shims:/} brew"
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export PATH="/usr/local/git/bin:$PATH"

export GOPATH="$HOME/Works/go"
export PATH="$GOPATH/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# export JAVA_HOME=`/usr/libexec/java_home -v 11.0.1`
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=${JAVA_HOME}/bin:${PATH}

export PATH="$PATH:$HOME/Works/flutter/core/bin"
