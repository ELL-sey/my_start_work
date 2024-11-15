#!/bin/bash

MYDATE=$(/bin/date +'%Y/%m/%d %H:%M:%S')
path=$1

curl -F document=@$1 https://api.telegram.org/bot$TOKENBOT/sendDocument -F chat_id=$CHIDBOT > /dev/null 

