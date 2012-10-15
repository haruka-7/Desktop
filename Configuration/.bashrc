#----------------------------------------
# $HOME/.bashrc 
#----------------------------------------
# 09/08/2011
# version : 1.0
# licence : Creative Commons (CC-by-nc)
#
# written par Pedro CADETE - http://p3ter.fr
# fork from Nicolas Hennion - http://blog.nicolargo.com/
#
# tested with Ubuntu and Debian Squeeze

## --------------------
## Prompt configuration 
## --------------------
# Colors
NoColor="\033[0m"
Cyan="\033[0;36m"
Green="\033[0;32m"
Red="\033[0;31m" 
Yellow="\033[0;33m"

# Chars
RootPrompt="\#"
NonRootPrompt="\$"

# Contextual prompt
prompt() {

    USERNAME=`whoami`
    HOSTNAME=`hostname -s`
    
    # Change the Window title
    WINDOWTITLE="$USERNAME@$HOSTNAME"
    echo -ne "\033]0;$WINDOWTITLE\007"

    # Change the dynamic prompt
    LEFTPROMPT="\[$Cyan\]$USERNAME@$HOSTNAME":"\[$Yellow\]\w"
    GITSTATUS=$(git status 2> /dev/null)
    if [ $? -eq 0 ]; then
        echo $GITSTATUS | grep "not staged" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            LEFTPROMPT=$LEFTPROMPT"\[$Red\]"
        else
            LEFTPROMPT=$LEFTPROMPT"\[$Green\]"
        fi
        BRANCH=`git rev-parse --abbrev-ref HEAD`
        LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
    fi

    if [ $EUID -ne 0 ]; then
        PS1=$LEFTPROMPT"\[$NoColor\] "$NonRootPrompt" "
    else
        PS1=$LEFTPROMPT"\[$NoColor\] "$RootPrompt" "
    fi 
}

# Define PROMPT_COMMAND if not already defined (fix: Modifying title on SSH connections)
if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
    xterm*)
        PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
    screen)
        PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
    esac
fi
 
# Main prompt
PROMPT_COMMAND="prompt;$PROMPT_COMMAND"
 
if [ $EUID -ne 0 ]; then
    PS1=$NonRootPrompt" "
else
    PS1=$RootPrompt" "
fi



## -----------------------
## Coulors for ls and grep
## -----------------------

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## ----------------------
## Alias
## ----------------------

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias mkdir='mkdir -p'
alias df='df -h'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias wol fractal='wakeonlan 90:e6:ba:4f:7f:38'

## -------
## History
## -------

shopt -s histappend
shopt -s checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace
HISTTIMEFORMAT="%Y/%m/%d_%T : "

## --------------
## Colors for man
## --------------

PAGER=most
