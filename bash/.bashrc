
# fzf
eval "$(fzf --bash)"

# others
source ~/.sources/git.bash
source ~/.sources/pacman.bash

# overrides
source ~/.sources/overrides.bash

# aliases
source ~/.sources/aliases.bash

# key bindings
source ~/.sources/key_binding.bash

# Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.bash


if [ -x $HOME/.dev/flutter/bin/flutter ]; then
	export PATH="$HOME/.dev/flutter/bin:$PATH"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load starship prompt if starship is installed
if [ -x /usr/bin/starship ]; then
	__main() {
		local major="${BASH_VERSINFO[0]}"
		local minor="${BASH_VERSINFO[1]}"

		if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
			source <("/usr/bin/starship" init bash --print-full-init)
		else
			source /dev/stdin <<<"$("/usr/bin/starship" init bash --print-full-init)"
		fi
	}
	__main
	unset -f __main
fi


# function main(){
#   source sources/git
#   cmd="$(grep '^function' "$0"|grep -v "function main"|awk '{print $2}'|cut -d\( -f1|fzf --prompt "Please Make a Selection")"
#   $cmd
#   exit 0
# }

