alias cat='bat'
# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
export EDITOR='nvim'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Edit this .bashrc file
alias ebrc='nvim ~/.bashrc'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias cls='clear'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

alias ls 'eza --icons=always --group-directories-first' # add colors and file type extensions
alias la 'ls -Alh --group-directories-first'            # show hidden files
alias lt 'ls --tree'
alias su="su - "

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

#####################################################
# Personal Changes
#######################################################

# vim motions in terminal
set -o vi

# rerun previous command
alias r='fc -s'
# jump to neovim config
alias c='cd ~/.config/nvim;nvim init.lua'
alias cs='cd ~/grade-12/cs/'
alias csa='cd ~/grade-12/csa/'
# wsl specific, open explorer in cwd
alias exp='/mnt/c/Windows/explorer.exe .'
alias n='cd ~/.nb/;nb'
alias ra='ranger'
# remove all Windows generated end line characters (^ M)
alias rmm='dos2unix -c mac'
# reload ssh-key
alias s='eval "$(ssh-agent -s)" ; ssh-add ~/.ssh/id_ed25519'
alias shutdown='powershell.exe wsl --shutdown'
alias so='source ~/.bashrc'
alias v='s;nvim'
alias l='ls -l --group-directories-first'
# wsl specific, open in windows system viewer (converted to vim binding)
# alias open='powershell.exe -Command Start-Process file'
alias ctheme='echo "$OMB_THEME_RANDOM_SELECTED"'
alias lg='lazygit'
alias nala='sudo nala'
alias wopen='wsl-open'
alias q='exit'
alias pow='./mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe'

#Autojump

if [ -f "/usr/share/autojump/autojump.sh" ]; then
	. /usr/share/autojump/autojump.sh
elif [ -f "/usr/share/autojump/autojump.bash" ]; then
	. /usr/share/autojump/autojump.bash
else
	echo "can't found the autojump script"
fi

# for some reasons these don't work correctly
# export PATH=$PATH:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
export PATH=$PATH:/mnt/c/Windows/System32/WindowsPowerShell/v1.0
export PATH=$PATH:/mnt/c/Windows/explorer.exe
export EDITOR="/bin/nvim"
export PATH=$PATH:/mnt/c/WINDOWS/system32
