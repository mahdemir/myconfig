# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
plugins=(
    git
    web-search
    history
    zsh-autosuggestions
)

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

# Ruby version manager init, rbenv
eval "$(rbenv init - zsh)"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
alias c='clear'
alias l='ls -lFh'
alias la='ls -lAFh'
alias lr='ls -tRFh'
alias lh='ls -ld .*'
alias ll='ls -1Fcrt'
alias lla='ls -1Fcart'
alias 42='cd ~/Desktop/42cursus'
alias m='make'
alias mr='make re'
alias mc='make clean'
alias mf='make fclean'
alias py='python3'
alias pip='pip3'

gitpush() {
	if [[ -n "$1" ]]; then
		git add . && git commit -m "$1"; git push;
	else
		git add . && git commit -m "automated push" ; git push;
	fi
}

tolinux() {
	if [[ ! -n "$1" ]]; then
		cp -rf $PWD ~/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map/
	else
		cp -rf "$1" ~/VirtualBox\ VMs/Lubuntu\ 22.04.3/Gedeelde\ Map/
	fi
}

crecpp() {
    if [[ ! -n "$1" ]]; then
        echo "Usage: cpcpp <filename>"
    elif [[ -e "./$1.cpp" ]]; then
        echo "$1.cpp already exists"
    else
        cp ~/Templates/cpp.cpp "$1.cpp"
    fi
}

crehpp() {
    if [[ ! -n "$1" ]]; then
        echo "Usage: cphpp <filename>"
    elif [[ -e "./$1.hpp" ]]; then
        echo "$1.hpp already exists"
    else
        cp ~/Templates/hpp.hpp "$1.hpp"
    fi
}

cremake() {
    if [[ ! -e "./Makefile" ]]; then
        cp ~/Templates/Makefile_cpp Makefile
    else
        echo "Makefile already exists"
    fi
}
