#!/bin/bash
#shell script to reverse a inputed string and show it.

read string
len=`echo -n $string |wc -c`
while test $len -gt 0; do
  rev=$rev`echo $string |cut -c $len`
  len=`expr $len - 1`
done
echo $rev
