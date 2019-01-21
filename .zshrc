export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export LANGUAGE=en_IN.UTF-8
export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_MODE='awesome-patched'
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.bash_funcs
source $HOME/.bash_alias
source $HOME/.bash_profile

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -d "$HOME/.local/bin" ]; then
	    PATH="$HOME/.local/bin:$PATH"
    fi

# powerline
if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
	    source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi


POWERLEVEL9K_ANDROID_ICON=" "
POWERLEVEL9K_APPLE_ICON=" "
POWERLEVEL9K_AWS_EB_ICON=" 🌱 "
POWERLEVEL9K_AWS_ICON=" "
POWERLEVEL9K_BACKGROUND_JOBS_ICON="  "
POWERLEVEL9K_BATTERY_ICON=" 🔋"
POWERLEVEL9K_CARRIAGE_RETURN_ICON=" ↵"
POWERLEVEL9K_DISK_ICON="  "
POWERLEVEL9K_EXECUTION_TIME_ICON=" "
POWERLEVEL9K_FAIL_ICON=" ✘"
POWERLEVEL9K_FOLDER_ICON=" "
POWERLEVEL9K_FREEBSD_ICON=" 😈 "
POWERLEVEL9K_GO_ICON=" "
POWERLEVEL9K_HOME_ICON=" "
POWERLEVEL9K_HOME_SUB_ICON=" "
POWERLEVEL9K_KUBERNETES_ICON=" ⎈"
POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=" "
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_LINUX_ICON=" "
#POWERLEVEL9K_LOAD_ICON="  "
#POWERLEVEL9K_LOCK_ICON=" "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=" ↱"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" ↳ "
POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=" ├─"
POWERLEVEL9K_NETWORK_ICON=" "
POWERLEVEL9K_NODE_ICON=" ⬢"
POWERLEVEL9K_OK_ICON=" ✔"
POWERLEVEL9K_PUBLIC_IP_ICON=" "
POWERLEVEL9K_PYTHON_ICON=" "
POWERLEVEL9K_RAM_ICON=" "
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_ROOT_ICON=" #"
POWERLEVEL9K_RUBY_ICON="  "
POWERLEVEL9K_RUST_ICON=" "
POWERLEVEL9K_SERVER_ICON=" "
POWERLEVEL9K_SSH_ICON=" (ssh)"
POWERLEVEL9K_SUNOS_ICON="  "
POWERLEVEL9K_SWAP_ICON=" "
POWERLEVEL9K_SWIFT_ICON=" "
POWERLEVEL9K_SYMFONY_ICON=" SF"
POWERLEVEL9K_TEST_ICON=" "
POWERLEVEL9K_TODO_ICON=" ☑"
POWERLEVEL9K_VCS_BOOKMARK_ICON=" "
POWERLEVEL9K_VCS_BRANCH_ICON=""
POWERLEVEL9K_VCS_COMMIT_ICON="  "
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON="  "
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=" "
POWERLEVEL9K_VCS_GIT_GITLAB_ICON="  "
POWERLEVEL9K_VCS_GIT_ICON="  "
POWERLEVEL9K_VCS_HG_ICON="  "
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=" "
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=" "
POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=" →"
POWERLEVEL9K_VCS_STAGED_ICON=""
POWERLEVEL9K_VCS_STASH_ICON="  "
POWERLEVEL9K_VCS_SVN_ICON=" (svn) "
POWERLEVEL9K_VCS_TAG_ICON="  "
POWERLEVEL9K_VCS_UNSTAGED_ICON=""
POWERLEVEL9K_VCS_UNTRACKED_ICON=""
POWERLEVEL9K_VPN_ICON=" "
POWERLEVEL9K_WINDOWS_ICON=" "

#POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(icons_test)
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_USER_ICON=""
POWERLEVEL9K_ROOT_ICON="#"
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='006'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='196'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD="0"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(command_execution_time dir rbenv vcs dir_writable newline user)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

