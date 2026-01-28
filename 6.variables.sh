#!/bin/bash 

#TIMESTAMP=$(date)
#echo "Script executed at :$TIMESTAMP"

START_TIME=$(date +%s)

echo "script executed at:$START_TIME"

sleep 20 

END_TIME=$(date +%s)
TOTAL_TIME=$(($START_TIME-$END_TIME))

echo "Script executed in: $TOTAL_TIME seconds"