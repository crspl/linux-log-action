#!/bin/bash

LANG="C"

CL_RED="\e[01;31m"
CL_GREEN="\e[00;32m"
CL_LGREEN="\e[00;92m"
CL_YELLOW="\e[01;33m"
CL_OFF="\e[00m"

# FUNCTIONS
echo_green_ts() {
    TS=`date '+%Y-%m-%d %H:%M:%S'`
    echo_green "[$TS] ${@}"
}

echo_green() {
    echo -e "${CL_GREEN}${@}${CL_OFF}"
}

echo_lgreen() {
    echo -e "${CL_LGREEN}${@}${CL_OFF}"
}

echo_yellow() {
    echo -e "${CL_YELLOW}${@}${CL_OFF}"
}

echo_red() {
    echo -e "${CL_RED}${@}${CL_OFF}"
}

CONFIG=/etc/logaction.conf
LOG=/var/log/logaction.log

NUM_LAST_ACTIONS=10

if [ -e $CONFIG ]; then
    source $CONFIG
fi

MESSAGE=""

# PARSE ARGS
while true; do
    if [ -z "$1" ]; then
        break;
    fi
    case "$1" in
        -n ) NUM_LAST_ACTIONS=$2; shift 2 ;;
        *) MESSAGE="$MESSAGE $1"; shift;;
    esac
done

if [ $NUM_LAST_ACTIONS -lt 1 ]; then
    NUM_LAST_ACTIONS=10
fi

if [ -z "$MESSAGE" ]; then
    if [ ! -e $LOG ]; then
        echo
        echo_yellow "logaction - no recent messages to display"
        echo
    else
        ACTIONS=`tail -n $NUM_LAST_ACTIONS $LOG`
        if [ -z "$ACTIONS" ]; then
            echo
            echo_yellow "logaction - no recent messages to display"
            echo
        else
            echo
            echo_yellow "logaction - recent messages (all dates in UTC):"
            CNT=0
            IFS=$'\n'; for ACTION in $ACTIONS; do
                CNT=$(( (CNT + 1) % 2 ))
                if [ $CNT -eq 0 ]; then
                    echo_green "    $ACTION"
                else
                    echo_lgreen "    $ACTION"
                fi
            done
            echo
        fi
    fi
else
    TS=`date -u '+%Y-%m-%d %H:%M:%S'`
    USER=$SUDO_USER

    WS=`who -m | awk '{ print $NF }' | sed 's/[()]//g'`

    if [ "$WS" == "" ]; then
        IP="unknown"
    else
        IP=`dig +short $WS`
        if [[ -z "$IP" ]]; then IP="$WS"; fi
    fi

    MSG="[$TS] [$IP] [$USER]$MESSAGE"

    echo "$MSG" >>$LOG
    echo_yellow "Logged message: ${CL_GREEN}${MSG}${CL_OFF}"
fi