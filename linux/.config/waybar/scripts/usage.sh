#!/bin/bash

cpu_percent=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

free=$(free -m | awk '/Mem:/ {print $4}')
total=$(free -m | awk '/Mem:/ {print $2}')
used_percent=$((100 * (total - free) / total))

disk_percent=$(df -h / | awk '/\// {print $5}' | sed 's/%//')

echo "  ${cpu_percent}%    ${used_percent}%  󰋊 ${disk_percent}% "
