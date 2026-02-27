function tdl
    if test (count $argv) -eq 0
        echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end

    if not set -q TMUX
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir $PWD
    set -l editor_pane $TMUX_PANE
    set -l ai $argv[1]
    set -l ai2 $argv[2]

    tmux rename-window -t "$editor_pane" (basename "$current_dir")

    tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"

    set -l ai_pane (tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

    if test -n "$ai2"
        set -l ai2_pane (tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
        tmux send-keys -t "$ai2_pane" "$ai2" C-m
    end

    tmux send-keys -t "$ai_pane" "$ai" C-m

    tmux send-keys -t "$editor_pane" "$EDITOR ." C-m

    tmux select-pane -t "$editor_pane"
end

function tdlm
    if test (count $argv) -eq 0
        echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end

    if not set -q TMUX
        echo "You must start tmux to use tdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l base_dir $PWD

    tmux rename-session (basename "$base_dir" | tr '.:' '--')

    set -l first true
    for dir in $base_dir/*/
        if test -d "$dir"
            set -l dirpath (string replace -r '/$' '' -- "$dir")

            if test "$first" = "true"
                tmux send-keys -t $TMUX_PANE "cd '$dirpath' && tdl $ai $ai2" C-m
                set -l first false
            else
                set -l pane_id (tmux new-window -c "$dirpath" -P -F '#{pane_id}')
                tmux send-keys -t "$pane_id" "tdl $ai $ai2" C-m
            end
        end
    end
end

function tsl
    if test (count $argv) -lt 2
        echo "Usage: tsl <pane_count> <command>"
        return 1
    end

    if not set -q TMUX
        echo "You must start tmux to use tsl."
        return 1
    end

    set -l count $argv[1]
    set -l cmd $argv[2]
    set -l current_dir $PWD
    set -l panes

    tmux rename-window -t $TMUX_PANE (basename "$current_dir")

    set -aq panes $TMUX_PANE

    while test (count $panes) -lt $count
        set -l new_pane (tmux split-window -h -t $panes[-1] -c "$current_dir" -P -F '#{pane_id}')
        set -aq panes $new_pane
        tmux select-layout -t $panes[1] tiled
    end

    for pane in $panes
        tmux send-keys -t "$pane" "$cmd" C-m
    end

    tmux select-pane -t $panes[1]
end
