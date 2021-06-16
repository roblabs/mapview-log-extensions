#!/usr/bin/env sh
# Copyright ePi Rational, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT

# Goal is to convert image files from the expected Apple `docc`
#   so that other Markdown engines (atom, GitHub), can use the same images
# This script converts PNG files to symbolic links
#
# Test using the command
# ./go.sh > test.md

SPLIT="~dark" # assume that you have `dark` and `light` screen shots.
# SPLIT="@2x" # use if you only have `light` and no `~dark` images

# loop over files matching the split.
for file in $(ls *${SPLIT}*);
do
  echo creating symbolic link for file: \`$file\`;

  img_file=$file
  split_file=(${img_file//$SPLIT/ })

  # make symboliclink, force
  ln -sf $file "${split_file}.png"

  # reconstruct to make image Markdown, with `alt` text
  echo "![alt](${split_file}.png)"
echo
echo ---
echo
done;
