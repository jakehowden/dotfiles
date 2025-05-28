#!/bin/bash

HEADPHONES="alsa_output.usb-Corsair_CORSAIR_HS70_Pro_Wireless_Gaming_Headset-00.analog-stereo"
SPEAKERS="alsa_output.usb-Generic_USB2.0_Device_20130100ph0-00.analog-stereo"

available_sinks=$(pactl list short sinks | awk '{print $2}')

headphones_found=false
speakers_found=false

for sink in $available_sinks; do
  if [[ "$sink" == "$HEADPHONES" ]]; then
    headphones_found=true
  fi
  if [[ "$sink" == "$SPEAKERS" ]]; then
    speakers_found=true
  fi
done

if $headphones_found || $speakers_found; then
  DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

  if [[ "$DEFAULT_SINK" == "$HEADPHONES" ]]; then
    NEW_SINK="$SPEAKERS"
    ICON=" 󰓃 "
  else
    NEW_SINK="$HEADPHONES"
    ICON=" 󰋋 "
  fi

  pactl set-default-sink "$NEW_SINK"

  for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$INPUT" "$NEW_SINK"
  done

  echo $ICON

  if [ ! -z "$WAYBAR_PID" ]; then
    kill -SIGUSR1 "$WAYBAR_PID"
  fi
fi
