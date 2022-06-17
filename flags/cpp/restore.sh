#!/bin/bash
thisDir="/root/admin/flags/cpp"
flag=`ssh LocalExploits "cat /home/cpp/flag.txt"`

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
for i in `ls $thisDir | grep -v restore.sh`; do
  scp $thisDir/$i LocalExploits:/home/cpp/
done
ssh LocalExploits "echo '$flag' > /home/cpp/flag.txt"

echo "Setting permissions"
ssh LocalExploits "chmod 6771 /home/cpp/x"
ssh LocalExploits "chmod 664 /home/cpp/flag.txt"
ssh LocalExploits "chown cppflag:cppflag /home/cpp/*"
