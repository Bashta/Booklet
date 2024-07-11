#!/bin/sh

#  ci_post_clone.sh
#  Booklet
#
#  Created by Erison Veshi on 11.7.24.
#

# Create GoogleService-Info.plist in the current directory
echo "$GOOGLE_SERVICE_INFO_PLIST" > "./GoogleService-Info.plist"

# Move the file to the Booklet directory
mv "./GoogleService-Info.plist" "../Booklet/"

# Confirm file movement
echo "Contents of Booklet directory:"
ls -la "../Booklet"
