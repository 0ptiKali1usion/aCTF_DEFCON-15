#!/bin/bash
thisDir="/root/admin/flags/chatProgram"

echo "Copying files"
for i in `ls $thisDir | grep -v restore.sh`; do
  scp $thisDir/$i services3:/usr/libexec/
done

echo "Setting permissions"
ssh services3 "chmod 700 /usr/libexec/chat-bot.pl"
ssh services3 "chmod 755 /usr/libexec/chat-listen.sh"
ssh services3 "chmod 755 /usr/libexec/chat-speak.pl"

