#!/bin/bash
# script to merge all images in a folder directory into a single PDF using ImageMagick

# check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "Error: This script is only compatible with Linux"
    exit 1
fi

# ask user for input directory path if not provided
while [ -z "$input_dir" ] || [ ! -d "$input_dir" ]; do
  read -p "Enter input directory path: " input_dir
  if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory does not exist"
  fi
done

# ask user for output PDF filename
read -p "Enter output PDF filename (without extension): " output_name

# set output directory to input directory
output_dir="$input_dir"

# check if input directory contains images
if ! ls "$input_dir"/*.{jpg,jpeg,png} >/dev/null 2>&1; then
  echo "Error: No images found in input directory"
  exit 1
fi

# create the output PDF
convert -compress jpeg -quality 90 "${input_dir}"/*.{jpg,jpeg,png} "${output_dir}/${output_name}.pdf"
echo "PDF successfully created at ${output_dir}/${output_name}.pdf"
