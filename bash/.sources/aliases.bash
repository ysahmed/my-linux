
## Useful aliases

# Replace ls with exa
replace_ls() {
    local exa_bin=$1
    alias ls='$exa_bin -al --color=always --group-directories-first --icons'
    alias la='$exa_bin -a --color=always --group-directories-first --icons'
    alias ll='$exa_bin -l --color=always --group-directories-first --icons'
    alias lt='$exa_bin -aT --color=always --group-directories-first --icons'
    alias l.='$exa_bin -ald --color=always --group-directories-first --icons .*'
    alias tree='$exa_bin --tree'
}

if [ -x "$(which exa 2>/dev/null)" ]; then
    exa_bin='exa'
    replace_ls $exa_bin
elif [ -x "$(which eza 2>/dev/null)" ]; then
    exa_bin='eza'
    replace_ls $exa_bin
fi

# Replace some more things with better alternatives
[ -x "$(which bat 2>/dev/null)" ] && alias cat='bat --style=numbers,changes,grid,header --color=always'
[ -x "$(which batman 2>/dev/null)" ] &&  alias man="batman"
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
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

if [ -x "$(which ugrep 2>/dev/null)" ]; then
    alias grep='ugrep --color=auto'
    alias fgrep='ugrep -F --color=auto'
    alias egrep='ugrep -E --color=auto'
fi

alias hw='hwinfo --short'                          # Hardware Info
alias ip='ip -color'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

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
