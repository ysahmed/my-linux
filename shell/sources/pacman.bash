function fpac() {
    package=$(pacman -Sl | fzf -m --reverse) || return
    if [[ -n $package ]]; then
        command="sudo pacman -Sy $(echo "$package" | cut -d' ' -f2)"
        # Open the command in the terminal for editing and execution
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
