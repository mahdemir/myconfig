# System check
if [[ $(uname) == "Linux" ]]; then
	VSCODE_PATH="$HOME/.config/Code/User"
	alias perm='stat --format "%a"'
	alias permf='stat --format "%A"'
else
	VSCODE_PATH="$HOME/Library/Application Support/Code/User"
	alias perm='stat -f "%A"'
	alias permf='stat -f "%Sp"'
fi

# Exports
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export GIT_CONFIG_GLOBAL=$HOME/.myconfig/.gitconfig

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

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
HIST_STAMPS="%d/%m %H:%M"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
	git
	web-search
	history
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Improve zsh history
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands

# Set personal aliases, overriding those provided by oh-my-zsh.
# For a full list of active aliases, run `alias`.
alias zshconfig='code $HOME/.myconfig/.zshrc'
alias ohmyzsh='code $HOME/.oh-my-zsh'
alias c='clear'
alias l='ls -lFh'
alias la='ls -lAFh'
alias lr='ls -tRFh'
alias lh='ls -ld .*'
alias ll='ls -1Fcrt'
alias lla='ls -1Fcart'
alias m='make'
alias mr='make re'
alias mc='make clean'
alias mf='make fclean'

alias confirm_removal="read -q 'REPLY?Remove these files? (y/n) '; [[ \$REPLY = [Yy] ]]"

function editconfig() {
	code $HOME/.myconfig
}

function pullconfig() {
	cd $HOME/.myconfig || return 1
	git pull
	if ! diff -q settings.json $VSCODE_PATH/settings.json > /dev/null 2>&1; then
		if [[ $? -eq 2 ]]; then
			echo "Error: diff command failed."
			return 1
		fi
		cp -f settings.json $VSCODE_PATH/settings.json || return 1
	fi
}

function pushconfig() {
	cd $HOME/.myconfig || return 1
	if ! diff -q $VSCODE_PATH/settings.json settings.json > /dev/null 2>&1; then
		if [[ $? -eq 2 ]]; then
			echo "Error: diff command failed."
			return 1
		fi
		cp -f $VSCODE_PATH/settings.json . || return 1
	fi
	if [[ -n "$1" ]]; then
		git add .; git commit -m "$1"; git push;
	else
		git add .; git commit -m "Update configuration"; git push;
	fi
}

function gitpush() {
	if [[ -n "$1" ]]; then
		git add .; git commit -m "$1"; git push;
	else
		git add .; git commit -m "automated push"; git push;
	fi
}

# fzf required
function fh() {
	if [ -z "$*" ]; then
		eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
	else
		history 1 | egrep --color=auto "$@"
	fi
}

rmall() {
	local appname=$1

	if [[ ! -n "$1" ]]; then
		echo "Usage: <file/application name to remove>"
	elif [[ -n $(mdfind -name "$appname" 2>&1 | grep -v "Loading keywords and predicates") ]]; then
		echo "Found the following files related to $appname:"
		printf '%s\n' "$(mdfind -name "$appname" 2>&1 | grep -v "Loading keywords and predicates" | sed 's/ /\\ /g')"
		if confirm_removal; then
			echo "\n"
			mdfind -name "$appname" 2>&1 | grep -v "Loading keywords and predicates" | sed 's/ /\\ /g' | xargs -I {} sudo rm -rf "{}"
		else
			echo "\nRemoving $appname canceled"
		fi
	else
		echo "No files found related to $appname."
	fi
}

rmapp() {
	rmall "$@"
}

# Personal device only
if [[ $(hostname) == "MacBook-Pro-van-Mahmut.local" ]]; then

	check_window() {
	toCompare=$(osascript -e 'tell application "iTerm2" to count of windows')
    if [ $1 -eq toCompare ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

	# Split terminal vertically on startup
	WINDOW_COUNT=$(osascript -e 'tell application "iTerm2" to count of windows')
	
	for ((i = 1; i <= $WINDOW_COUNT; i++)); do
		if [ $WINDOW_COUNT -eq $i ]; then
			if [ ! -f /tmp/window_flag_${i} ]; then
				osascript << EOF
					tell application "iTerm2"
						tell current session of current window
							split vertically with same profile
						end tell
					end tell
EOF
			fi
			touch /tmp/window_flag_${i}
		fi
		j=$i
	done
	trap '$HOME/Library/Services/Scripts/check_iterm_window.sh $j' EXIT

	# Ruby version manager init, rbenv
	eval "$(rbenv init - zsh)"

	# pyenv version manager
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"

	alias py='python3'
	alias pip='pip3'
	alias 42='cd $HOME/Desktop/42cursus'
	alias goshared='cd $HOME/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map'

	function tolinux() {
		if [[ ! -n "$1" ]]; then
			cp -rf $PWD $HOME/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map/
		else
			cp -rf "$1" $HOME/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map/
		fi
	}
fi

# VM-Linux (Testing)
if [[ $(hostname) == "VM-Linux" ]]; then
	alias goshared='cd /media/sf_Gedeelde_Map/'
	cd /media/sf_Gedeelde_Map/
fi
