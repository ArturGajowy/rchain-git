#!/bin/bash

_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DIR=$( echo $_DIR | sed 's/\/.git\/hooks$//' )

#FILES_TO_FORMAT=$( git diff HEAD --name-only | grep -E '\.(scala)|(sbt)$' )
#
#echo
#
#if [[ -z ${FILES_TO_FORMAT} ]]
#then
#  echo "No files changed, time scalafmt skipped."
#  exit 0
#fi

#echo "Checking formatting of all changed files:"
#printf '%s\n' "${FILES_TO_FORMAT[@]}"
#echo

time scalafmt --test --diff-branch HEAD
#time scalafmt --test ${FILES_TO_FORMAT} &> /dev/null
FORMATTED=$?

if [ ${FORMATTED} -eq 0 ]
then
  echo "All files formatted properly."
else
  echo "Reformatting. Please check the results and commit again."
#  time scalafmt ${FILES_TO_FORMAT}
  time scalafmt --diff-branch HEAD
  exit 1
fi
