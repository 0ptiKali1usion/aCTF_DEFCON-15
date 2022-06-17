#!/bin/bash
currentPath="/usr/local/20Fragen/"

# $1 = filename, $2 = numberOfSlashes
function hasNSlashes {
  offByOne=`echo "$1" | sed 's/\w//g' | wc -c`
  if [[ `echo "$offByOne - 1" | bc` -eq "$2" ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

# $1 = filename, $2 = searchValue
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

# $1 = filename, $searchString
function isFirstLetter {
  x=`basename $1`
  if [[ $x == "$2"* ]]; then
    echo "Yes"
  else
    echo "No"
  fi
}

function printMenu {
  echo "01 - Is this file in /usr?"
  echo "02 - Is this file in /bin?"
  echo "03 - Is this file in /etc?"
  echo "04 - Is this file in /var?"
  echo "05 - Is this file in /sbin?"
  echo "06 - Is this file in /lib?"
  echo "07 - Is this file in /dev?"
  echo "08 - Is this file in /boot?"
  echo "09 - Is this file in /proc?"
  echo "10 - Is this file in /opt?"
  echo "11 - Is this file in /usr/share?"
  echo "12 - Is this file in /usr/bin?"
  echo "13 - Is this file in /usr/sbin?"
  echo "14 - Is this file in /usr/src?"
  echo "15 - Is this an ASCII text file?"
  echo "16 - Is this an ELF file?"
  echo "17 - Is this a shell script?"
  echo "18 - Is this an image file?"
  echo "19 - Is this a WAVE audio file?"
  echo "20 - Is this file compressed data (according to the file command)?"
  echo "21 - Is this file user readable?"
  echo "22 - Is this file user writable?"
  echo "23 - Is this file user executable?"
  echo "24 - Is this file group readable?"
  echo "25 - Is this file group writable?"
  echo "26 - Is this file group executable?"
  echo "27 - Is this file world readable?"
  echo "28 - Is this file world writable?"
  echo "29 - Is this file world executable?"
  echo "30 - Is this file owned by root?"
  echo "31 - Is this file owned by apache?"
  echo "32 - Is this file owned by the group root?"
  echo "33 - Is this file owned by the group smmsp?"
  echo "34 - Is this file owned by the group shadow?"
  echo "35 - Is this file owned by the group bin?"
  echo "36 - Is this file owned by the group utmp?"
  echo "37 - Is this file owned by the group mail?"
  echo "38 - Is this file owned by the group tty?"
  echo "39 - Is this file owned by the group slocate?"
  echo "40 - Does the filename start with a?"
  echo "41 - Does the filename start with b?"
  echo "42 - Does the filename start with c?"
  echo "43 - Does the filename start with d?"
  echo "44 - Does the filename start with e?"
  echo "45 - Does the filename start with f?"
  echo "46 - Does the filename start with g?"
  echo "47 - Does the filename start with h?"
  echo "48 - Does the filename start with i?"
  echo "49 - Does the filename start with j?"
  echo "50 - Does the filename start with k?"
  echo "51 - Does the filename start with l?"
  echo "52 - Does the filename start with m?"
  echo "53 - Does the filename start with n?"
  echo "54 - Does the filename start with o?"
  echo "55 - Does the filename start with p?"
  echo "56 - Does the filename start with q?"
  echo "57 - Does the filename start with r?"
  echo "58 - Does the filename start with s?"
  echo "59 - Does the filename start with t?"
  echo "60 - Does the filename start with u?"
  echo "61 - Does the filename start with v?"
  echo "62 - Does the filename start with w?"
  echo "63 - Does the filename start with x?"
  echo "64 - Does the filename start with y?"
  echo "65 - Does the filename start with z?"
  echo "66 - Is in root filesystem?"
  echo "67 - Is one directory deep?"
  echo "68 - Is two directories deep?"
  echo "69 - Is three directories deep?"
  echo "70 - Is four directories deep?"
  echo "71 - Is five directories deep?"
  echo "72 - Is six directories deep?"
}

# $1 = filename; $2 = choice
function doGuess {
  if [[ $2 == "1" || $2 == "01" ]]; then
    isTextInFilename $1 "/usr"
  elif [[ $2 == "2" || $2 == "02" ]]; then
    isTextInFilename $1 "/bin"
  elif [[ $2 == "3" || $2 == "03" ]]; then
    isTextInFilename $1 "/etc"
  elif [[ $2 == "4" || $2 == "04" ]]; then
    isTextInFilename $1 "/var"
  elif [[ $2 == "5" || $2 == "05" ]]; then
    isTextInFilename $1 "/sbin"
  elif [[ $2 == "6" || $2 == "06" ]]; then
    isTextInFilename $1 "/lib"
  elif [[ $2 == "7" || $2 == "07" ]]; then
    isTextInFilename $1 "/dev"
  elif [[ $2 == "8" || $2 == "08" ]]; then
    isTextInFilename $1 "/boot"
  elif [[ $2 == "9" || $2 == "09" ]]; then
    isTextInFilename $1 "/proc"
  elif [[ $2 == "10" ]]; then
    isTextInFilename $1 "/opt"
  elif [[ $2 == "11" ]]; then
    isTextInFilename $1 "/usr/share"
  elif [[ $2 == "12" ]]; then
    isTextInFilename $1 "/usr/bin"
  elif [[ $2 == "13" ]]; then
    isTextInFilename $1 "/usr/sbin"
  elif [[ $2 == "14" ]]; then
    isTextInFilename $1 "/usr/src"
  elif [[ $2 == "15" ]]; then
    isFileType $1 "ASCII"
  elif [[ $2 == "16" ]]; then
    isFileType $1 "ELF"
  elif [[ $2 == "17" ]]; then
    isFileType $1 "shell script"
  elif [[ $2 == "18" ]]; then
    isFileType $1 "image data"
  elif [[ $2 == "19" ]]; then
    isFileType $1 "WAVE audio"
  elif [[ $2 == "20" ]]; then
    isFileType $1 "compressed data"
  elif [[ $2 == "21" ]]; then
    isPermissions $1 "user" "r"
  elif [[ $2 == "22" ]]; then
    isPermissions $1 "user" "w"
  elif [[ $2 == "23" ]]; then
    isPermissions $1 "user" "x"
  elif [[ $2 == "24" ]]; then
    isPermissions $1 "group" "r"
  elif [[ $2 == "25" ]]; then
    isPermissions $1 "group" "w"
  elif [[ $2 == "26" ]]; then
    isPermissions $1 "group" "x"
  elif [[ $2 == "27" ]]; then
    isPermissions $1 "other" "r"
  elif [[ $2 == "28" ]]; then
    isPermissions $1 "other" "w"
  elif [[ $2 == "29" ]]; then
    isPermissions $1 "other" "x"
  elif [[ $2 == "30" ]]; then
    isOwner $1 "root"
  elif [[ $2 == "31" ]]; then
    isOwner $1 "apache"
  elif [[ $2 == "32" ]]; then
    isGroup $1 "root"
  elif [[ $2 == "33" ]]; then
    isGroup $1 "smmsp"
  elif [[ $2 == "34" ]]; then
    isGroup $1 "shadow"
  elif [[ $2 == "35" ]]; then
    isGroup $1 "bin"
  elif [[ $2 == "36" ]]; then
    isGroup $1 "utmp"
  elif [[ $2 == "37" ]]; then
    isGroup $1 "mail"
  elif [[ $2 == "38" ]]; then
    isGroup $1 "tty"
  elif [[ $2 == "39" ]]; then
    isGroup $1 "slocate"
  elif [[ $2 == "40" ]]; then
    isFirstLetter $1 "a"
  elif [[ $2 == "41" ]]; then
    isFirstLetter $1 "b"
  elif [[ $2 == "42" ]]; then
    isFirstLetter $1 "c"
  elif [[ $2 == "43" ]]; then
    isFirstLetter $1 "d"
  elif [[ $2 == "44" ]]; then
    isFirstLetter $1 "e"
  elif [[ $2 == "45" ]]; then
    isFirstLetter $1 "f"
  elif [[ $2 == "46" ]]; then
    isFirstLetter $1 "g"
  elif [[ $2 == "47" ]]; then
    isFirstLetter $1 "h"
  elif [[ $2 == "48" ]]; then
    isFirstLetter $1 "i"
  elif [[ $2 == "49" ]]; then
    isFirstLetter $1 "j"
  elif [[ $2 == "50" ]]; then
    isFirstLetter $1 "k"
  elif [[ $2 == "51" ]]; then
    isFirstLetter $1 "l"
  elif [[ $2 == "52" ]]; then
    isFirstLetter $1 "m"
  elif [[ $2 == "53" ]]; then
    isFirstLetter $1 "n"
  elif [[ $2 == "54" ]]; then
    isFirstLetter $1 "o"
  elif [[ $2 == "55" ]]; then
    isFirstLetter $1 "p"
  elif [[ $2 == "56" ]]; then
    isFirstLetter $1 "q"
  elif [[ $2 == "57" ]]; then
    isFirstLetter $1 "r"
  elif [[ $2 == "58" ]]; then
    isFirstLetter $1 "s"
  elif [[ $2 == "59" ]]; then
    isFirstLetter $1 "t"
  elif [[ $2 == "60" ]]; then
    isFirstLetter $1 "u"
  elif [[ $2 == "61" ]]; then
    isFirstLetter $1 "v"
  elif [[ $2 == "62" ]]; then
    isFirstLetter $1 "w"
  elif [[ $2 == "63" ]]; then
    isFirstLetter $1 "x"
  elif [[ $2 == "64" ]]; then
    isFirstLetter $1 "y"
  elif [[ $2 == "65" ]]; then
    isFirstLetter $1 "z"
  elif [[ $2 == "66" ]]; then
    hasNSlashes $1 "1"
  elif [[ $2 == "67" ]]; then
    hasNSlashes $1 "2"
  elif [[ $2 == "68" ]]; then
    hasNSlashes $1 "3"
  elif [[ $2 == "69" ]]; then
    hasNSlashes $1 "4"
  elif [[ $2 == "70" ]]; then
    hasNSlashes $1 "5"
  elif [[ $2 == "71" ]]; then
    hasNSlashes $1 "6"
  elif [[ $2 == "72" ]]; then
    hasNSlashes $1 "7"
  else
    echo "Invalid menu option ($2), you just burt a guess."
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
if [[ $guess == $filename ]]; then
  numberOfGuesses=$((numberOfGuesses-1))
  echo $numberOfGuesses > ${currentPath}20Fragen_numberOfGuesses.txt
  echo "Please enter your team name"
  read teamName
  echo "$teamName" > ${currentPath}20Fragen_owner.txt
else
  echo "Wrong.  Answer was $filename"  
fi
