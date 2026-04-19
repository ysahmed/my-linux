
# fzf
if [ -x /usr/bin/fzf ]; then
	eval "$(fzf --bash)"
else
	echo "Install fzf"
fi

# others
source $HOME/.sources/git.bash

# pacman
if [ -x /usr/bin/pacman ]; then
	source $HOME/.sources/pacman.bash
fi

# dnf
if [ -x /usr/bin/dnf ]; then
	source $HOME/.sources/dnf.bash
fi

# overrides
source $HOME/.sources/overrides.bash

# aliases
source $HOME/.sources/aliases.bash

# key bindings
source $HOME/.sources/key_binding.bash

# Advanced command-not-found hook
if [[ -f /usr/share/doc/find-the-command/ftc.bash ]]; then
	source /usr/share/doc/find-the-command/ftc.bash
fi

# bash settings
export HISTCONTROL=ignoreboth:erasedups


if [ -x $HOME/.dev/flutter/bin/flutter ]; then
	export PATH="$HOME/.dev/flutter/bin:$PATH"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load starship prompt if starship is installed
strshp=$(which starship)
if [ -n "$strshp" ] && [ -x "$strshp" ]; then
	__main() {
		local major="${BASH_VERSINFO[0]}"
		local minor="${BASH_VERSINFO[1]}"

		if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
			source <("$strshp" init bash --print-full-init)
		else
			source /dev/stdin <<<"$("$strshp" init bash --print-full-init)"
		fi
	}
	__main
	unset -f __main
fi

# Enable bash completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion

export SAL_USE_VCLPLUGIN='gtk3'
# function main(){
#   source sources/git
#   cmd="$(grep '^function' "$0"|grep -v "function main"|awk '{print $2}'|cut -d\( -f1|fzf --prompt "Please Make a Selection")"
#   $cmd
#   exit 0
# }

# FVM
if [ -d $HOME/fvm/bin ]; then
	export PATH="$HOME/fvm/bin/:$PATH"
fi

if [ -d $HOME/fvm/default/bin ]; then
	export PATH="$HOME/fvm/default/bin/:$PATH"
	# chrome executable for flutter development
	if [ -x /usr/bin/chromium-browser ]; then
		export CHROME_EXECUTABLE="/usr/bin/chromium-browser"
	fi
fi

# android platform-tools
if [ -d $HOME/Android/Sdk/platform-tools ]; then
	export PATH="$HOME/Android/Sdk/platform-tools/:$PATH"
fi




