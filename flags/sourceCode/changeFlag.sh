#!/bin/bash
###
# This will change the secret word that needs to be input
# and update the answer file as well.
###
#
# level.txt  = the file that determines what level we're on!
# answer     = the file that contains what the contestant must enter
# message    = the message that'll be inserted into theCode.c
# theCode.c  = the code which will be given out to the contestant
#

# figure out the level, and clear out the current message and answer
level=`cat level.txt`
if [[ $level == "" ]]; then
  echo "0" > level.txt;
  level=0;
fi
echo "" > answer
echo "" > message

if [[ $level -eq 0 ]]; then
  echo -n "OMFG, these dc949 guys are assholes, they're making " > message
  echo -n "me type in an assload of text just to capture a simple " >> message
  echo -n "little flag dealing with source code.  Adam has just " >> message
  echo -n "gone too far this time.  Let the plotting begin.  " >> message
  echo "--Brutus" >> message
  echo -n "OMFG, these dc949 guys are assholes, they're making " > answer
  echo -n "me type in an assload of text just to capture a simple " >> answer
  echo -n "little flag dealing with source code.  Adam has just " >> answer
  echo -n "gone too far this time.  Let the plotting begin.  " >> answer
  echo "--Brutus" >> answer
fi

if [[ "$level" -eq 1 ]]; then
  echo 'password' > message
  echo 'password' > answer
fi

if [[ "$level" -eq 2 ]]; then
  echo 'have you written a script yet?' > message
  echo 'have you written a script yet?' > answer
fi

if [[ "$level" -eq 3 ]]; then
  echo 'Someone is going to script this and just own the shit out of you' > message
  echo 'Someone is going to script this and just own the shit out of you' > answer
fi

if [[ "$level" -eq 4 ]]; then
  echo 'Adam says scripting is FTW' > message
  echo 'Adam says scripting is FTW' > answer
fi

if [[ "$level" -eq 5 ]]; then
  echo 'How fast are you at capturing this flag?' > message
  echo 'How fast are you at capturing this flag?' > answer
fi

if [[ "$level" -eq 6 ]]; then
  echo 'Dude, write a script!' > message
  echo 'Dude, write a script!' > answer
fi

if [[ "$level" -eq 7 ]]; then
  echo 'No seriously, you should not even be reading this text' > message
  echo 'No seriously, you should not even be reading this text' > answer
fi

if [[ "$level" -eq 8 ]]; then
  echo 'Your script should be reading this' > message
  echo 'Your script should be reading this' > answer
fi

if [[ "$level" -eq 9 ]]; then
  echo 'You must be fucking kidding me!' > message
  echo 'You must be fucking kidding me!' > answer
fi

if [[ "$level" -eq 10 ]]; then
  echo 'You are still here?' > message
  echo 'You are still here?' > answer
fi

if [[ "$level" -eq 11 ]]; then
  echo 'You are going to lose for sure' > message
  echo 'You are going to lose for sure' > answer
fi

if [[ "$level" -eq 12 ]]; then
  echo 'Well, I hope you are at least timing the capture right...' > message
  echo 'Well, I hope you are at least timing the capture right...' > answer
fi

if [[ "$level" -eq 13 ]]; then
  echo 'Can your script handle a message that is...' > message
  echo 'two lines?' >> message
  echo 'Can your script handle a message that is...' > answer
  echo 'two lines?' >> answer
fi

if [[ "$level" -eq 14 ]]; then
  echo 'Can your script handle a message that is... ' > message
  echo 'three ' >> message
  echo 'lines?' >> message
  echo 'Can your script handle a message that is... ' > answer
  echo 'three ' >> answer
  echo 'lines?' >> answer
fi

if [[ "$level" -eq 15 ]]; then
  echo 'Can your script handle a message that is... ' > message
  echo 'three ' >> message
  echo 'lines?  OK, enought of that, time for something new' >> message
  echo 'Can your script handle a message that is... ' > answer
  echo 'three ' >> answer
  echo 'lines?  OK, enought of that, time for something new' >> answer
fi

