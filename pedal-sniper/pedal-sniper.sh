#!/bin/bash

# Define URL and file to check
url="https://www.guitarguitar.co.uk/pre-owned/pedals/"
originalFile="old.html"
newFile="new.html"

# Save the URL as a new file
echo "$(curl -o "$newFile" "$url")"

# From the original file, grab the two possible lines the first product name can appear on
oldProductA="$(tail -n+2418 "$originalFile" | head -n1)"
oldProductB="$(tail -n+2429 "$originalFile" | head -n1)"

# From the new file, grab the two possible lines the first product name can appear on
newProductA="$(tail -n+2418 "$newFile" | head -n1)"
newProductB="$(tail -n+2429 "$newFile" | head -n1)"

# Print those lines from the files
echo "$oldProductA"
echo "$oldProductB"
echo "$newProductA"
echo "$newProductB"

# Check if latest product title in the old file matches the new one
if [ "$newProductA" == "$oldProductA" ] || [ "$newProductA" == "$oldProductB" ] || [ "$newProductB" == "$oldProductA" ] || [ "$newProductB" == "$oldProductB" ]; then
	printf "\n\n Nothing new this time \n\n\n"
else
	printf "\n\n NEW PEDAL ALERT \n\n\n"
	# TODO
	# - Notify me somehow (Slack?)
fi

curl -o "$originalFile" "$url" # Overwrite old file with updated HTML for next comparison