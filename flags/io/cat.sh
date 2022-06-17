#!/bin/bash
read x
echo "cat $x 2> /dev/null" >> /tmp/cat.sh
/bin/sh /tmp/cat.sh
rm /tmp/cat.sh

