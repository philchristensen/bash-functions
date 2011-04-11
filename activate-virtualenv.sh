function activate_virtualenv {
  if [ -f "$PWD/.venv" ]; then
    new=$(cat $PWD/.venv)
    cur=$(basename $VIRTUAL_ENV/)
    if [ "$new" != "$cur" ]; then
      echo 'Changing virtualenv...'
      workon $new
    fi
  fi
}