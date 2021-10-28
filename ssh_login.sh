#!/usr/bin/expect -f
set timeout 3

set user {USER}
set host {HOST}
set password {PASSWORD}

# start work
spawn ssh $user@$host
expect "*assword:*"
send "$password\r"
interact
expect eof