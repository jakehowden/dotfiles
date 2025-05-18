#!/bin/bash

output=$(solaar show)
level=$(echo "$output" | awk '/G703/ {found=1} found && /Battery:/ {print $2; exit}')

if [[ "$level" > -1 ]]; then
  echo "$level  "
fi
