####### Default #########
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

####### Custom #########

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    
    # colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# A bell command to signal the end of a long running command
alias bell="printf '\aBELL!\n'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Kill a process that is taking up a port
# Run like killport 8080
alias killport='sudo kill -9 `sudo lsof -t -i:$1`'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Run this function to set the Terminal's title
function title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Run this to reset some VirtualBox things
function vbox_recover(){
  killall VBoxClient
  VBoxClient-all
}

function extract () { 
  if [ -f $1 ] ; then 
      case $1 in 
          *.tar.bz2)   tar xvjf $1    ;; 
          *.tar.gz)    tar xvzf $1    ;; 
          *.bz2)       bunzip2 $1     ;; 
          *.rar)       rar x $1       ;; 
          *.gz)        gunzip $1      ;; 
          *.tar)       tar xvf $1     ;; 
          *.tbz2)      tar xvjf $1    ;; 
          *.tgz)       tar xvzf $1    ;; 
          *.zip)       unzip $1       ;; 
          *.Z)         uncompress $1  ;; 
          *.7z)        7z x $1        ;; 
          *)           echo "don't know how to extract '$1'..." ;; 
      esac 
  else 
      echo "'$1' is not a valid file!" 
  fi 
} 

# export http_proxy=http://proxy-chain.???.com:911
# export https_proxy=http://proxy-chain.???.com:912
# export socks_proxy=http://proxy-chain.???.com:1080
# export ftp_proxy=http://proxy-chain.???.com:911

# # Alias to be case insensitive
# export SOCKS_PROXY=$socks_proxy
# export HTTP_PROXY=$http_proxy
# export HTTPS_PROXY=$https_proxy
# export FTP_PROXY=$ftp_proxy

# Define some console colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA_ESC="\[$(tput setaf 5)\]"
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)
BYELLOW='\[\033[01;33m\]'
IBLACK='\[\033[0;90m\]'
PS_CLEAR='\[\033[0m\]'

# get current branch in git repo
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] & echo "$RETVAL"
}

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

PROMPT_COMMAND="timer_stop"

export PS1='[exit:\[\e[31m\]$(nonzero_return)\e[m\]][time: ${timer_show}s]\u@\h:\w:\[\e[36m\]$(parse_git_branch)\[\e[m\]\\$ '


# Seperate file for work-specific variables
source ~/.workrc | echo "No Work Configuration Found"
