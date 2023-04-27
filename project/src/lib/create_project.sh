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
