#!/bin/bash
read variable
variable=`echo $variable | ./stripSpaces.sh | ./toUpper.sh`

i=0;
len=${#variable}
while [[ $i -lt $len ]] ; do
  x=$(($i % 5))
  if [[ $x -eq 0 ]]; then
    column0=${column0}${variable:i:1}
  fi
  if [[ $x -eq 1 ]]; then
    column1=${column1}${variable:i:1}
  fi
  if [[ $x -eq 2 ]]; then
    column2=${column2}${variable:i:1}
  fi
  if [[ $x -eq 3 ]]; then
    column3=${column3}${variable:i:1}
  fi
  if [[ $x -eq 4 ]]; then
    column4=${column4}${variable:i:1}
  fi
  i=$((i+1))
done

if [[ ${#column1} -lt ${#column0} ]]; then
  column1=${column1}X
fi
if [[ ${#column2} -lt ${#column1} ]]; then
  column2=${column2}X
fi
if [[ ${#column3} -lt ${#column2} ]]; then
  column3=${column3}X
fi
if [[ ${#column4} -lt ${#column3} ]]; then
  column4=${column4}X
fi

newString=`echo ${column0}${column1}${column2}${column3}${column4}`
i=0;
len=${#newString}
while [[ $i -lt $len ]] ; do
  x=$(($i % 5))
  echo -n ${newString:i:1}
  if [[ $x -eq "4" ]]; then
    echo -n " "
  fi

  i=$((i+1))
done

echo ""
