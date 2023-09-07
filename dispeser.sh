#!/bin/bash

total=5000

echo "welcome to halobank"

echo "confirm amount you desire to withdraw "

read amount

if $amount -le 0;then
	echo "invalid amount"
elif $amount -gt $total;then
	echo " insufficient fund"
else
	echo "withdrawal successful"
fi


