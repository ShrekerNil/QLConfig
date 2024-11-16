#!/bin/sh

exec > >(tee "${CUR_DIR}/sync.log") 2>&1

function echo_sucess() {
    echo -e "GIT-SYNC-CTRL:" "\033[32m$1\033[0m"
}

function echo_failure() {
    echo -e "GIT-SYNC-CTRL:" "\033[41;37m$1\033[0m"
}

function echo_warning() {
    echo -e "GIT-SYNC-CTRL:" "\033[43;37m$1\033[0m"
}

function echo_info() {
    echo -e "GIT-SYNC-CTRL:" "\033[40;37m$1\033[0m"
}

function echo_bluebg_whitetext() {
    echo -e "GIT-SYNC-CTRL:" "\033[44;37m$1\033[0m"
}

function echo_purplebg_whitetext() {
    echo -e "GIT-SYNC-CTRL:" "\033[45;37m$1\033[0m"
}

function new_line() {
    echo -e "\n"
}

arr_excludes=("/d/QLRepo/Temps")

function check_excludes() {
    local CUR_DIR="$1"
    for exclude in "${arr_excludes[@]}"
    do
        if [[ "$CUR_DIR" == "$exclude" ]]; then
            return 0
        fi
    done
    return 1
}


function start_process() {
    local CUR_DIR=$1
    new_line
    echo_purplebg_whitetext "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo_info               "+  Start Synchronizing Root: ${CUR_DIR}"
    echo_purplebg_whitetext "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    # echo ${CUR_DIR} >> test.txt

    for sub_dir in ${CUR_DIR}/*; do
        if test -d ${sub_dir} ; then
            cd ${sub_dir}
            new_line
            echo_bluebg_whitetext ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            echo_info             "  Found Sub Dir: `basename ${sub_dir}`"
            echo_bluebg_whitetext "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

            if check_excludes ${sub_dir}; then
                echo_info "${sub_dir} excluded, Skipping ...";
                continue
            fi

            if [[ -d "${sub_dir}/.git" ]]; then
                if [[ -f "mine" ]]; then
                    new_line
                    echo_info "Synchronizing AUTO Git Repo: ${sub_dir}"
                    new_line
                    # bash /d/QLRepo/QLNotes/Config/VControl/Scripts/git-sync.sh `pwd`
                    bash ${sub_dir}/git-sync.sh `pwd`
                    continue
                else
                    new_line
                    echo_info ">>> '${sub_dir}' Is Not my Repo, Cause There's No File: mine, Skipping ..."
                fi
            else
                new_line
                echo_info ">>> '${sub_dir}' Is Not A Git Repo, Handling Sub Directory ..."
                start_process ${sub_dir}
            fi
        fi
    done
}

# CUR_DIR="$( cd "$( dirname "$0"  )" && pwd )"

CUR_DIR='/d/QLRepo'

start_process ${CUR_DIR}

new_line

echo_sucess "All Work Done!"

new_line

read -p "PRESSING ENTER TO EXIT ... "
