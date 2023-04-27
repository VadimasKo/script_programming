#!/bin/bash
output_file="launcher.sh"
src_folder="src"

# CLEANUP
rm "$output_file"

# BUILD
build_files() {
  folder=$1

  for file in $folder/*; do
    if [ -d "$file" ]; then build_files $file; fi
    if [ -f "$file" ]; then cat $file >> $output_file; fi
  done
}

echo -e '#!/bin/bash\n' > $output_file
build_files $src_folder

# MAKINEG EXECUTABLE
chmod +x $output_file
