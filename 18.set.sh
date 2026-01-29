#!/bin/bash 

USERID=$(id -u)
LOGS_DIR="/var/log/shell-script"
LOG_FILE="$LOGS_DIR/$0.log"
set -e #This will be checking for errors ,if errors it will exit
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ] ;
then 
    echo -e "$R Please run this script with root user $N" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOGS_DIR

VALIDATE(){
    if [ $1 -ne 0 ] ;
    then 
        echo -e "$2...$R FAILURE $N" | tee -a $LOG_FILE
    else
        echo -e "$2...$G SUCCESS $N" | tee -a $LOG_FILE
    fi
}

for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ] ;
    then
        echo "$package not installed, installing now"
        dnf install $package -y &>>$LOG_FILE
        #ALIDATE $? "$package installation"
    else
        echo -e "$package already installed ...$Y SKIPPING $N"
    fi
done

