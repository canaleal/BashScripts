#!/bin/bash
# script to compress all image files in a directory using FFmpeg

# ask user for input directory path if not provided
while [ -z "$input_dir" ] || [ ! -d "$input_dir" ]; do
  read -p "Enter input directory path: " input_dir
  if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory does not exist"
  fi
done

# ask user for image quality level (1-31, with 1 being the highest quality)
while [ -z "$quality" ] || [ "$quality" -lt 1 ] || [ "$quality" -gt 31 ]; do
  read -p "Enter image quality level (1-31, with 1 being the highest quality): " quality
done

# ask user what to do with original files
while true; do
  read -p "What do you want to do with the original files? (delete/move/keep): " option
  case $option in
    delete)
      move_files=false
      delete_files=true
      break
      ;;
    move)
      move_files=true
      delete_files=false
      mkdir -p "$input_dir/raw"
      break
      ;;
    keep)
      move_files=false
      delete_files=false
      break
      ;;
    *)
      echo "Invalid option: $option"
      ;;
  esac
done

# loop through all image files in the input directory and compress them using FFmpeg
for file in "$input_dir"/*.jpg "$input_dir"/*.jpeg "$input_dir"/*.png; do
  filename=$(basename "$file")
  extension="${filename##*.}"
  filename="${filename%.*}"
  output_file="$input_dir/comp_$filename.jpg"
  if [ "$move_files" = true ]; then
    # move the original file to the raw directory
    mv "$file" "$input_dir/raw/$filename.$extension"
  elif [ "$delete_files" = true ]; then
    # delete the original file
    rm "$file"
  fi
  ffmpeg -i "$input_dir/raw/$filename.$extension" -q:v "$quality" "$output_file"
  echo "Compressed $filename.$extension to $output_file"
done

echo "Compression complete"
