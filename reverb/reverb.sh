#!/bin/bash

# Define URL and files to check
url="https://reverb.com/uk/my/feed"
oldFile="old.html"
newFile="new.html"

# Save the URL as a new file
curl -s -o "$newFile" "$url"

# Define search query
searchQuery="class=\"feed-item\""

# Grab the first match from each file
oldProduct="$(grep -A2 "$searchQuery" "$oldFile" | head -3)"
newProduct="$(grep -A2 "$searchQuery" "$newFile" | head -3)"

# Check if latest product title in the new file matches the old one
if [[ "$newProduct" == "$oldProduct" ]]; then
	printf "Nothing new this time"
else
	printf "NEW GEAR ALERT!"
	/usr/bin/open -a "/Applications/Google Chrome.app" "$url" # Open website in Chrome if there's something new
	curl -s -o "$oldFile" "$url" # Overwrite old file with latest HTML for next comparison
fi