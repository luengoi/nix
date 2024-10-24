#   keybindings.zsh
#   Key bindings and mapping configuration.

# Make sure that the terminal is in application mode when zle is active,
# since only then values from $terminfo are valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# -- EDITING -----------------------------------------------------------
# ----------------------------------------------------------------------

# [Backspace] delete backward.
bindkey '^?' backward-delete-char

# [Delete] delete forward.
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# Edit current command line in $EDITOR.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# -- HISTORY -----------------------------------------------------------
# ----------------------------------------------------------------------

bindkey -M vicmd '^r' history-incremental-pattern-search-backward
bindkey -M vicmd '^f' history-incremental-patterh-search-forward

bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey -M viins '^f' history-incremental-pattern-search-forward

if [[ -n "${terminfo[kcuu1]}" ]]; then
  # [Up-Arrow] fuzzy find history forward.
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

if [[ -n "${terminfo[kcud1]}" ]]; then
  # [Down-Arrow] fuzzy find history backward.
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Do history expansion
bindkey ' ' magic-space

# -- COMPLETION --------------------------------------------------------
# ----------------------------------------------------------------------

if [[ -n "${terminfo[kbct]}" ]]; then
  # [Shift-Tab] move through completion menu backwards.
  bindkey "${terminfo[kbct]}" reverse-menu-complete
fi
