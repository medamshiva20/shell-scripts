#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ] ;
then 
    echo "Please run the script with root user"
    exit 1
fi

VALIDATE(){
if [ $1 -ne 0 ] ;
then
    echo "$2...FAILURE"
    exit 1
else
    echo "$2...SUCCESS"
fi
}

dnf install nginxxxy
VALIDATE $? "Installing Nginx"

dnf install mysql -y 
VALIDATE $? "Installing MySQL"

dnf install nodejs -y 
VALIDATE $? "Installing nodejs"