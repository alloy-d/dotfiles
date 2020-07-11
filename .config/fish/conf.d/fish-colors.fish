if status --is-interactive
  set -g fish_color_autosuggestion brblack
  set -g fish_color_cancel -r
  set -g fish_color_command blue
  set -g fish_color_comment red
  set -g fish_color_cwd green
  set -g fish_color_cwd_root red
  set -g fish_color_end yellow # originally blue/cyan-ish
  set -g fish_color_error brred
  set -g fish_color_escape cyan
  set -g fish_color_history_current --bold
  set -g fish_color_host normal
  set -g fish_color_host_remote yellow
  set -g fish_color_match --background=brblue
  set -g fish_color_normal normal
  set -g fish_color_operator yellow
  set -g fish_color_param green # originally a darker blue than command
  set -g fish_color_quote brgreen
  set -g fish_color_redirection magenta # originally a blue
  set -g fish_color_search_match 'bryellow'  '--background=brblack'
  set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
  set -g fish_color_status red
  set -g fish_color_user brgreen
  set -g fish_color_valid_path --underline
  set -g fish_pager_color_completion
  set -g fish_pager_color_description yellow
  set -g fish_pager_color_prefix 'white'  '--bold'  '--underline'
  set -g fish_pager_color_progress 'brwhite'  '--background=cyan'
end
