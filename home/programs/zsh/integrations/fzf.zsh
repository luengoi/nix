#   fzf.zsh
#   fzf integration for ZSH.

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"

  if [ -n "${commands[rg]}" ]; then
    export FZF_CTRL_T_COMMAND="rg --files --hidden --follow -g '!{.git,node_modules}' 2>/dev/null"
  fi
fi
