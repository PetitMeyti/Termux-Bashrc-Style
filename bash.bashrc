######################################
#
# Termux bash.bashrc
# by brainf+ck
#
# Last modified: 2022/06/30
#
######################################

#### Global ##########################

# Color
export GREP_COLOR="1;32"
export LS_COLORS="di=1;32:fi=1;32"
# Editor
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"

export MANPAGER="less -R --use-color -Dd+g -Du+b"

#History

#Don't overwrite it
shopt -s histappend

# load results of history substitution into the readline editing buffer
shopt -s histverify

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# cycle through all matches with 'TAB' key
bind 'TAB:menu-complete'

# necessary for programmable completion
shopt -s extglob

# cd when entering just a path
shopt -s autocd

clear

#Date
echo -e "                                \e[48;5;236m\e[38;5;82m Time: $(date '+%H:%M:%S') \e[0m"

##Checking Network##
echo -e "                                 Network Status"
if ping -c 1 -w 2 8.8.8.8 >/dev/null 2>&1; then
    echo -e "                                   \e[38;5;82mConnected\e[0m"
else
    echo -e "                                 \e[38;5;196m Disconnected\e[0m"
fi
#Custom Color \e[48;5;236m\e[38;5;82m

#last modified#
# Ambil waktu terakhir file bash.bashrc diubah
LAST_MODIFIED=$(stat -c %y /data/data/com.termux/files/usr/etc/bash.bashrc | cut -d '.' -f1)

# Tampilkan di terminal
echo -e "                       \e[48;5;236m\e[38;5;82m Last Modified: $LAST_MODIFIED \e[0m"
echo -e "\n"
#Prompt
PS1='   ∥ \[\e[48;5;236m\]\[\e[38;5;82m\]⟩\w/..⟨\[\e[0m\]\n\[\e[38;5;196m\]   ∥ \[\e[0m\] \[\e[38;5;225m\]└─\[\e[0m\] \[\e[38;5;196m\]s\[\e[38;5;51m\]u\[\e[38;5;214m\]p\[\e[38;5;226m\]e\[\e[38;5;82m\]r\[\e[38;5;51m\]u\[\e[38;5;129m\]s\[\e[38;5;39m\]e\[\e[38;5;226m\]r\[\e[0m\] \[\e[38;5;226m\]≫\[\e[0m\] '

# You Can Add The Custom Aliases
# Enable color support
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip -color'
fi

# Common
alias pkgup='pkg upgrade && pkg update'
alias clr='clear'
alias sdc='cd /sdcard/'
alias x='exit'
alias home='cd ~'
alias bashrc='/data/data/com.termux/files/usr/etc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lm='ls | more'
alias ll='ls -lFh'
alias la='ls -alFh --group-directories-first'
alias l1='ls -1F --group-directories-first'
alias l1m='ls -1F --group-directories-first | more'
alias lh='ls -ld .??*'
alias lsn='ls | cat -n'
alias mkdir='mkdir -p -v'
alias cp='cp --preserve=all'
alias cpv='cp --preserve=all -v'
alias cpr='cp --preserve=all -R'
alias cpp='rsync -ahW --info=progress2'
alias cs='printf "\033c"'
alias q='exit'

# CPU
alias df='df -Tha --total'
alias free='free -mt'
alias ps='ps auxf'
alias ht='htop'
alias cputemp='sensors | grep Core'

# Shortcuts
alias myip='curl -s -m 5 https://ipleak.net/json/'
alias e='nvim'
alias w3m='w3m https://google.com'

if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi

n()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNVL ] && [ "${NNNVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd" 
    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}