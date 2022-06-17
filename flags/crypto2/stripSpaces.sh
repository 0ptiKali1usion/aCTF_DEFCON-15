#!/bin/bash
read variable
echo $variable | sed 's/ //g'
