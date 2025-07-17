function fpac() {
    local selected_packages
    selected_packages=$(pacman -Sl |
        awk '{if ($4 == "[installed]") printf "\033[1;32m%s \033[1;33m  \033[0m\n", $2; else printf "\033[1;34m%s\033[0m\n", $2}' |
        fzf \
            --ansi \
            --reverse \
            --prompt=" " \
            --pointer=" " \
            --height 60% \
            --border sharp \
            -m \
            --preview='echo {} | cut -d" " -f1 | xargs pacman -Si | bat -p' |
        awk '{printf "%s ", $1}') || return

    if [[ -n $selected_packages ]]; then
        local command="sudo pacman -Sy $selected_packages"
        read -ei "$command" final_command
        eval "$final_command"
    fi
}

function restpac() {
    local package_list_file="${HOME}/my-linux/backup/pkglist.txt"

    if [[ -f "$package_list_file" ]]; then
        sudo pacman -Sy

        while IFS= read -r package; do
            yay -S --needed --noconfirm "$package" || printf "Warning: Could not install %s\n" "$package"
        done < "$package_list_file"
    else
        printf "%s does not exist.\n" "$package_list_file"
    fi
}

function bacpac(){
    mkdir -p ~/my-linux/backup
    pacman -Qeq > ~/my-linux/backup/pkglist.txt

}

# Update, install and search
alias psync='sudo pacman -S'
alias update='sudo pacman -Syyu --noconfirm'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rns'
alias rmcache='sudo pacman -R $(pacman -Qtdq)'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Miscs
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias rmpkg="sudo pacman -Rdd"
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 50 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Help people new to Arch
# alias apt='man pacman'
# alias apt-get='man pacman'
# alias please='sudo'
# alias tb='nc termbin.com 9999'
# alias helpme='cht.sh --shell'
# alias pacdiff='sudo -H DIFFPROG=meld pacdiff'