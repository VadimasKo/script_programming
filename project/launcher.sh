#!/bin/bash

create_project() {
  projects_dir=$1
  project_name=$2

  echo "project dir/name"
  echo $projects_dir $project_name

  echo "Creating new project $project_name..."

  while true; do
    echo "Enter module directory:"
    read module_dir
    echo "Enter module run command:"
    read module_cmd

    echo "$module_dir|$module_cmd" >> "$projects_dir/$project_name"
    
    echo "Add another module? (Y/N)"
    read continue    
    continue=$(echo "$continue" | tr '[:upper:]' '[:lower:]')
    if [[ "$continue" != "y" ]]; then break; fi
  done

  echo "Project $project_name created, you can modify config in $projects_dir/$project_name"
}
# LIST OF COMMANDS
help() {
  echo
  echo "Available Commands:"
  echo "-n project_name  [create new project] "
  echo "-h               [output available commands]"
  echo "-l               [list available projects]"
  echo "project_name     [run project]"
  echo
}
run_project() {
  projects_dir=$1
  project_name=$2
  project_location="$projects_dir/$project_name"

  if ! [ -f "$project_location" ]; then
    echo "Project $project_name does not exist"
    exit 1
  fi

  while read line; do
    IFS='|' read -r directory command <<< "$line"
    echo $directory $command
    alacritty -e sh -c "cd $directory; $command; exec $SHELL -i" &
  done < $project_location
}
run_project() {
  projects_dir=$1
  project_name=$2
  project_location="$projects_dir/$project_name"

  if ! [ -f "$project_location" ]; then
    echo "Project $project_name does not exist"
    exit 1
  fi

  while read line; do
    IFS='|' read -r directory command <<< "$line"
    echo $directory $command
    alacritty -e sh -c "cd $directory; $command; exec $SHELL -i" &
  done < $project_location
}
projects_dir='./projects'

# CREATE PROJECTS DIR IF IT DOESNT EXIST
mkdir -p $projects_dir

if [ "$1" == "-h" ]; then
  help
elif [ "$1" == "-n" ]; then
  create_project $projects_dir $2
elif [ "$1" == "-l" ]; then
  ls $projects_dir
else
  run_project $projects_dir $1
fi
