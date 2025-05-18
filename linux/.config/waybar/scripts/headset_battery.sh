#!/bin/bash

output=$(headsetcontrol -b)
level=$(echo "$output" | grep "Level:" | awk '{print $2}' | sed 's/%//')

if [[ "$level" > -1 ]]; then
  echo "$level%  󰋋"
fi
