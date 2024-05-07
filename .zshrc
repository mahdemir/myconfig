export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export GIT_CONFIG_GLOBAL=~/.myconfig/.gitconfig

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

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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
alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
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

function gitpush() {
	if [[ -n "$1" ]]; then
		git add . && git commit -m "$1"; git push;
	else
		git add . && git commit -m "automated push"; git push;
	fi
}

function pushconfig() {
    cd ~/.myconfig || return 1
    git add . && git commit -m "Update configuration"; git push;
}

# fzf cmd required
function fh() {
	if [ -z "$*" ]; then
        eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
	else
        history 1 | egrep --color=auto "$@"
    fi
}

# Personal device only
if [[ $(hostname) == "MacBook-Pro-van-Mahmut.local" ]]; then
	# Ruby version manager init, rbenv
	eval "$(rbenv init - zsh)"

	alias py='python3'
	alias pip='pip3'
	alias 42='cd ~/Desktop/42cursus'

	function tolinux() {
		if [[ ! -n "$1" ]]; then
			cp -rf $PWD ~/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map/
		else
			cp -rf "$1" ~/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map/
		fi
	}
fi
