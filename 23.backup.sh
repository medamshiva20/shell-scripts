#!/bin/bash
#User should pass source_dir dest_dir,default is 14 days,but user can override
#verify directory exist and root user too
#find the files
#archieve them and place into dest_dir 
#Check archieve is success or not 
#if success you can delete from source_dir

USERID=$(id -u)
LOGS_DIR="/var/log/shell-script"
LOG_FILE="$LOGS_DIR/$0.log"
SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14}  # 14 days is the default value, if the user not supplied

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p $LOGS_FOLDER

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1"
}

if [ $USERID -ne 0 ] ;
then 
    log "$R Please run this script with root user $N"
    exit 1
fi

USAGE(){
    log -e " $R USAGE:: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ] ;
then 
    USAGE
fi

if [ ! -d $SOURCE_DIR ] ;
then
    log -e "$R Source Directory $SOURCE_DIR does not exist $N"
    exit 1
fi

if [ ! -d $DESTINATION_DIR ] ;
then 
    log -e "$R Destination directory $DESTINATION_DIR doesn not exist $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source Directory : $SOURCE_DIR"
log "Destination Directory: $DESTINATION_DIR"
log "Days: $DAYS"

if [ -z $FILES ] ;
then 
    log "No files to archive ... $Y Skipping $N"
else
    log "Files found to archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DESTINATION_DIR/app-logs-$TIMESTAMP.tar.gz"
        log "Archieve name:$ZIP_FILE_NAME"
        tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

    #check archieve success or not
    if [ -f $ZIP_FILE_NAME ] ;then
        log "Archieval is ...$G SUCCESS $N"

        while IFS= read -r filepath
        do 
            log Deleting file: $filepath
            rm -f $filepath
            log Deleted file: $filepath
        done <<< $FILE
    else
        log "Archieval is ...$R FAILURE $N"
        exit 1
    fi
fi