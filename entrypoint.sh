#!/bin/bash
/crashplan/crashplan/bin/CrashPlanEngine start &> /dev/null &
sleep 10
bash /crashplan/linker.sh 2> /dev/null
ui_info="nill"

# Tell the user which id to use to connect to the server
while [[ "$ui_info" == "nill"  ]]; do
  if [[ -f /var/lib/crashplan/.ui_info ]]; then
    ui_info=$(cat /var/lib/crashplan/.ui_info | sed -r 's/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\b/RockStor-IP/' 2> /dev/null )
  fi
  sleep 1
done

crash_pid () {
  PID=$(ps aux | grep CrashPlanService | egrep -v "grep" | awk '{ print $2 }')
  if [[ -n $PID ]]; then
    return 0
  else
    return 1
  fi
}

crash_pid
# Some cute output
echo "================"
echo "Container written by Joshi Friberg"
echo "Crashplan is running with pid $PID.."
echo "Enter these parameters to /var/lib/crashplan/.ui_info, change 'RockStor-IP' to your 'RockStor-IP'"
echo "$ui_info"
echo "Start time was: $(date)"
while crash_pid; do
  sleep 60
  echo -ne "Still running:  $(date)\r"
done
