#!/bin/bash 

# count=1

# while [ $count -le 6 ]
# do
#     echo Count is $count
#     ((count++))
# done

while IFS= read -r line;
do
    echo $line;
done < 20.trap.sh