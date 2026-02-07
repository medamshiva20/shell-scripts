#!/bin/bash

USERID=$(id -u)
LOGS_DIR="/var/log/shell-script/"
LOG_FILE="$LOGS_DIR/backup.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ] ;
then 
    echo "$R Please run this script with root user $N"
    ecit 1
fi

USAGE(){
    echo -e " $R USAGE:: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ] ;
then 
    USAGE
fi