function fpac() {
    local package=$(pacman -Sl |
    awk '{if ($4 == "[installed]") printf "\033[1;32m%s \033[1;33m \033[0m\n", $2; else printf "\033[1;34m%s\033[0m\n", $2}' |
    fzf \
    --ansi \
    --reverse \
    --prompt=" " \
    --pointer="" \
    --height 60% \
    --border sharp \
    -m \
    --preview='echo {} | cut -d" " -f1 | xargs pacman -Si | bat -p' |
    awk '{printf "%s ", $1}') ||
    return

    if [[ -n $package ]]; then
        # Use tr to convert newlines to spaces
        local command="sudo pacman -Sy $(echo "$package")"
        read -ei "$command" final_command
        eval "$final_command"
    fi
}



# Update, install and search
alias psync='sudo pacman -Sy'
alias update='sudo pacman -Syyu --noconfirm'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rns'
alias rmcache='sudo pacman -R $(pacman -Qtdq)'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
