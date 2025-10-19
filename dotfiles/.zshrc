# -- ZSH CONFIG
ZSH_DIR=~/.config/zsh

# HISTORY
# ZSH don't save history by default
HISTFILE="${ZSH_DIR}/.zsh_history"
setopt appendhistory
HISTSIZE=1000000
SAVEHIST=1000000

# Useful options
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# Disable beep
unsetopt BEEP

# Completions
autoload -Uz compinit
zstyle ':completion:*' menu select
_comp_options+=(globdots) # Include hidden files

# Ignore Case
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colors
autoload -U colors && colors

# Enable HOME, END and DELETE keys
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[3~" delete-char
# Enable Ctrl + Arrows
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Enable vi mode
# bindkey -v

# Enable Zoxide
eval "$(zoxide init --cmd cd zsh)"


# -- ALIAS
# Safe rm
rm() {
	# Check if the first argument is -rf, if so, remove it from the arguments
	# Just because of muscular memory of typing rm -rf when deleting folders
	if [[ "$1" == "-rf" ]]; then
		shift
	fi

	# Check if any argument is a wildcard or directory symbol
	for arg in "$@"; do
		if [[ "$arg" == "*" || "$arg" == "/" ]]; then
			echo "Ignoring wildcard or directory symbol: $arg"
			continue
		else
			# Use gio to move files to trash
			gio trash "$@"
		fi
	done
}

if [ -f /usr/bin/nautilus ]; then
	# alias explorer='nohup nautilus -w . > /dev/null 2>&1 &'
	alias explorer='thunar -w > /dev/null 2>&1 &'
else
	alias explorer='thunar -w > /dev/null 2>&1 &'
fi

# Wayland alias
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	alias copy-image='wl-copy <'
	alias virtualmonitor='swaymsg create_output && wl-mirror HEADLESS-1'
else
	alias copy-image='xclip -selection clipboard -t image/png -i'
fi

# Unsafe rm
alias urm='/bin/rm -i'

# Linux
alias grep='grep --color=auto'
alias ls='exa --icons -g' # "-g" so when using "-ll" the group will also be displayed
alias ll='exa --icons --group-directories-first -lg'

# Get largest files in directory
alias largest='du -ah "${1:-.}" | sort -rh | tail -n +2 | head -n 10 | awk '\''{printf "\033[1m%s\033[0m %s\n", $1, substr($0, index($0, $2))}'\'''
#              sget size      sort largest   ignore "."    10 first    bold size

# shorten
alias py='python3'
alias nvim='bob run nightly'
alias icat='kitten icat' # preview image

# Neofetch
alias neofetch='neofetch --source ~/.config/neofetch/arch_trans.txt --ascii_colors 14 9 15 --colors 5 4 13 9 7'
alias neowofetch='neofetch --source ~/.config/neofetch/arch_trans2.txt --ascii_colors 14 9 15 --colors 5 4 13 9 7'

# Full commands
# -Q = Query
# -d = Unrequired. Nothing else dependes on
# -t = Only packages pulled automatically
# -q = Output only the package names
alias removeorphans='sudo pacman -Rncs $(pacman -Qdtq)'
# -m = Foreign packages (AUR or manually installed)
alias removeorphansyay='sudo pacman -Rncs $(pacman -Qmdtq)'
# Explicitly installed packages and its size
alias pacbig='pacman -Qqei | awk "/^Name/{name=\$3}/^Installed Size/{printf \"\033[1m%s\033[0m\t\033[32m%s %s\033[0m\n\", name, \$4, \$5}" | column -t'
alias open-ports='sudo lsof -i -P -n | grep LISTEN'

# rclone
alias drive-mount='rclone mount --daemon --vfs-cache-mode full gdrive:/ ~/Drive'
alias drive-umount='umount ~/Drive'

# ffmpeg
mkv-to-mp4() {
	if [ ! "$1" ]; then
		echo "Incorrect usage: No input video provided"
		echo "Correct Usage: video-to-mp4 <mp4 video>"
		return 1
	fi

	ffmpeg -i "$1" "${1%.mkv}.mp4"
}

video-to-gif() {
	if [ ! "$1" ]; then
		echo "Incorrect usage: No input video provided"
		echo "Correct Usage: video-to-gif <input> [size]"
		return 1
	fi

	local WIDTH="320"
	if [ "$2" ]; then
		WIDTH="$2"
	fi


	ffmpeg -i "$1" -vf "fps=24,scale=$WIDTH:-1:flags=lanczos" "${1%.*}.gif"
}

video-to-mp3() {
	if [ ! "$1" ]; then
		echo "Incorrect usage: No input video provided"
		echo "Correct Usage: video-to-audio <input>"
		return 1
	fi

	ffmpeg -i "$1" -vn -ac 2 -f mp3 "${1%.*}.mp3"
	# -vn: no video
	# -ac: audio channel
	# -ar: audio sample rate
	# -ab: audio bitrate
	# -acodec copy: use same audio stream
}


# -- VCS
autoload -Uz vcs_info

# Enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Check for untracked files in directory
# From https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
		git status --porcelain | grep '??' &> /dev/null ; then
		# This will show the marker if there are any untracked files in repo.
		# If instead you want to show the marker only if there are untracked
		# files in $PWD, use:
		#[[ -n $(git ls-files --others --exclude-standard) ]] ; then
		hook_com[staged]+='!' # signify new files with a bang
	fi
}

zstyle ':vcs_info:*' check-for-changes true

STATUS="%m%u%c"
BRANCH="%b"
zstyle ':vcs_info:git:*' formats "%F{blue}(%f%F{red}${STATUS}%f %F{yellow}% %F{magenta}$BRANCH%f%F{blue})%f"

setopt PROMPT_SUBST



# -- PLUGINS
# zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
source "${ZSH_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^ ' autosuggest-accept # Ctrl + Space to accept suggestion

## PS1 ##
TIME='%*'
FULL_DIR='%~'
CMD_STATUS='%(?.%F{blue}⏺.%F{red}⏺)%f'
GIT='${vcs_info_msg_0_}'
NEWLINE=$'\n'

PROMPT="${CMD_STATUS} %F{magenta}(%f%F{blue}${TIME}%f%F{magenta})%f %F{magenta}${FULL_DIR}%f %F{blue}>%f "
RPROMPT="${GIT}%F{blue}"

pokemon-colorscripts -r

# -- WAYLAND
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	export XDG_SESSION_TYPE=wayland # redudant
	export XDG_CURRENT_DESKTOP=sway
	export XDG_SESSION_DESKTOP=sway
	export MOZ_ENABLE_WAYLAND=1
	export QT_QPA_PLATFORM=wayland
	export SDL_VIDEODRIVER=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1
	# export GTK_IM_MODULE=wayland
	export GTK_IM_MODULE=
	export QT_IM_MODULE=wayland
	export XMODIFIERS="@im=wayland"
	# For screen recorder to work
	export SWAYSOCK=$(ls /run/user/1000/sway-*)
fi

