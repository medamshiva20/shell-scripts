#!/bin/bash 

USERID=$(id -u)
LOGS_DIR="/var/log/shell-script"
LOG_FILE="$LOGS_DIR/$0.log"

if [ $USERID -ne 0 ] ;
then 
    echo "Please run this script with root user" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p /var/log/shell-script

VALIDATE(){
    if [ $1 -ne 0 ] ;
    then
        echo "$2...FAILURE" | tee -a $LOG_FILE
        exit 1
    else
        echo "$2...SUCCESS" | tee -a $LOG_FILE
    fi
}


for package in $@
do
   dnf list installed $package &>>$LOG_FILE
   if [ $? -ne 0 ] ;
   then 
        echo "$package not installed,installing now"
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package installation"
   else
        echo "$package already installed,skipping"
    fi
done