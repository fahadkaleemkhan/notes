#!/bin/bash

choices=$(dialog --checklist "Choose options:" 15 60 4 \
"task1" "Option 1" off \
"task2" "Option 2" off \
"task3" "Option 3" off \
2>&1 >/dev/tty)

clear
echo "Selected: $choices"
