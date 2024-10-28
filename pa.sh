#!/bin/bash


if [[ $1 != -* ]]; then
  ps aux | grep --color $1
  exit 1
fi

if [[ $1 == "-m" ]]; then
  ps aux | grep --color $2;
  ps aux | grep $2 | awk '{sum += $6} END {print sum/1024/1024 " GB"}'
  exit 1
fi

exit 0
