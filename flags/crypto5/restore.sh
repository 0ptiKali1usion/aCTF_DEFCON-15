#!/bin/bash
thisDir="/root/admin/flags/crypto5"
flag=`ssh crypto "cat /usr/local/bin/crypto5_owner.txt"`
level=`ssh crypto "cat /usr/local/bin/crypto5_count.txt"`

if [[ $level != "" ]]; then
  echo "Setting number of times captured to $level"
else
  echo "Reverting to 0 captures"
  level="0"
fi

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
ssh crypto "echo '$level' > /usr/local/bin/crypto5_count.txt"
ssh crypto "echo '$flag' > /usr/local/bin/crypto5_owner.txt"

echo "Setting permissions"
ssh crypto "chmod 755 /usr/local/bin/*"

