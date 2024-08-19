#!/usr/bin/env bash

echo -e "\033]0;OVERWRITE FILES WITH THE NEW\007"

function judgement() {
  if [[ $1 -ne 0 ]]; then
    echo "$2 EXECUTED FAILURE."
    echo -e "\n"
    read -p "PRESSING 'ENTER' TO EXIT ... "
    exit 1
  else
    echo "$2 EXECUTED SUCCESSFULLY."
  fi
}

echo "********************************************************************"
echo ">>>>>>>>>>>>>>>     HANDLING TICKET MANAGER FILES    <<<<<<<<<<<<<<<"
echo "********************************************************************"

if [[ ($# != 0) && ($# != 2) ]]; then
  echo "PARAMS COUNT IS INVALID: $#"
  exit 2
fi

# read params
if [[ -z "$1" ]]; then
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo ">>>>>>>>>>>>>>>             OPTION CHOOSE            <<<<<<<<<<<<<<<"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo ">> 1. JUST CLEAR OLD FILES                                        >>"
  echo ">> 2. JUST COPY NEW FILES                                         >>"
  echo ">> 3. CLEAR OLD FILES AND COPY NEW FILES                          >>"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  read -p "ENTER YOUR CHOOSE: " opt
else
  opt=$1
  echo "READ OPTION FROM PARAM: ${opt}"
fi

if [[ $opt != "1" && $opt != "2" && $opt != "3" ]]; then
  echo "CAN NOT FIND OPTION: ${opt}"
  echo -e "\n"
  read -p "PRESSING 'ENTER' TO EXIT ... "
  exit 2
fi

echo "GOT INPUT: ${opt}"

if [ -z "$2" ]; then
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo ">>>>>>>>>>>>>>>              ENV CHOOSE              <<<<<<<<<<<<<<<"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo ">> 1. IDEA                                                        >>"
  echo ">> 2. ECLIPSE                                                     >>"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  read -p "ENTER YOUR CHOOSE: " num
else
  num=$2
  echo "READ OPTION FROM PARAM: ${num}"
fi

if [[ $num == "1" ]]; then
  BASE_DIR="/d/Repositories/Idea/master"
elif [[ $num == "2" ]]; then
  BASE_DIR="/c/Workspace/GitLab/Master"
else
  echo "CAN NOT FIND COMMAND: $num"
  read -p "PRESSING 'ENTER' TO EXIT ... "
  exit 4
fi

echo "GOT INPUT: ${num}"

echo -e "\n"

echo "U HAVE CHOOSED: $BASE_DIR, Start Processing ..."

SOURCE_TM_APP=/d/Downloads/ormsui/web/apps/tm-app
SOURCE_TM_MGR=/d/Downloads/ormsui/web/apps/ticketManager
TM_APP=$BASE_DIR/ormsui/web/apps/tm-app
TM_MGR=$BASE_DIR/ormsui/web/apps/ticketManager
EXTENSION="/*"

if [[ ! -d $TM_APP ]]; then
  mkdir -p $TM_APP
fi

if [[ ! -d $TM_MGR ]]; then
  mkdir -p $TM_MGR
fi

if [[ $opt -eq "1" || $opt -eq "3" ]]; then
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "++ START REMOVING OLD FILES ...                      ++"
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "Removing old files : ${TM_APP}${EXTENSION}"
  rm -rf ${TM_APP}${EXTENSION}
  judgement $? "Removing old files : tm-app "

  echo "------------------------------"

  echo "Restore git warehouse content for : $TM_APP"
  cd "$TM_APP" || judgement $? "CHANGING DIR TO: $TM_APP"
  git checkout "$TM_APP"
  cd $(dirname "$0") || judgement $? "CHANGING DIR TO: Origin"
  judgement $? "Restore repo files for tm-app "

  echo "------------------------------"

  echo "Removing old files : $TM_MGR"
  rm -rf $TM_MGR
  judgement $? "Removing old files: ticketManager "

  echo "------------------------------"
fi

if [[ $opt -eq "2" || $opt -eq "3" ]]; then
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "++ START COPYING NEW FILES ...                       ++"
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo Copying new files From $SOURCE_TM_APP/ TO $TM_APP/
  cp -rf $SOURCE_TM_APP/* $TM_APP/
  judgement $? "Copying new files : tm-app "

  echo "------------------------------"

  echo Copying new files From $SOURCE_TM_MGR TO $TM_MGR
  cp -rf $SOURCE_TM_MGR $TM_MGR
  judgement $? "Copying new files : ticketManager "

  #echo "------------------------------"
fi

if [[ $# != 2 ]]; then
  echo -e "\n"
  read -p "PRESS ENTER TO EXIT ... "
fi