if [[ "$level" -eq 16 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo 'The answer is: boogie' >> message
  echo 'boogie' > answer
fi

if [[ "$level" -eq 17 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo 'The answer is: Toshiba' >> message
  echo 'Toshiba' > answer
fi

if [[ "$level" -eq 18 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo 'The answer is: to bribe me' >> message
  echo 'to bribe me' > answer
fi

if [[ "$level" -eq 19 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo 'The answer is: to be determined' >> message
  echo 'to be determined' > answer
fi

if [[ "$level" -eq 20 ]]; then
  echo "What is Adams favorite kind of music?" > message
  echo "The answer is: out there (no not literally \"out there\" numb nuts)" >> message
  echo "Happy Hardcore" > answer
fi

if [[ "$level" -eq 21 ]]; then
  echo "What is CP's favorite place to eat?" > message
  echo "The answer is obvious" >> message
  echo "Chipotle" > answer
fi

if [[ "$level" -eq 22 ]]; then
  echo "DC14 program, fill in the blank: ORGANIZED BY ***** & DC949" > message
  echo "The answer is in all caps" >> message
  echo "VYRUS" > answer
fi

if [[ "$level" -eq 23 ]]; then
  echo "4+7" > message
  echo "11" > answer
fi

if [[ "$level" -eq 24 ]]; then
  echo "cos(81) rounded to the thousandth place." > message
  echo "0.156" > answer
fi

if [[ "$level" -eq 25 ]]; then
  echo "8!" > message
  echo "40320" > answer
fi

if [[ "$level" -eq 26 ]]; then
  echo "8!" > message
  echo "40320" > answer
fi

if [[ "$level" -eq 26 ]]; then
  echo "80!" > message
  echo "93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000" > answer
fi

if [[ "$level" -eq 28 ]]; then
  echo "(cosine(4)/sine(73)*arctangent(99.7))/bessel function(3*4+2-0,32768/8/4/2/1)" > message
  echo "Hint: bc" > message
  echo "54.69594706244970126910" > answer
fi

if [[ "$level" -eq 29 ]]; then
  echo 'Oh shit, a REAL script breaker!' > message
  echo 'The answer is: printf("%c%c%c%c%c", 65, 83, 99, 105, 73);' >> message
  echo 'ASciI' > answer
fi

if [[ "$level" -eq 30 ]]; then
  echo 'Oh shit, a REAL script breaker!' > message
  echo 'The answer is: document.write("\u0044\u0043\u0039\u0034\u0039");' >> message
  echo 'DC949' > answer
fi

if [[ "$level" -eq 31 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo "The answer is: Egyption sun God" >> message
  echo "Re" > answer
fi

if [[ "$level" -eq 32 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo "The answer is: Life is like a riddle and I'm really.." >> message
  echo 'stumped' > answer
fi

if [[ "$level" -eq 33 ]]; then
  echo 'Oh shit, a script breaker!' > message
  echo "The answer is: Wife of Amen, mother of Khons" >> message
  echo "Mut" > answer
fi

if [[ $level -gt 34 ]]; then
  echo -n 'By now you obviously have our MO down ' > message
  echo -n "which means it's time for something a little more interesting. " >> message
  echo 'To capture type the answer (single word, no shouting):' >> message
  echo "I have four spheres" >> message
  echo "but I am not round" >> message
  echo "I am in a prison of water" >> message
  echo "but I do not drown" >> message
  echo "What am I?" >> message
  echo 'brain' > answer
fi

if [[ $level -eq 35 ]]; then
  echo "Please use proper English and do not yell..." >> message
  echo "In marble walls as white as milk," >> message
  echo "Lined with a skin as soft as silk," >> message
  echo "Within a fountain crystal clear," >> message
  echo "A golden apple doth appear." >> message
  echo "No doors there are to this stronghold," >> message
  echo "Yet thieves break in and steal the gold." >> message
  echo "An egg" > answer
fi

if [[ `cat answer` == "" ]]; then
  echo "We ran out of ideas, flag is disabled" > message
  echo "The @nswer i$ impossible to guess" > answer
fi

./encoder message < sds.c > theCode.c
level=`echo "$level + 1" | bc`
echo $level > level.txt
