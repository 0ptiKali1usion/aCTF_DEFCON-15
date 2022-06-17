#!/bin/bash
thisDir="/root/admin/flags/banshe"
flag=`ssh crypto "cat /usr/local/bin/flag.txt"`

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
for i in `ls $thisDir | grep -v restore.sh`; do
  scp $thisDir/$i crypto:/usr/local/bin/
done
ssh crypto "echo '$flag' > /usr/local/bin/flag.txt"

echo "Setting permissions"
ssh crypto "chmod 755 /usr/local/bin/*"

