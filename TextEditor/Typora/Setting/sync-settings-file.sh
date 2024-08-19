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


function backup() {
    show_green '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    show_green 'Backup ...'

    if [[ -a '/c/Users/Shreker/AppData/Roaming/Typora/profile.data' ]]; then
        show_green 'Preferences.json Exists, Backup operation going on ...'
        cp /c/Users/Shreker/AppData/Roaming/Typora/profile.data ./
        if [[ $? == 0 ]]; then
            show_green 'Preferences.json Backup operation DONE!'
        else
            show_red 'Preferences.json Backup operation FAILURED, chcking for more details!'
        fi
    else
        show_red 'Preferences.json NOT Exists, Backup operation TERMINATED.'
    fi
}

function recovery() {
    show_green '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    show_green 'Recovery ...'

    cp ./profile.data /c/Users/Shreker/AppData/Roaming/Typora/profile.data
    if [[ $? == 0 ]]; then
        show_green 'Preferences.json Recovery operation DONE!'
    else
        show_red 'Preferences.json Recovery operation FAILURED, chcking for more details!'
    fi
}

function main_opt() {
    read -p '0 for BACKUP, 1 for RECOVERY. Your Choice:' num

    if [[ $num == 0 ]]; then
        backup
    elif [[ $num == 1 ]]; then
        recovery
    else
        show_red 'INVALID input ... try again ...'
        main_opt
    fi
}

main_opt

read -p "PRESSING ENTER TO EXIT ... "
