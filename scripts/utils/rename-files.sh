#!/bin/bash
# script to rename files in a directory to a specified naming convention

# ask user for directory path
while [ -z "$dir_path" ] || [ ! -d "$dir_path" ]; do
  read -p "Enter directory path: " dir_path
  if [ ! -d "$dir_path" ]; then
    echo "Error: Directory does not exist"
  fi
done

# ask user for naming convention
read -p "Enter naming convention (e.g. prefix###): " naming_convention

# get file extension from user
read -p "Enter file extension (e.g. jpg): " file_extension

# count the number of files in the directory
file_count=$(ls "$dir_path"/*.$file_extension | wc -l)

# loop through all files in the directory and rename them
i=1
for file in "$dir_path"/*.$file_extension; do
  new_name=$(printf "$naming_convention.$file_extension" "$i")
  mv "$file" "$dir_path/$new_name"
  echo "Renamed $file to $new_name"
  i=$((i+1))
done

echo "Renamed $file_count files in directory $dir_path"
