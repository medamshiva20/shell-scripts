#1/bin/bash 

USERID=$(id -u)
SOURCE_DIR=$1
DEST-DIR=$2

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0] ;
then 
    echo -e "$R Please run this script with root user $N"
    exit 1
fi

USAGE(){
    echo "USAGE:: sudo backup <SOURCE-DIR> <DEST-DIR> DAYS(default days 14)"
    exit 1
}

if [ $# -lt 2 ] ;
then 
    USAGE
fi

if [ ! -d $SOURCE_DIR ] ;
then
    echo -e "$R Source Directory:$SOURCE_DIR does not exist $N"
    exit 1
fi

if [ ! -d $DEST_DIR ] ;
then 
    echo -e "$R Destination Directory:$DESI_DIR does not exist $N"
    exit 1
fi 
