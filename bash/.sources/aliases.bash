
## Useful aliases

# Replace ls with exa
replace_ls() {
    local exa_bin=$1
    ls() { "$exa_bin" -al --color=always --group-directories-first --icons "$@"; }     # preferred listing
    la() { "$exa_bin" -a --color=always --group-directories-first --icons "$@"; }      # all files and dirs
    ll() { "$exa_bin" -l --color=always --group-directories-first --icons "$@"; }      # long format
    lt() { "$exa_bin" -aT --color=always --group-directories-first --icons "$@"; }     # tree listing
    l.() { exa -ald --color=always --group-directories-first --icons .* "$@"; } # show only dotfiles
    tree() { "$exa_bin" --tree "$@"; }
}

if [ -x "$(which exa)" ]; then
    exa_bin='exa'
    replace_ls $exa_bin
elif [ -x "$(which eza)" ]; then
    exa_bin='eza'
    replace_ls $exa_bin
fi

# Replace some more things with better alternatives
[ -x /usr/bin/bat ] && alias cat='bat --style header --style snip --style changes --style header'
[ -x /usr/bin/batman ] &&  alias man="batman"
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
[ -x /usr/bin/pacman ] && alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

[ -x /usr/bin/garuda-update ] && alias upd='/usr/bin/garuda-update'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

if [ -x /usr/bin/ugrep ]; then
    alias grep='ugrep --color=auto'
    alias fgrep='ugrep -F --color=auto'
    alias egrep='ugrep -E --color=auto'
fi

alias hw='hwinfo --short'                          # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias ip='ip -color'

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 50 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
# alias apt='man pacman'
# alias apt-get='man pacman'
# alias please='sudo'
# alias tb='nc termbin.com 9999'
# alias helpme='cht.sh --shell'
# alias pacdiff='sudo -H DIFFPROG=meld pacdiff'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# avd
if [ -x .android ]; then
alias avd33="/home/waesh/Android/Sdk/emulator/emulator -avd pixel_8_33 -gpu host & disown"
alias avd35="/home/waesh/Android/Sdk/emulator/emulator -avd medium_35 -gpu host & disown"
fi

# python
alias pp='python3'
alias rmenv='rm -rf $(pipenv --venv)'
alias nvminit='source /usr/share/nvm/init-nvm.sh'
alias nsm='ssh nsm'
alias yvpn-start='openvpn3 session-start --config ~/ovpn/profile-waesh.ovpn'
alias yvpn-end='openvpn3 session-manage --disconnect --config ~/ovpn/profile-waesh.ovpn'

if [ -x .dev/flutter/bin/flutter ]; then
export PATH="$HOME/.dev/flutter/bin:$PATH"
fi
