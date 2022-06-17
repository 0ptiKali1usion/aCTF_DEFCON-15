#!/bin/bash
thisDir="/root/admin/flags/blackjack"
flag=`ssh games "cat /usr/local/blackjack/flag.txt"`
level=`ssh games "cat /usr/local/blackjack/level.txt"`

if [[ $level != "" ]]; then
  echo "Setting number of guesses to $level"
else
  echo "Reverting to 7 rounds to win"
  level="7"
fi

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
scp $thisDir/blackjack* $thisDir/cards.* $thisDir/Makefile games:/usr/local/blackjack/
ssh games "echo '$level' > /usr/local/blackjack/level.txt"
ssh games "echo '$flag' > /usr/local/blackjack/flag.txt"

echo "Setting permissions"
ssh games 'chmod 755 /usr/local/blackjack/blackjack{,.sh} '
ssh games "chmod 644 /usr/local/blackjack/*.txt"
ssh games "chown bj /usr/local/blackjack/*"

