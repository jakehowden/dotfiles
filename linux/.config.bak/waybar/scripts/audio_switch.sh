#!/bin/bash

# Define exact sink names
HEADPHONES="alsa_output.usb-Corsair_CORSAIR_HS70_Pro_Wireless_Gaming_Headset-00.analog-stereo"
SPEAKERS="alsa_output.usb-Generic_USB2.0_Device_20130100ph0-00.analog-stereo"

# Get current default sink
DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Determine which to switch to
if [[ "$DEFAULT_SINK" == "$HEADPHONES" ]]; then
  NEW_SINK="$SPEAKERS"
  ICON=" 󰓃 "
else
  NEW_SINK="$HEADPHONES"
  ICON=" 󰋋 "
fi

# Switch sink
pactl set-default-sink "$NEW_SINK"

# Move all audio streams to new sink
for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
  pactl move-sink-input "$INPUT" "$NEW_SINK"
done

# Output for Waybar
echo $ICON

if [ ! -z "$WAYBAR_PID" ]; then
  kill -SIGUSR1 "$WAYBAR_PID"
fi
