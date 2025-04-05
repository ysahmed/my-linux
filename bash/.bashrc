
# fzf
if [ -x /usr/bin/fzf ]; then
	eval "$(fzf --bash)"
else
	echo "Install fzf"
fi

# others
source ~/.sources/git.bash

# pacman
if [ -x /usr/bin/pacman ]; then
	source ~/.sources/pacman.bash
fi

# dnf
if [ -x /usr/bin/dnf ]; then
	source ~/.sources/dnf.bash
fi

# overrides
source ~/.sources/overrides.bash

# aliases
source ~/.sources/aliases.bash

# key bindings
source ~/.sources/key_binding.bash

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


# function main(){
#   source sources/git
#   cmd="$(grep '^function' "$0"|grep -v "function main"|awk '{print $2}'|cut -d\( -f1|fzf --prompt "Please Make a Selection")"
#   $cmd
#   exit 0
# }
