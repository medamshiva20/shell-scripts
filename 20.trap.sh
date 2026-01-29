#!/bin/bash 

set -e 

trap 'echo "There is an error in $LINENO,Command: $BASH_COMMAND"' ERR

USERID=$(id -u)
LOGS_DIR="/var/log/shell-script"
LOG_FILE="$LOGS_DIR/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ] ;
then
    echo -e "$R Please run this script with root user $N"|tee -a $LOG_FILE
    exit1
fi


for package in $@
do 
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ] ;
    then 
        echo "$package not installed, installing now"
        dnf install $package -y &>>$LOG_FILE
    else
        echo -e "$package already installed...$Y SKIPPING $N"
    fi
done