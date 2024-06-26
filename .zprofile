export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # Kill detached sessions

    detached_sessions=$(tmux list-sessions -F '#{session_attached} #{session_id}' | awk '/^0/{print $2}')

    if [[ ! -z $detached_sessions ]]; then
        echo $detached_sessions | xargs -n 1 tmux kill-session -t
    fi
    
    exec tmux
fi
