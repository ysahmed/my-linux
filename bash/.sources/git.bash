
function gcop(){
	git log \
		--color=always \
		--format="%C(cyan)%h %C(blue)%ar%C(auto)%d \
				%C(yellow)%s%+b %C(black)%ae" "$@" |
	fzf -i -e +s \
		--reverse \
		--tiebreak=index \
		--no-multi \
		--ansi \
		--preview="echo {} |
				grep -o '[a-f0-9]\{7\}' |
				head -1 |
				xargs -I % sh -c 'git show --color=always % |
				diff-so-fancy'" \
		--header "enter: view, C-c: copy hash" \
		--bind "enter:execute:
            echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
            xargs -I % sh -c 'git show --color=always % | diff-so-fancy' | less -R"  \
		--bind "ctrl-c:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xclip -selection clipboard)"
}

function fshow() {
  # Enter will view the commit
  # Ctrl-o will checkout the selected commit
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview \
         'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 | diff-so-fancy; }; f {}' \
      --header "enter to view, ctrl-o to checkout" \
      --bind "q:abort,ctrl-f:preview-page-down,ctrl-b:preview-page-up" \
      --bind "ctrl-o:become:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less -R') << 'FZF-EOF'
                {}
FZF-EOF" --preview-window=right:60%
}



function fsb() {
    # Fuzzy search Git branches in a repo
    # Looks for local and remote branches
    local pattern=$*
    local branches branch
    branches=$(git branch --all | awk 'tolower($0) ~ /'"$pattern"'/') &&
    branch=$(echo "$branches" |
             fzf-tmux -p --reverse -1 -0 +m)

    # If a branch is selected, proceed with the checkout
    if [ -n "$branch" ]; then
        git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
    fi
    return
}

