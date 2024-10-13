
# Overrides fzf completion
_fzf_comprun() {
  local cmd="$1"
  local bat_theme="gruvbox-dark"
  shift

  case "$cmd" in
    cd|ls|la|ll)
      # Show directories
      find -type d | fzf --border sharp --height 70% --preview="exa --tree --level=2 --icons --color=always {}" "$@"
      ;;
    nano|vim|nvim|kwrite|cat|bat)
      # Show files
      find -type f| fzf --border sharp --height 70% --preview="bat -f --theme $bat_theme {}" "$@"
      ;;
    *)
      # Default behavior
      command fzf "$@"
      ;;
  esac
}


export FZF_COMPLETION_TRIGGER="??"
