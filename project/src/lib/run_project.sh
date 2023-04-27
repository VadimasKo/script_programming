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
