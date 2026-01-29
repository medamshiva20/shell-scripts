#!/bin/bash 

NUM1=100
#NUM2=200
NUM2=sivareddy
SUM=$(($NUM1+$NUM2))

echo "Sum is :$SUM"

#This is Array
FRUITS=("Apple" "Banana" "Promo")

echo "fruits are:${FRUITS[@]}"
echo "First fruit is:${FRUITS[0]}"
echo "Second fruit is:${FRUITS[1]}"
echo "Third fruit is:${FRUITS[2]}"