# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="suvash"

# Loading aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# Load pyenv automatically
# export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Get virtualenvwrapper to create virtual environments using pyenv
# See: https://github.com/pyenv/pyenv-virtualenvwrapper#using-pyvenv-instead-of-virtualenv
export PATH=$PATH:$HOME/.local/bin
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export VIRTUALENVWRAPPER_PYTHON=$(which python3)

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker git jsontools last-working-dir sudo rvm virtualenv virtualenvwrapper kubectl)

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export PATH=$PATH:$HOME/bin

if [[ -d "/usr/lib/jvm/java-1.8.0-openjdk-amd64" ]]; then
  export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
fi
export GIT_SSL_NO_VERIFY=1
export TERM=xterm

# Basic load of oh-my-zsh configuration
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'    # remote session editor
else
  export EDITOR='vim'   # local session editor
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Loading docker env vars
if [ -f ~/.docker/docker.env ]; then
  . ~/.docker/docker.env 
fi

# Setting sockets directory for screen
export SCREENDIR=$HOME/.screen

# NVM (Node Version Manager) settings [see https://github.com/nvm-sh/nvm]
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

cd ~

# Loading RVM
source $HOME/.rvm/scripts/rvm

# Loading Go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$(go env GOPATH)/bin
