# @Author: Shreker.Nil
# @Date:   2022-12-04 23:09:30
# @Last Modified by:   Shreker.Nil
# @Last Modified time: 2022-12-05 21:28:48


function echo_sucess() {
    echo -e "\033[32m$1\033[0m"
}

function echo_failure() {
    echo -e "\033[41;37m$1\033[0m"
}

function echo_warning() {
    echo -e "\033[43;37m$1\033[0m"
}

function echo_separator() {
    echo -e "\033[44;37m$1\033[0m"
}

function echo_info() {
    echo -e "\033[40;37m$1\033[0m"
}

function new_line() {
    echo -e "\n"
}