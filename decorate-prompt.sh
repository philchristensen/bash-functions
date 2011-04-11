function parse_svn_branch {
  if [ -d '.svn' ]; then
    ref=$(svn info | grep URL | awk -F/ '{print $NF}' 2> /dev/null) || return
    cur=$(pwd | awk -F/ '{print $NF}' 2> /dev/null) || return
    if [ $ref != $cur ]; then
      echo -ne "\xE2\x9C\xB6${ref}"
    fi
  fi
}

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo -ne "\xE2\x9C\xB9${ref#refs/heads/}"
}

function display_virtualenv {
  if [ -n "$VIRTUAL_ENV" ]; then
    ref=$(basename $VIRTUAL_ENV)
    echo -ne "\xE2\x9D\xB0${ref}\xE2\x9D\xB1"
  fi
}

function display_virtualenv_path {
  if [ -n "$VIRTUAL_ENV" ]; then
    ref=$(basename $VIRTUAL_ENV)
    echo -ne "${ref}"
  fi
}

function decorate_prompt {
  clock="[\[\e[31;49m\]\@\[\e[0m\]]"
  svn="\[\e[1;35m\]\$(parse_svn_branch)\[\e[0m\]"
  git="\[\e[1;34m\]\$(parse_git_branch)\[\e[0m\]"
  user="\[\e[37m\]\u@\h:\[\e[0m\]"

  ref=$(basename "$VIRTUAL_ENV")
  basedir=$(pwd | awk -F/ '{print $NF}' 2> /dev/null)
  if [ "$basedir" == "$ref" ]; then
    virtual="\[\e[31;36m\]\$(display_virtualenv_path)\[\e[0m\]"
    working_dir=$(dirname `pwd`)
    export PS1="${clock} ${user}${working_dir/\/home\/phil/~}/${virtual}${svn}${git} \$ "
  else
    virtual="\[\e[31;36m\]\$(display_virtualenv)\[\e[0m\]"
    export PS1="${clock} ${user}\w${virtual}${svn}${git} \$ "
  fi
}
