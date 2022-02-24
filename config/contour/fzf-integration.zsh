[[ $TERMINAL_NAME == "contour" ]] || return

# Enables the shell to quickly grab contents from the screen buffer
# by pressing ^F (Ctrl + F) and fuzzy search via fzf.
fzf-contour-hist-widget() {
  local tmpfile=$(mktemp -t contour-capture-XXXXXXXXX)
  contour capture logical lines 250 timeout 2 to "${tmpfile}"
  selected=$(tr "[:space:]" "\n" <${tmpfile} | sort | uniq | fzf --tac)
  rv=$?

  zle reset-prompt
  zle -U "${selected}"
  rm "${tmpfile}"
  return ${rv}
}

zle     -N   fzf-contour-hist-widget
bindkey '^F' fzf-contour-hist-widget
