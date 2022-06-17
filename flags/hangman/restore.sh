#!/bin/bash
thisDir="/root/admin/flags/hangman"
flag=`ssh games "cat /var/www/htdocs/flag.txt"`
level=`ssh games "cat /var/www/htdocs/count.txt"`

if [[ $level != "" ]]; then
  echo "Setting level to $level"
else
  echo "Reverting to level 1"
  level="1"
fi

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
scp $thisDir/*.php $thisDir/*.png games:/var/www/htdocs/
ssh games "echo '$level' > /var/www/htdocs/count.txt"
ssh games "echo '$flag' > /var/www/htdocs/flag.txt"

echo "Setting permissions"
ssh games "chown nobody:nobody /var/www/htdocs/*"

echo "Creating symbolic link"
ssh games "ln -sf /var/www/htdocs/hangman.php /var/www/htdocs/index.php"
