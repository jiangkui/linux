#!/bin/bash
# function
# 时间：2015-12-10 12:48:35

users=$(cut -d ':' -f1 /etc/passwd)
for username in $users
do
	id $username
	finger $username
done
