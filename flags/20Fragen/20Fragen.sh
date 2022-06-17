#!/bin/bash
currentPath="/usr/local/20Fragen/"

# $1 = filename, $2 = numberOfSlashes
function hasNSlashes {
  # this is off by 2 because the last slash doesn't preceed a directory and the \n char
  offByTwo=`echo "$1" | sed 's/\w//g' | sed 's/\.//g' | sed 's/\-//g' | wc -c`
  if [[ `echo "$offByTwo - 2" | bc` -eq "$2" ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

# $1 = filename, $2 = guess
function isTextInFilename {
  if [[ $1 == "$2"* ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

# $1 = filename, $2 = searchValue
function isFileType {
  x=`file $1`
  if [[ $x = *"$2"* ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

# $1 = filename, $2 = userType, $3 = permission
function isPermissions { 
  x=`ls -l /etc/passwd`
  if [[ $2 == "user" ]]; then
    if [[ ${x:1:3} == *"$3"* ]]; then
      echo "Yes"
    else
      echo "No"
    fi
  elif [[ $2 == "group" ]]; then
    if [[ ${x:4:3} == *"$3"* ]]; then
      echo "Yes"
    else
      echo "No"
    fi
  elif [[ $2 == "other" ]]; then
    if [[ ${x:7:3} == *"$3"* ]]; then
      echo "Yes"
    else
      echo "No"
    fi
  fi
}

# $1 = filename, $2 = owner
function isOwner {
  x=`ls -l $1 | awk '{print $3}'`
  if [[ $x == $2 ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

# $1 = filename, $2 = owner
function isGroup {
  x=`ls -l $1 | awk '{print $4}'`
  if [[ $x == $2 ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

# $1 = filename, $pos, $searchString
function isNthLetter {
  x=`basename $1`
  pos=`echo "$2 - 1" | bc`
  for i in `seq 1 $2`; do
    questionMarks="${questionMarks}?"
  done

  if [[ $x == $questionMarks"$3"* ]]; then
    echo "Yes"
  else
    echo "No"
  fi
  questionMarks=""
}

function printMenu {
  echo "01 - Guess number of directories deep..."
  echo "02 - Guess path name..."
  echo "03 - Guess Nth letter of filename..."
  echo "04 - Is this an ASCII text file?"
  echo "05 - Is this an ELF file?"
  echo "06 - Is this a shell script?"
  echo "07 - Is this an image file?"
  echo "08 - Is this a WAVE audio file?"
  echo "09 - Is this file compressed data (according to the file command)?"
  echo "10 - Is this file user readable?"
  echo "11 - Is this file user writable?"
  echo "12 - Is this file user executable?"
  echo "13 - Is this file group readable?"
  echo "14 - Is this file group writable?"
  echo "15 - Is this file group executable?"
  echo "16 - Is this file world readable?"
  echo "17 - Is this file world writable?"
  echo "18 - Is this file world executable?"
  echo "19 - Is this file owned by root?"
  echo "20 - Is this file owned by apache?"
  echo "21 - Is this file owned by the group root?"
  echo "22 - Is this file owned by the group smmsp?"
  echo "23 - Is this file owned by the group shadow?"
  echo "24 - Is this file owned by the group bin?"
  echo "25 - Is this file owned by the group utmp?"
  echo "26 - Is this file owned by the group mail?"
  echo "27 - Is this file owned by the group tty?"
  echo "28 - Is this file owned by the group slocate?"
}

# $1 = filename; $2 = choice
function doGuess {
  if [[ $2 == "1" || $2 == "01" ]]; then
    echo "How many directories deep so you think this file is? (i.e. /tmp/mysql.sock == 1)"
    read -e tmp
    tmp=`echo $tmp | sed 's/\r//g'` # stupid newline issue!
    hasNSlashes $1 "$tmp"
  elif [[ $2 == "2" || $2 == "02" ]]; then
    echo "Enter path you'd like to guess:"
    read -e tmp
    tmp=`echo $tmp | sed 's/\r//g'` # stupid newline issue!
    isTextInFilename $1 $tmp
  elif [[ $2 == "3" || $2 == "03" ]]; then
    echo "What position do you want to examine? (i.e. the a in /bin/bash == 1)"
    read -e tmp
    pos=`echo $tmp | sed 's/\r//g'` # stupid newline issue!
    echo "What letter do you think is in that position?"
    read -e tmp
    letter=`echo $tmp | sed 's/\r//g'` # stupid newline issue!
    isNthLetter $1 $pos $letter
  elif [[ $2 == "4" || $2 == "04" ]]; then
    isFileType $1 "ASCII"
  elif [[ $2 == "5" || $2 == "05" ]]; then
    isFileType $1 "ELF"
  elif [[ $2 == "6" || $2 == "06" ]]; then
    isFileType $1 "shell script"
  elif [[ $2 == "7" || $2 == "07" ]]; then
    isFileType $1 "image data"
  elif [[ $2 == "8" || $2 == "08" ]]; then
    isFileType $1 "WAVE audio"
  elif [[ $2 == "9" || $2 == "09" ]]; then
    isFileType $1 "compressed data"
  elif [[ $2 == "10" ]]; then
    isPermissions $1 "user" "r"
  elif [[ $2 == "11" ]]; then
    isPermissions $1 "user" "w"
  elif [[ $2 == "12" ]]; then
    isPermissions $1 "user" "x"
  elif [[ $2 == "13" ]]; then
    isPermissions $1 "group" "r"
  elif [[ $2 == "14" ]]; then
    isPermissions $1 "group" "w"
  elif [[ $2 == "15" ]]; then
    isPermissions $1 "group" "x"
  elif [[ $2 == "16" ]]; then
    isPermissions $1 "other" "r"
  elif [[ $2 == "17" ]]; then
    isPermissions $1 "other" "w"
  elif [[ $2 == "18" ]]; then
    isPermissions $1 "other" "x"
  elif [[ $2 == "19" ]]; then
    isOwner $1 "root"
  elif [[ $2 == "20" ]]; then
    isOwner $1 "apache"
  elif [[ $2 == "21" ]]; then
    isGroup $1 "root"
  elif [[ $2 == "22" ]]; then
    isGroup $1 "smmsp"
  elif [[ $2 == "23" ]]; then
    isGroup $1 "shadow"
  elif [[ $2 == "24" ]]; then
    isGroup $1 "bin"
  elif [[ $2 == "25" ]]; then
    isGroup $1 "utmp"
  elif [[ $2 == "26" ]]; then
    isGroup $1 "mail"
  elif [[ $2 == "27" ]]; then
    isGroup $1 "tty"
  elif [[ $2 == "28" ]]; then
    isGroup $1 "slocate"
  else
    tmp=`echo $2 | sed 's/\r//g'` # stupid newline issue!
    echo "Invalid menu option ($tmp), you just burt a guess."
  fi
}


# let everyone (including the scorekeeper) know who pwns!
teamName=`cat ${currentPath}20Fragen_owner.txt`
echo "This service is currently owned by: $teamName"

# pick random file from a text file (this includes the full path)
filename=`${currentPath}getRandomPhrase.sh ${currentPath}20Fragen_fileList.txt`
if [[ $? -ne 0 ]]; then
  echo "File has been deleted, please try again"
  exit
fi

# read in file which tells us the number of guesses are allowed
numberOfGuesses=`cat ${currentPath}20Fragen_numberOfGuesses.txt`
if [[ $numberOfGuesses -lt 1 ]]; then
  numberOfGuesses=1
fi

echo "Zwanzig Fragen"
echo ""
printMenu

# start loop 1 thru XX
for i in `seq 1 $numberOfGuesses`; do
  echo You are on guess $i of $numberOfGuesses
  echo ""
  echo -n "Which question do you want to ask? => "
  read choice
  length=`echo $choice | wc -c`
  length=`echo "$length-2" | bc`
  choice=`echo $choice | cut -b 0-$length`
  if [[ $choice == "quit" ]]; then
    exit
  fi
  printMenu
  echo ""
  doGuess "$filename" "$choice"
done

echo -n "What is the filename (with path)? "
read guess
guess=`echo $guess | sed 's/\r//g'` # stupid newline issue!
if [[ $guess == $filename ]]; then
  numberOfGuesses=$((numberOfGuesses-1))
  echo $numberOfGuesses > ${currentPath}20Fragen_numberOfGuesses.txt
  echo "Please enter your team name"
  read teamName
  echo "$teamName" > ${currentPath}20Fragen_owner.txt
else
  echo "Wrong.  Answer was $filename"  
fi
