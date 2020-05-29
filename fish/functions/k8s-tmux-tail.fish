# Usage: k8s-tmux-tail kubectl-command pod-name-grep-pattern
#
# Run from within the tmux session you want to open the window in.
# If a window already exists, it is killed and replaced.
#
# Examples:
#		# use kubectl to tail logs for all pods matching my-app
#		k8s-tmux-tail kubectl my-app
#
#		# use my-kubectl-alias to tail logs for all pods matching my-app
#		k8s-tmux-tail my-kubectl-alias my-app
#
function k8s-tmux-tail --description "tail logs for all k8s pods matching PATTERN in a new tmux window" --argument-names kubectl pattern
  echo "Using $kubectl to tail all pods matching $pattern..."

  set pods ($kubectl get pods | kng "$pattern")
  echo "will open panes to tail pods: $pods"

  if tmux list-windows | grep -q "$pattern"
    echo "killing already-open window"
    tmux kill-window -t "$pattern"
  end

  echo "opening window to tail $pods[1]"
  tmux new-window -n "$pattern" fish -c "$kubectl logs --tail=10 -f $pods[1]"
  for pod in $pods[2..-1]
    echo "opening pane to tail $pod"
    tmux split-window -f -t "$pattern" fish -c "$kubectl logs --tail=10 -f $pod"
  end

  tmux select-layout -t "$pattern" even-vertical
end
