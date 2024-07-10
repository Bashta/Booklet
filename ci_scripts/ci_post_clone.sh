#!/bin/sh

#  ci_post_clone.sh
#  Booklet
#
#  Created by Erison Veshi on 11.7.24.
#

# Debug: Print current working directory
echo "Current working directory: $(pwd)"

# Debug: Print CI_WORKSPACE value
echo "CI_WORKSPACE: $CI_WORKSPACE"

# Debug: List contents of CI_WORKSPACE
echo "Contents of CI_WORKSPACE:"
ls -R "$CI_WORKSPACE"

# Create the directory if it doesn't exist
mkdir -p "$CI_WORKSPACE/Booklet"

# Write the file
echo "$GOOGLE_SERVICE_INFO_PLIST" > "$CI_WORKSPACE/Booklet/GoogleService-Info.plist"

# Debug: Confirm file creation
echo "Contents of $CI_WORKSPACE/Booklet:"
ls -l "$CI_WORKSPACE/Booklet"

# Debug: Print first few lines of the created file
echo "First few lines of GoogleService-Info.plist:"
head -n 5 "$CI_WORKSPACE/Booklet/GoogleService-Info.plist"
