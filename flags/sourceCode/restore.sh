#!/bin/bash
thisDir="/root/admin/flags/sourceCode"
flag=`ssh crypto "cat /usr/local/apache2/htdocs/flag.txt"`

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
for i in `ls $thisDir | grep -v restore.sh`; do
  scp $thisDir/$i crypto:/usr/local/apache2/htdocs/
done
ssh crypto "echo '$flag' > /usr/local/apache2/htdocs/flag.txt"

echo "Setting permissions"
ssh crypto "chown daemon:daemon /usr/local/apache2/htdocs/*"

# ensure that the code is kept in sync with the message/answer files!
ssh crypto "/usr/local/apache2/htdocs/changeFlag.sh"

