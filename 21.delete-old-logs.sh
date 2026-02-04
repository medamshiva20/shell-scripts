#!/bin/bash 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE=$LOGS_DIR/$0.log

[ ! -d $LOGS_DIR ] ;
then 
    echo "$LOGS_DIR does not exist"
    exit 1
fi

FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log" -type f -mtime +14)

echo "$FILES_TO_DELETE"