#!/bin/sh
#============ get the file name ===========

function echo_sucess() {
    echo -e "GIT-SYNC-CTRL:" "\033[32m$1\033[0m"
}

function echo_failure() {
    echo -e "GIT-SYNC-CTRL:" "\033[41;37m$1\033[0m"
}

function echo_warning() {
    echo -e "GIT-SYNC-CTRL:" "\033[43;37m$1\033[0m"
}

function echo_separator() {
    echo -e "GIT-SYNC-CTRL:" "\033[44;37m$1\033[0m"
}

function echo_info() {
    echo -e "GIT-SYNC-CTRL:" "\033[40;37m$1\033[0m"
}


function new_line() {
    echo -e "\n"
}

function start_process() {
    cur_dir=$1
    echo_separator "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo_info      "Start Synchronizing Root: ${cur_dir}"
    echo_separator "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    # echo ${cur_dir} >> test.txt

    for sub_dir in ${cur_dir}/*; do
        if test -d ${sub_dir} ; then
            cd ${sub_dir}
            new_line
            echo_separator ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            echo_info      "Found Sub Dir: `basename ${sub_dir}`"
            echo_separator "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            if [[ -d "${sub_dir}/.git" ]]; then
                new_line
                echo_info "Synchronizing AUTO Git Repo: ${sub_dir}"
                new_line
                bash /d/QLRepo/QLNotes/Config/VControl/Scripts/git-pull.sh `pwd`
                continue
            else
                new_line
                echo_info "This Is Not A Git Repo, Handling Sub Directory ..."
                start_process ${sub_dir}
            fi
        fi
    done
}

# cur_dir="$( cd "$( dirname "$0"  )" && pwd )"

cur_dir='/d/SDTool/stable-diffusion-webui/extensions/'

start_process ${cur_dir}

new_line

echo_sucess "All Work Done!"

new_line

read -p "PRESSING ENTER TO EXIT ... "
