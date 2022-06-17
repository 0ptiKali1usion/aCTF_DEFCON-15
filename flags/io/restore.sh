#!/bin/bash
thisDir="/root/admin/flags/io"
flag=`ssh LocalExploits "cat /home/io/flag.txt"`

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
for i in `ls $thisDir | grep -v restore.sh`; do
  scp $thisDir/$i LocalExploits:/home/io/
done
ssh LocalExploits "echo '$flag' > /home/io/flag.txt"

echo "Setting permissions"
ssh LocalExploits "chmod 740 /home/io/*.sh"
ssh LocalExploits "chmod 700 /home/io/ls.sh"
ssh LocalExploits "chmod 660 /home/io/flag.txt"
ssh LocalExploits "chgrp usable /home/io/*"
ssh LocalExploits "chown cat /home/io/cat.sh"
ssh LocalExploits "chown flag /home/io/flag.*"
ssh LocalExploits "chown input /home/io/input.sh"
ssh LocalExploits "chown less /home/io/less.sh"
ssh LocalExploits "chown betterls /home/io/ls.sh"
ssh LocalExploits "chown more /home/io/more.sh"
ssh LocalExploits "chown output /home/io/output.sh"
