#!/bin/bash
# get the optional username parameter
if [ $# -eq 1 ]; then
  username=$1
else
  username=""
fi

# get the current date and time
date=$(date +%Y-%m-%d)
time=$(date +%H-%M-%S)

# read processes
processes=()
if [ -z "$username" ]; then
  while read -r user comm pid cpu mem; do processes+=("$user $date $time $comm $pid $cpu $mem")
  done < <(ps -e -o user,comm,pid,\%cpu,\%mem | tail -n +2)
else 
  while read -r comm pid cpu mem; do processes+=("$date $time $comm $pid $cpu $mem")
  done < <(ps -u "$username" -o comm,pid,\%cpu,\%mem | tail -n +2)
fi 

# create a directops -ry for the log files
log_dir="logs"
mkdir -p "$log_dir"
echo -e "\e[33mLog file directory: $log_dir\e[0m"

if [ -z "$username" ]; then
# create key-value array
  declare -A user_processes
  for process in "${processes[@]}"; do
    user=$(echo "$process" | awk '{print $1}')
    user_processes["$user"]+="$process"$'\n'
  done

  # Create log file for each user
  total_count=0
  for user in "${!user_processes[@]}"; do
    file_count=0
    log_file="$log_dir/$user-process-log-$date-$time.log"
    touch "$log_file"
    echo "date time name pid cpu mem" > "$log_file"

    mapfile -t processes_array <<< "${user_processes[$user]}"
    for process in "${processes_array[@]}"; do
      date=$(echo "$process" | awk '{print $2}')
      time=$(echo "$process" | awk '{print $3}')
      comm=$(echo "$process" | awk '{print $4}')
      pid=$(echo "$process" | awk '{print $5}')
      cpu=$(echo "$process" | awk '{print $6}')
      mem=$(echo "$process" | awk '{print $7}')
      echo "$date $time $comm $pid $cpu $mem" >> "$log_file"

      ((file_count++))
    done

    ((total_count+=file_count))
    echo -e "$log_file" length "\e[33m$file_count\e[0m"
  done

echo -e "\e[33mTotal length: $total_count\e[0m"
else 
  # create user log file
  log_file="$log_dir/$username-process-log-$date-$time.log"
  touch "$log_file"
  echo "date time name pid cpu mem" >> "$log_file"

  # printout the processes
  for process in "${processes[@]}"; do
    echo "$process" >> "$log_file"
  done
  cat "$log_file"
fi

# # pause the script and wait for user input
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'

# # delete the log files and directory
rm -rf "$log_dir"
