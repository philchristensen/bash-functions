function activate_virtualenv {
  if [ -f "$PWD/.venv" ]; then
    NEW_ENV=$(cat $PWD/.venv)
    if [ "$NEW_ENV" != $(basename $VIRTUAL_ENV) ]; then
      echo 'Changing virtualenv...'
      workon $NEW_ENV
    fi
  fi
}