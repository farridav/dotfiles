top=$(tmux new-window -P -n all)
tmux list-panes -a | grep -v "^$top" | grep -o  "%[0-9]\+\>" |
  while read p ; do
    tmux joinp -s $p -t $top
    tmux select-layout tiled
  done
tmux kill-pane -t $top
tmux select-layout tiled
