#!/bin/bash

function test(){
    echo $1, $2
    echo "$@" #以列表的形式打印参数
    echo "$*" #整体打印中间没空格，有空格的啊。。。
    return 0;
}

test 12 33 44 55 6a6 77