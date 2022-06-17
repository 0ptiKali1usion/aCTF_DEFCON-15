#!/bin/bash
#
# $1 = filename to read from
#
if [[ $1 == "" ]]; then
  echo "Usage: $0 filename"
  exit
fi

if [[ -f $1 ]]; then
  numberOfLines=`wc -l $1`
  numberOfLines=`echo $numberOfLines | awk '{print $1}'`
  ((lineNumber = $RANDOM % $numberOfLines))
  if [[ $lineNumber -eq 0 ]]; then
    lineNumber=1
  fi
  head -n $lineNumber $1 | tail -n 1
else
  echo "File not found"
  exit
fi
