#!/bin/sh

#  ci_post_clone.sh
#  Booklet
#
#  Created by Erison Veshi on 11.7.24.
#

# Debug: Print current working directory
echo "Current working directory: $(pwd)"

# Debug: Print contents of current directory
echo "Contents of current directory:"
ls -la

# Debug: Print parent directory contents
echo "Contents of parent directory:"
ls -la ..

# Attempt to write the file in the current directory
echo "$GOOGLE_SERVICE_INFO_PLIST" > "./GoogleService-Info.plist"

# Debug: Confirm file creation
echo "Contents of current directory after file creation:"
ls -la

# Debug: Print first few lines of the created file
echo "First few lines of GoogleService-Info.plist:"
head -n 5 "./GoogleService-Info.plist"
