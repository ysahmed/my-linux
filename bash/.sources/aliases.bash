
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

flacit() {
    for file in *.wav; do
        ffmpeg -i "$file" -map 0:a -map 0:v? -c:a flac -c:v copy -id3v2_version 3 "${file%.wav}.flac"
    done
}

flacrename() {
    local count=0

    # Check if there are any flac files in the current folder
    if ! ls *.flac >/dev/null 2>&1; then
        echo "No .flac files found in the current directory."
        return 1
    fi

    for file in *.flac; do
        # Only process actual files
        [ -f "$file" ] || continue

        # Extract tags and strip "TAG=" prefix
        local artist=$(metaflac --show-tag=ARTIST "$file" | cut -d= -f2-)
        local title=$(metaflac --show-tag=TITLE "$file" | cut -d= -f2-)

        # Only proceed if both tags exist
        if [ -n "$artist" ] && [ -n "$title" ]; then
            # Safety: Replace any forward slashes (/) with dashes (-) so Linux doesn't think it's a directory
            artist="${artist//\//-}"
            title="${title//\//-}"

            local new_name="${artist} - ${title}.flac"

            # Avoid renaming a file to its exact same name
            if [ "$file" != "$new_name" ]; then
                # -n prevents overwriting an existing file
                mv -n "$file" "$new_name"
                echo "Renamed: '$file' -> '$new_name'"
                ((count++))
            fi
        else
            echo "Skipped '$file': Missing ARTIST or TITLE metadata tags."
        fi
    done

    echo "Done! Successfully renamed $count files."
}


flacrenamer() {
    local target_dir="${1:-.}"
    local count=0

    # Locate all .flac files recursively, handling spaces and special characters safely
    while IFS= read -r -d '' file; do
        # Extract tags and remove the 'ARTIST=' or 'TITLE=' header prefix
        local artist=$(metaflac --show-tag=ARTIST "$file" | cut -d= -f2-)
        local title=$(metaflac --show-tag=TITLE "$file" | cut -d= -f2-)

        if [ -n "$artist" ] && [ -n "$title" ]; then
            # Clean up illegal directory slashes (/) from the tags
            artist="${artist//\//-}"
            title="${title//\//-}"

            # Isolate the directory path and create the target filename
            local dirname=$(dirname "$file")
            local new_name="${dirname}/${artist} - ${title}.flac"

            if [ "$file" != "$new_name" ]; then
                # Rename file without overwriting existing files (-n)
                mv -n "$file" "$new_name"
                echo "Renamed: '$file' -> '$new_name'"
                ((count++))
            fi
        else
            echo "Skipped: '$file' (Missing ARTIST or TITLE metadata)"
        fi
    done < <(find "$target_dir" -type f -name "*.flac" -print0)

    echo "Done! Successfully processed and renamed $count files recursively."
}


if [ -x "$(which exa 2> /dev/null)" ]; then
    exa_bin='exa'
    replace_ls $exa_bin
elif [ -x "$(which eza 2> /dev/null)" ]; then
    exa_bin='eza'
    replace_ls $exa_bin
fi


# Rename flacs as "{arlist} - {title}.flac"
if [ -x "$(which exiftool 2> /dev/null)" ]; then
    alias atrename="exiftool '-filename<${artist} - ${title}.%e' *.flac"
    alias atrenamer="exiftool -r '-filename<${artist} - ${title}.%e' ."
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
alias ip='ip -color'


# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# avd
if [ -x .android 2> /dev/null ]; then
alias avd33="/home/waesh/Android/Sdk/emulator/emulator -avd pixel_8_33 -gpu host & disown"
alias avd35="/home/waesh/Android/Sdk/emulator/emulator -avd medium_35 -gpu host & disown"
fi

# python
alias pp='python3'
alias rmenv='rm -rf $(pipenv --venv)'
alias nvminit='source /usr/share/nvm/init-nvm.sh'
alias nsm='ssh nsm'
# alias yvpn-start='openvpn3 session-start --config ~/ovpn/profile-waesh.ovpn'
# alias yvpn-end='openvpn3 session-manage --disconnect --config ~/ovpn/profile-waesh.ovpn'

if [ -x .dev/flutter/bin/flutter 2> /dev/null ]; then
    export PATH="$HOME/.dev/flutter/bin:$PATH"
fi
