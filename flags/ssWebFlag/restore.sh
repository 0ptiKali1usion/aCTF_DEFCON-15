#!/bin/bash
thisDir="/root/admin/flags/ssWebFlag"
flag=`ssh services1 "cat /var/www/htdocs/flag.txt"`

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
scp $thisDir/*.php services1:/var/www/htdocs/
ssh services1 "echo '$flag' > /var/www/htdocs/flag.txt"

echo "Setting permissions"
ssh services1 "chown daemon:daemon /var/www/htdocs/*"
ssh services1 "chmod 400 /var/www/htdocs/flag.txt"
ssh services1 "ln -sf admin.php index.php"
