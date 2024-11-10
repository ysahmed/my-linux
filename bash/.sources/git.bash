
function gcop() {
  local -r format="%C(cyan)%h %C(blue)%ar%C(auto)%d %C(yellow)%s%+b %C(black)%ae"
  local -r preview="echo {} |
    grep -o '[a-f0-9]\{7\}' |
    head -1 |
    xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

  git log --color=always --format="$format" "$@" |
    fzf -i -e +s \
      --reverse \
      --tiebreak=index \
      --no-multi \
      --ansi \
      --preview="$preview" \
      --header "enter: view, C-c: copy hash" \
      --bind "enter:execute:git show --color=always \$(echo {} | grep -o '[a-f0-9]\{7\}' | head -1) | diff-so-fancy | less -R" \
      --bind "ctrl-c:execute:echo \$(echo {} | grep -o '[a-f0-9]\{7\}' | head -1) | xclip -selection clipboard"
}

function fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index \
      --preview 'git show --color=always $(echo {} | grep -o "[a-f0-9]\{7\}") | diff-so-fancy' \
      --header "enter to view, ctrl-o to checkout" \
      --bind "q:abort,ctrl-f:preview-page-down,ctrl-b:preview-page-up" \
      --bind "ctrl-o:become:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
      --bind "enter:execute:(git show --color=always $(echo {} | grep -o '[a-f0-9]\{7\}') | diff-so-fancy | less -R)" \
      --preview-window=right:60%
}



function fsb() {
  local -r pattern="$*"
  local -r branches=$(git branch --all | awk "tolower(\$0) ~ /$pattern/")
  local -r selected_branch=$(echo "$branches" | fzf-tmux -p --reverse -1 -0 +m)

  if [[ -n "$selected_branch" ]]; then
    git checkout "$(echo "$selected_branch" | sed "s/.* //; s#remotes/[^/]*/##")"
  fi
}

