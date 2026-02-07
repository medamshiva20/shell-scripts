#!/bin/bash

USERID=$(id -u)
LOGS_DIR="/var/log/shell-script/"
LOG_FILE="$LOGS_DIR/$0.log"
SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14}  # 14 days is the default value, if the user not supplied

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ] ;
then 
    echo "$R Please run this script with root user $N"
    ecit 1
fi

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOG_FILE
}

USAGE(){
    echo -e " $R USAGE:: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ] ;
then 
    USAGE
fi

if [ ! -d $SOURCE_DIR ] ;
then
    echo -e "$R Source Directory $SOURCE_DIR does not exist $N"
    exit 1
fi

if [ ! -d $DESTINATION_DIR ] ;
then 
    echo -e "$R Destination directory $DESTINATION_DIR doesn not exist $N"
    exit 1
fi

log "Backup started"
log "Source Directory : $SOURCE_DIR"
log "Destination Directory: $DESTINATION_DIR"
log "Days: $DAYS"