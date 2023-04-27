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
