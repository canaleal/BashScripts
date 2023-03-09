#!/bin/bash

# Prompt the user for the input directory path, validate that it exists and is a directory
while true; do
  echo "Please enter the path to the input directory:"
  read input_dir
  if [ ! -d "$input_dir" ]; then
    echo "Input directory does not exist or is not a directory. Please try again."
  else
    break
  fi
done

# Prompt the user for the output format, validate that it is a valid option
while true; do
  echo "Please select the output format:"
  echo "1. JPG"
  echo "2. PNG"
  echo "3. WEBP"
  read output_format

  case $output_format in
    1)
      output_ext="jpg"
      break
      ;;
    2)
      output_ext="png"
      break
      ;;
    3)
      output_ext="webp"
      break
      ;;
    *)
      echo "Invalid output format selected. Please try again."
  esac
done

# Set the output directory to be the same as the input directory
output_dir="$input_dir"

# Convert images to output format and resolution
for image_file in $input_dir/*.{jpg,png}; do
  if [ -f "$image_file" ]; then
    image_name=$(basename "$image_file")
    output_name="${image_name%.*}.$output_ext"
    output_path="$output_dir/$output_name"
    echo "Converting $image_file to $output_path"
    input_resolution=$(identify -format "%wx%h" "$image_file") # get the input resolution
    convert "$image_file" -resize "$input_resolution" "$output_path"
  fi
done

# Convert videos to output format and resolution
for video_file in $input_dir/*.mp4; do
  if [ -f "$video_file" ]; then
    video_name=$(basename "$video_file")
    output_name="${video_name%.*}.$output_ext"
    output_path="$output_dir/$output_name"
    echo "Converting $video_file to $output_path"
    ffmpeg -i "$video_file" -vf "scale=$input_resolution" "$output_path"
  fi
done

echo "Conversion complete!"
