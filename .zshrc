# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
 export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hmeen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(virtualenv git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias testcode="cd ~/src/testcode && source ~/src/testvenv/bin/activate"
# Add the external toolchain for CE system-trunk-main to PATH:
if [ -d "/tandberg/system/bin" ]; then
    PATH="${PATH}:/tandberg/system/bin"
fi

 # Bash completion for CE system-trunk-main build script:
if [ -f "${SYSTEM_TRUNK_MAIN}/build/genmake/doc/bash_completion_build" ]; then
	. "${SYSTEM_TRUNK_MAIN}/build/genmake/doc/bash_completion_build"
fi

# Add utilities from CE dev-utils to PATH:
if [ -d "${HOME}/src/ce-dev-utils/bin" ]; then
	PATH="${PATH}:${HOME}/src/ce-dev-utils/bin"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/home/hmeen/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/hmeen/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/hmeen/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/hmeen/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hmeen/perl5"; export PERL_MM_OPT;

# setopt APPEND_HISTORY

up-line-or-beginning-local-search() {
  if [[ $LBUFFER == *$'\n'* ]]; then
    zle up-line-or-history
    __searching=''
  elif [[ -n $PREBUFFER ]] &&
      zstyle -t ':zle:up-line-or-beginning-search' edit-buffer
  then
    zle push-line-or-edit
  else
    [[ $LASTWIDGET = $__searching ]] && CURSOR=$__savecursor
    __savecursor=$CURSOR
    __searching=$WIDGET
    zle set-local-history 1
    zle history-beginning-search-backward
    zle set-local-history 0
    zstyle -T ':zle:up-line-or-beginning-search' leave-cursor &&
        zle end-of-line
  fi
}
zle -N up-line-or-beginning-local-search

down-line-or-beginning-local-search() {
  if [[ ${+NUMERIC} -eq 0 &&
      ( $LASTWIDGET = $__searching || $RBUFFER != *$'\n'* ) ]]
  then
    [[ $LASTWIDGET = $__searching ]] && CURSOR=$__savecursor
    __searching=$WIDGET
    __savecursor=$CURSOR

    zle set-local-history 1
    if zle history-beginning-search-forward; then
      zle set-local-history 0
      [[ $RBUFFER = *$'\n'* ]] ||
        zstyle -T ':zle:down-line-or-beginning-search' leave-cursor &&
        zle end-of-line
      return
    fi
    zle set-local-history 0

    [[ $RBUFFER = *$'\n'* ]] || return
  fi
  __searching=''
  zle down-line-or-history
}
zle -N down-line-or-beginning-local-search

# Stepping through local history.
bindkey "${key[Up]}" up-line-or-beginning-local-search       # Cursor Up
bindkey "${key[Down]}" down-line-or-beginning-local-search   # Cursor Down

# Stepping through global history.
bindkey "^[[1;5A" up-line-or-beginning-search                # Ctrl + Cursor Up
bindkey "^[[1;5B" down-line-or-beginning-search              # Ctrl + Cursor Down

# This option both imports new commands from the history file, and also causes your
# typed commands to be appended to the history file (the latter is like specifying
# INC_APPEND_HISTORY, which should be turned off if this option is in effect).
setopt sharehistory
