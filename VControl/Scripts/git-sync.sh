#!/bin/bash

# This a script that can sync a folder that contains many git repos.
# Note: This script must be used standalone.
# from shreker long

function echo_sucess() {
    echo -e "GIT-SYNC:" "\033[32m$1\033[0m"
}

function echo_failure() {
    echo -e "GIT-SYNC:" "\033[41;37m$1\033[0m"
}

function echo_warning() {
    echo -e "GIT-SYNC:" "\033[43;37m$1\033[0m"
}

function echo_separator() {
    echo -e "GIT-SYNC:" "\033[44;37m$1\033[0m"
}

function echo_info() {
    echo -e "GIT-SYNC:" "\033[40;37m$1\033[0m"
}

function print_start_line() {
    new_line
    echo_separator "=========================="
}

function new_line() {
    echo -e "\n"
}

function judgement() {
    cmd=$1
    result_code=$2
    output=$3
    
    if [[ ${#output} -gt 0 ]]; then
        echo_info "${output}"
    fi

    if [[ $result_code -ne 0 ]]; then
        if [[ $result_code -eq 1 ]]; then
            echo_failure "ERROR: Common Unkown Error."
        else
            if [[ $result_code -eq 2 ]]; then
                echo_failure "ERROR: Command mistake: $result_code"
            elif [[ $result_code -eq 126 ]]; then
                echo_failure "ERROR: Unexecutable: $result_code"
            elif [[ $result_code -eq 127 ]]; then
                echo_failure "ERROR: Not a command: $result_code"
            elif [[ $result_code -eq 255 ]]; then
                echo_failure "ERROR: Exit status Invalid: $result_code"
            elif [[ $result_code -ge 128 ]]; then
                signal=$((result_code - 128))
                echo_failure "ERROR: Terminated by signal $signal"
            else
                echo_failure "UNEXPECTED CODE: $result_code"
            fi
        fi
        new_line
        echo_failure "Command Of \"$cmd\" Executed Failure. Please Try After Checking It."
        read -p "Pressing Enter To Resume ... "
        exit $result_code
    else
        new_line
        echo_sucess "Command Of \"$cmd\" Executed Successfully."
    fi
}

SCRIPT_SOURCE="$1"
IFS=' ' read -r -a SCRIPT_SOURCE <<< "$SCRIPT_SOURCE"

RUNNING_DIRECTLY=true

if [[ "${#SCRIPT_SOURCE[@]}" -ge 1 ]]; then
    echo "Current Script ($0) is being called by (${SCRIPT_SOURCE[${#SCRIPT_SOURCE[@]}-1]})"
    RUNNING_DIRECTLY=false
    COMMIT_MSG="-- Batch Commit Automaticly --"

    # echo_info "Current Params: $1"
    if [[ -d $1 ]]; then
        CUR_DIR=$1
    else
        echo_failure "Script call error: Parameter is required"
        # 128 Have no param of commit message
        exit 128
    fi
else
    echo "Current Script ($0) is running by user directly."
    RUNNING_DIRECTLY=true

    while true; do
        echo_separator "---------------------------------------------"
        read -p "Please Input Your Commit Message: " COMMIT_MSG

        if [[ -n "$COMMIT_MSG" && "$COMMIT_MSG" =~ [^[:space:]] ]]; then
            break
        else
            echo "ERROR: Commit Can not be Empty."
        fi
    done

    CUR_DIR=`pwd`
fi

echo_separator ">>> Start Backup ... for ${CUR_DIR}"

# echo_info "Current Folder: ${CUR_DIR}"

print_start_line
echo_info "Changing Directory to: ${CUR_DIR}"
cd ${CUR_DIR}
judgement "cd ${CUR_DIR}" $?

print_start_line
echo_info "Status for ${CUR_DIR}"
result=`git status`
judgement "git status" $? "$result"

NEED_PUSH=false

if [[ $result =~ "use \"git push\" to publish your local commits" ]]; then
    NEED_PUSH=true
fi

if [[ $result =~ "Changes not staged for commit" || $result =~ "Untracked files:" ]]; then
    print_start_line
    echo_info "Add ${CUR_DIR} files ..."
    result=`git add ./`
    judgement "git add ./" $? "$result"

    print_start_line
    echo_info "Commiting ... for ${CUR_DIR}"
    result=`git commit -m "$COMMIT_MSG"`
    judgement "git commit" $? "$result"
    NEED_PUSH=true
else
    new_line
    print_start_line
    echo_info "Nothing To Add and Commit, Working Tree Clean. Skipping ..."
fi

print_start_line
echo_info "Pulling for ${CUR_DIR}"
result=`git pull`
judgement "git pull" $? "$result"


if [[ $NEED_PUSH == true ]]; then
    print_start_line
    echo_info "Pushing Local Changes to Remote for ${CUR_DIR}"
    result=`git push`
    judgement "git push" $? "$result"
else
    new_line
    print_start_line
    echo_info "Nothing to push, Skipping ..."
fi

if [ "$RUNNING_DIRECTLY" = true ]; then
    new_line
    echo_separator "---------------------------------------------"
    read -p "PRESSING [Enter] TO EXIT ... "
fi
