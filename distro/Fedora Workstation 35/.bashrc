#source /usr/share/defaults/etc/profile
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ================================================
# .bashrc for Fedora Workstation 35
# Credits: https://github.com/Manoj-Paramsetti
# ================================================


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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

if [ "$color_prompt" == yes ]; then
    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    cyan_color='\[\033[1;36m\]' # Colours may change in your system
    prompt_symbol=-✨-
    branch='`git branch --show-current 2> /dev/null`'
    nickname='Aditya Upadhye' # Change your name here
    Date="$(date +%d-%m-%Y' '%H:%M:%S)"

    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
	prompt_color='\[\033[;94m\]'
	info_color='\[\033[1;31m\]'
	prompt_symbol=-💫-
    fi
    function __shortpath {
        if [[ ${#1} -gt $2 ]]; then
            len=$2+3
            echo "..."${1: -$len}
        else
            echo $1
        fi
    }

    # PS1 lines
    LEFT_PART_FIRST_LINE="$prompt_color┌──${debian_chroot:+($debian_chroot)──}(\[\033[1;33m\]\u${prompt_symbol}\h$prompt_color)\[\033[0;1m\]"
    RIGHT_PART_FIRST_LINE="[$nickname] $cyan_color [: $branch]$info_color ($Date)"
    FIRST_LINE="$LEFT_PART_FIRST_LINE"
    SECOND_LINE="$prompt_color\033[1m|\033[0m \[\033[1;2m\]Location: $prompt_color [$(__shortpath "\w" 50)$prompt_color]"
    THIRD_LINE="$prompt_color└─$info_color\[\033[0m\]$ "

    PS1=$FIRST_LINE'\n'$SECOND_LINE'\n'$THIRD_LINE
    # BackTrack red prompt
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

# Settings for java
#alias java='java "$_SILENT_JAVA_OPTIONS"'
#_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS"
#unset _JAVA_OPTIONS

# alias for git
alias gadd='git add .'
alias gcommit='git commit -m'
alias gclone='git clone'
alias gremote='git remote add upstream'
alias grmremote='git remote remove upstream'
alias ginit='git init'

# alias for neofetch
alias nf='neofetch'

# alias for android studio
alias studio='/usr/local/android-studio/bin'e

# alias for flutter
alias flutter=~/Android/flutter/bin/flutter

# alias for python3
alias py='python3'
alias python='python3'

# alias for nano with 4 tab spaces
alias nano='nano -T 4'

# alias for mysql
alias sql="sudo mysql -u 'root'"

alias xclipboard='xclip -selection clipboard <'

# src is the place where I store all source code
alias src='cd ~/src'

# To push files with git using message
gitpush(){
  gadd && gcommit "$1" && git push
}


# It works for only debain based OS
debinstall() {
    sudo apt install $(pwd)/$1
}

# To update and upgrade Fedora using dnf
alias dnf='sudo dnf update && sudo dnf upgrade'

export PATH=$PATH":/home/aditya/.local/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/aditya/.sdkman"

[[ -s "/home/aditya/.sdkman/bin/sdkman-init.sh" ]] && source "/home/aditya/.sdkman/bin/sdkman-init.sh"