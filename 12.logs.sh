#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/varlog/shell-script"
LOG_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ] ;
then 
    echo "Please run the script with root user" | tee -a $LOG_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
if [ $1 -ne 0 ] ;
then
    echo "$2...FAILURE" | tee -a $LOG_FILE
    exit 1
else
    echo "$2...SUCCESS" | tee -a $LOG_FILE
fi
}

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing Nginx"

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing MySQL"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "Installing nodejs"