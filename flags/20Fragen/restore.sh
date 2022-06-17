#!/bin/bash
thisDir="/root/admin/flags/20Fragen"
flag=`ssh games "cat /usr/local/20Fragen/20Fragen_owner.txt"`
level=`ssh games "cat /usr/local/20Fragen/20Fragen_numberOfGuesses.txt"`

if [[ $level != "" ]]; then
  echo "Setting number of guesses to $level"
else
  echo "Reverting to 20 guesses"
  level="20"
fi

if [[ $flag != "" ]]; then
  echo "Setting flag to $flag"
else
  echo "Reverting flag to be held by dc949"
  flag="dc949"
fi

echo "Copying files"
scp $thisDir/20Fragen.sh $thisDir/getRandomPhrase.sh $thisDir/*.txt games:/usr/local/20Fragen/
ssh games "echo '$level' > /usr/local/20Fragen/20Fragen_numberOfGuesses.txt"
ssh games "echo '$flag' > /usr/local/20Fragen/20Fragen_owner.txt"

echo "Setting permissions"
ssh games "chmod 755 /usr/local/20Fragen/*.sh"
ssh games "chmod 644 /usr/local/20Fragen/*.txt"
ssh games "chown zf /usr/local/20Fragen/*"

