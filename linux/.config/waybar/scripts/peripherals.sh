#!/bin/bash

headsetcontrol=$(headsetcontrol -b)
solaar=$(solaar show)

headset=$(echo "$headsetcontrol" | grep "Level:" | awk '{print $2}' | sed 's/%//')
keyboard=$(echo "$solaar" | awk '/G915 TKL/ {found=1} found && /Battery:/ {print $2; exit}')
mouse=$(echo "$solaar" | awk '/G703/ {found=1} found && /Battery:/ {print $2; exit}')

output=""

if [[ "$headset" > -1 ]]; then
  output+="󰋋 ${headset}%  "
fi

if [[ "$keyboard" > -1 ]]; then
  output+="󰌌 ${keyboard}  "
fi

if [[ "$mouse" > -1 && "$mouse" != "unknown" ]]; then
  output+=" ${mouse}"
fi

echo "$output"
