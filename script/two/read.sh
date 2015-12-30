#!/bin/bash

num=0
while [[ $num -lt 10 ]]; do
    let num++

    #有回显的方式
#    read -n 1 var
#    echo "  read:"$var

    #无回显方式
    read -n 1 -s var
    echo $var

done
