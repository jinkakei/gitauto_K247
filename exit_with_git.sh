#!/bin/bash

ruby test.rb

echo "exit?(yes = 0): "; read ans
if test ${ans} -eq 0
then
  echo "good-bye"
  \exit
else
  echo "donot exit"
fi



