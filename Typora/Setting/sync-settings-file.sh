#!/bin/bash
#
# @Author: Shreker.Nil
# @Date:   2022-12-04 22:23:44
# @Last Modified by:   Shreker
# @Last Modified time: 2023-09-03 01:45:09

function show_green() {
    echo -e "\033[32m$1\033[0m"
}

function show_red() {
    echo -e "\033[31m$1\033[0m"
}

function show_new_line() {
    echo -e "\n"
}


function backup() {
    show_new_line
    show_green "################################"
    show_green "1. Backing up profile.data ..."

    if [[ -a "/c/Users/Shreker/AppData/Roaming/Typora/profile.data" ]]; then
        show_green "profile.data Exists, Backing up ..."
        cp /c/Users/Shreker/AppData/Roaming/Typora/profile.data ./
        show_new_line
        show_green "profile.data is successfully backed up."
        show_new_line
    else
        show_red "profile.data NOT Exists, Backup operation TERMINATED."
        show_new_line
    fi

    show_new_line
    show_green "################################"
    show_green "1. Backing up purple-squence-light.css ..."

    C:\Users\Shreker\AppData\Roaming\Typora\themes
    if [[ -a "/c/Users/Shreker/AppData/Roaming/Typora/themes/purple-squence-light.css" ]]; then
        show_green "purple-squence-light.css Exists, Backing up ..."
        cp /c/Users/Shreker/AppData/Roaming/Typora/themes/purple-squence-light.css ./
        show_new_line
        show_green "purple-squence-light.css is successfully backed up."
        show_new_line
    else
        show_red "purple-squence-light.css NOT Exists, Backup operation TERMINATED."
        show_new_line
    fi
}

function recovery() {
    show_new_line
    show_green "################################"
    show_green "Recovery profile.data ..."

    cp ./profile.data /c/Users/Shreker/AppData/Roaming/Typora/profile.data
    if [[ $? == 0 ]]; then
        show_green "profile.data Recovery operation DONE!"
    else
        show_red "profile.data Recovery operation FAILURED, chcking for more details!"
    fi

    show_new_line
    show_green "################################"
    show_green "Recovery profile.data ..."

    cp ./purple-squence-light.css /c/Users/Shreker/AppData/Roaming/Typora/themes/purple-squence-light.css
    if [[ $? == 0 ]]; then
        show_green "purple-squence-light.css Recovery operation DONE!"
    else
        show_red "purple-squence-light.css Recovery operation FAILURED, chcking for more details!"
    fi
}

function main_opt() {
    show_green "################################"
    show_green " 0 for BACKUP"
    show_green " 1 for RECOVERY"
    show_green "################################"

    read -p "Your Choice:" num

    if [[ $num == 0 ]]; then
        backup
    elif [[ $num == 1 ]]; then
        recovery
    else
        show_red "INVALID input ... try again ..."
        main_opt
    fi

    show_new_line
    show_green "All work DONE!"
}

main_opt

show_new_line
read -p "PRESSING ENTER TO EXIT ... "
