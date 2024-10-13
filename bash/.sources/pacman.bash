function fpac() {
    local package=$(pacman -Sl | cut -d" " -f2 |
        fzf -m --ansi --reverse --preview='echo {} | xargs pacman -Si | bat --color=always') || return

    if [[ -n $package ]]; then
        # Use tr to convert newlines to spaces
        local command="sudo pacman -Sy $(echo "$package" | tr '\n' ' ')"
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
