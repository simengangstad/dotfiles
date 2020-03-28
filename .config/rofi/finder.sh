#!/usr/bin/env bash

if [ ! -z "$@" ]
then
  QUERY=$@
  if [[ "$@" == /* ]]
  then
    if [[ "$@" == *\?\? ]]
    then
      coproc ( nautilus "${QUERY%\/* \?\?}"  > /dev/null 2>&1 )
      exec 1>&-
      exit;
    else
      coproc ( nautilus "$@"  > /dev/null 2>&1 )
      exec 1>&-
      exit;
    fi
  elif [[ "$@" == \?* ]]
  then
    while read -r line; do
      echo "$line" \?\?
    done <<< $(find $HOME -iname *"${QUERY#\?}"* 2>&1 | grep -v 'Permission denied\|Input/output error')
  else
    find $HOME -iname *"${QUERY#!}"* 2>&1 | grep -v 'Permission denied\|Input/output error'
  fi
fi

