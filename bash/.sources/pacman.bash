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
            sudo -E yay -S --needed --noconfirm "$package" || printf "Warning: Could not install %s\n" "$package"
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
