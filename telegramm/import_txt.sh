#!/bin/bash

MYDATE=$(/bin/date +'%Y/%m/%d %H:%M:%S')

myVar=$( < /dev/stdin)

URL="https://api.telegram.org/bot$TOKENBOT/sendMessage"
echo "$myVar" 
/usr/bin/curl -s -X POST $URL -d chat_id=$CHIDBOT -d parse_mod=markdown  -d text="$MYDATE %0AMessage from $HOSTNAME %0A__________________ %0A$myVar" > /dev/null 
exit 0


