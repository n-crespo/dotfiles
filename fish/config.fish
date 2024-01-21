if status is-interactive
    # Commands to run in interactive sessions can go here
end

begin
    set --local AUTOJUMP_PATH $HOME/.autojump/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

# source ~/.bash_aliases

# set correct editor
set -Ux EDITOR nvim
set -gx EDITOR nvim

set -Ux FZF_DEFAULT_OPTS "--height 100% --no-preview "

# fix vscode
set -x DISPLAY :0
set -x RANGER_DEVICONS_SEPARATOR " "

# add cmd.exe to path
set -x PATH $PATH /mnt/c/WINDOWS/system32

# #2bbac5
set pure_color_primary 34e2e2
# #8ae234
set pure_color_success 8ae234
# #4e9a06
set pure_color_info 4e9a06
# #4e9a06
set pure_color_mute 4e9a06


set pure_enable_single_line_prompt true
set pure_begin_prompt_with_current_directory true
set pure_separate_prompt_on_error false
set pure_show_prefix_root_prompt true
set pure_threshold_command_duration 5
set pure_symbol_prompt '→'
set pure_symbol_git_unpulled_commits '↓'
set pure_symbol_git_unpushed_commits '↑'
set pure_symbol_git_stash ' '
set pure_symbol_reverse_prompt '→'
set pure_reverse_prompt_symbol_in_vimode true
set pure_check_for_new_release false
set pure_show_subsecond_command_duration false


function s
    # pkill ssh
    eval (ssh-agent -c)
    ssh-add ~/.ssh/usernicolas
end

function mdtodocx
    pandoc -o output.docx -f markdown -t docx $argv[1].md
end

function nn
    nb $argv[1]:
    cd ~/.nb/$argv[1]
end

function rcpp
    g++ -o $argv[1] $argv[1].cpp; and ./$argv[1]
end

function rjava
    javac $argv[1].java; and java $argv[1]
end

# alias lg 'pkill ssh;s;lazygit'
# this could be dangerous, but there is no need for more than one ssh process at
# a time
function lg
    pkill ssh
    s
    lazygit
end

function g:
    git add .
    git commit -m "$argv"
    git push
end

alias gs 'git status'
alias so 'omf reload'

abbr cat bat
alias ebrc 'nvim ~/.bashrc'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'trash -v'
alias mkdir 'mkdir -p'
alias psa 'ps auxf'
alias ping 'ping -c 10'
abbr cls clear
alias home 'cd '
alias .. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# maintaining dotfiles
alias dots 'echo "bash, zsh, fish, pwsh, wezterm"'
alias dotbash 'nvim -d /root/.bashrc ~/dot-files/bash/.bashrc'
alias dotfish 'nvim -d ~/.config/fish/config.fish ~/dot-files/fish/config.fish'
alias dotzsh 'nvim -d /root/.zshrc ~/dot-files/zsh/.zshrc'
alias dotpwsh 'nvim -d /mnt/c/Users/nicol/'
alias dotwez 'nvim -d /mnt/c/Users/nicol/.wezterm.lua ~/dot-files/wezterm/.wezterm.lua'

# Alias's for multiple directory listing commands
# alias ls 'ls -aFh --color always' # add colors and file type extensions
alias ls 'eza --icons=always --group-directories-first' # add colors and file type extensions
alias la 'ls -Alh --group-directories-first' # show hidden files
alias lt 'ls --tree'

alias lx 'ls -lXBh' # sort by extension
alias lk 'ls -lSrh' # sort by size
alias lf 'ls -f' # show only files
alias lc 'ls -lcrh' # sort by change time
alias lu 'ls -lurh' # sort by access time
alias lr 'ls -lRh' # recursive ls
# alias lt 'ls -ltrh'               # sort by date
alias lm 'ls -alh |more' # pipe through 'more'
alias lw 'ls -xAh' # wide listing format
alias ll 'ls -l' # long listing format
alias labc 'ls -lap' #alphabetical sort
# alias lf "ls -l | egrep -v '^d'" # files only
alias ldir "ls -l | egrep '^d'" # directories only

# Search running processes
alias p "ps aux | grep "
alias topcpu "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f "find . | grep "

# To see if a command is aliased, a file, or a built-in command
alias checkcommand "type -t"

# Alias's to show disk space and space used in a folder
alias diskspace "du -S | sort -n -r |more"
alias tree 'ls -T'
alias treed 'tree -CAFd'

# Alias's for archives
alias mktar 'tar -cvf'
alias mkbz2 'tar -cvjf'
alias mkgz 'tar -cvzf'
alias untar 'tar -xvf'
alias unbz2 'tar -xvjf'
alias ungz 'tar -xvzf'

# rerun previous command
# alias r 'fc -s'

# jump to neovim config
alias c 'cd ~/.config/nvim;nvim init.lua'
alias cs 'cd ~/grade-12/cs/'
alias csa 'cd ~/grade-12/csa/'
# wsl specific, open explorer in cwd
alias exp 'wopen .'
abbr ra ranger
abbr n nvim
# remove all Windows generated end line characters (^ M)
# alias rmm 'dos2unix -c mac'
# reload ssh-key
# alias s 'eval "$(ssh-agent -s)" ; ssh-add ~/.ssh/usernicolas'
alias shutdown '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c wsl --shutdown'
alias l 'ls -l --group-directories-first'
alias ctheme 'echo "$OMB_THEME_RANDOM_SELECTED"'
alias nala 'sudo nala'
alias wopen wsl-open
abbr img 'wezterm imgcat'
alias su 'su -'
abbr n. 'nvim .'

abbr v vim
abbr g git
abbr q exit
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
abbr sl ls
abbr dc cd

# set -Ux LD_LIBRARY_PATH /usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/server $LD_LIBRARY_PATH
set -Ux LD_LIBRARY_PATH /usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/server $LD_LIBRARY_PATH
set -U fish_user_paths /home/nicolas/.cargo/bin $fish_user_paths

set temp_value (ps -o ppid= -p $fish_pid)
set temp_value (string trim $temp_value)
set temp_value (ps -o comm -p $temp_value | tail -n +2 | grep -v '^$')
# echo $temp_value

if test "$temp_value" = su
    s >/dev/null 2>&1
    echo "ssh-key added!"
end
