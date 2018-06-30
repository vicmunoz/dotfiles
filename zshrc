# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="suvash"

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
plugins=(docker git jsontools last-working-dir sudo vagrant rvm)

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

# Loading aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

