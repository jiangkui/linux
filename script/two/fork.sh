#!/bin/bash

F(){
    echo $1
    F hello
    sleep 1
}

F haha

#著名的 Fork 炸弹！
#参见：https://zh.wikipedia.org/wiki/Fork%E7%82%B8%E5%BC%B9
#:(){ :|:& }