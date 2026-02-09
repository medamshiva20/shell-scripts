#1/bin/bash 

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #14 days is the default value, if the user not supplie
LOGS_DIR="/var/log/shell-script"
LOG_FILE="$LOGS_DIR/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log(){
   echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1"
}

if [ $USERID -ne 0 ] ;
then 
    echo -e "$R Please run this script with root user $N"
    exit 1
fi

USAGE(){
    echo -e "$R USAGE:: sudo backup SOURCE_DIR DEST_DIR DAYS (default 14 days) $N"
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

 FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup Started"
log "Source Directory:$SOURCE_DIR"
log "Destination Directory:$DEST_DIR"
log "Days:$DAYS"

 if [ -z $FILES ] ;then 
    log "No files to archieve ...$Y Skipping $N"
else
    log "Files found to archieve: $FILES"
    TIMESTAMP=$(date +%F:%H:%M:%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
    log "Archieve Name:$ZIP_FILE_NAME"
     tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)
 
     #Check archieve success or not 
     if [ -f $ZIP_FILE_NAME ] ;
     then 
         echo "Archieval is ...$G SUCCESS $N"

         while IFS= read -r $filepath
         do
             log Deleting file: $filepath
             rm -f $filepath
             log "Deleted file: $filepath"
         done <<< $FILES 
     else
         echo "Archieval is ...$R FAILURE $N"
         exit 1
     fi
fi


