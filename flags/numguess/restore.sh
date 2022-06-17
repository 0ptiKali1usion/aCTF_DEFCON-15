#!/bin/bash
thisDir="/root/admin/flags/numguess"

echo "Copying file"
for i in `ls $thisDir | grep -v restore.sh`; do
  scp $thisDir/$i games:/usr/local/bin/
done

echo "Setting permissions"
ssh games "chmod 755 /usr/local/bin/*"
ssh games "/usr/local/bin/numguess&"
