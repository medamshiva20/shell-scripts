#!/bin/bash 
set -e

trap 'echo "There is an error in $LINENO,Command: $BASH_COMMAND"' ERR

echo "Hello World"
echo "I am learning shell"
echoo "Printing error here"
echo "No error in this"