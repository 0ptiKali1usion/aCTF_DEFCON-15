#!/bin/bash
read x
read y
read z

if [[ $x == $y || $x == $y || $y == $z ]]; then
  echo "bad input"
  exit
fi

number=`echo $RANDOM % 3 | bc`
if [[ $number -eq 0 ]]; then
  ls $x 2> /dev/null
elif [[ $number -eq 1 ]]; then
  ls $y 2> /dev/null
elif [[ $number -eq 2 ]]; then
  ls $z 2> /dev/null
fi

