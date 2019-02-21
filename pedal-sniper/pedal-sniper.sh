#!/bin/bash

# Define URL and files to check
url="https://www.guitarguitar.co.uk/pre-owned/pedals/"
oldFile="old.html"
newFile="new.html"

# Save the URL as a new file
curl -s -o "$newFile" "$url"

# Grab the first product from each file
oldProduct="$(grep -A2 "class=\"product\"" "$oldFile" | head -3)"
newProduct="$(grep -A2 "class=\"product\"" "$newFile" | head -3)"

# Check if latest product title in the new file matches the old one
if [[ "$newProduct" == "$oldProduct" ]]; then
	printf "Nothing new this time"
else
	printf "NEW PEDAL ALERT!"
	/usr/bin/open -a "/Applications/Google Chrome.app" "$url" # Open website in Chrome if there's something new
	curl -s -o "$oldFile" "$url" # Overwrite old file with latest HTML for next comparison
fi