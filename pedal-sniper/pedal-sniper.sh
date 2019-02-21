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
oldProductC="$(tail -n+2465 "$originalFile" | head -n1)" # Two later lines account for possibility of pagination element
oldProductD="$(tail -n+2476 "$originalFile" | head -n1)"

# From the new file, grab the two possible lines the first product name can appear on
newProductA="$(tail -n+2418 "$newFile" | head -n1)"
newProductB="$(tail -n+2429 "$newFile" | head -n1)"
newProductC="$(tail -n+2465 "$newFile" | head -n1)"
newProductD="$(tail -n+2476 "$newFile" | head -n1)"

# Print those lines from the files
echo "$oldProductA"
echo "$oldProductB"
echo "$oldProductC"
echo "$oldProductD"
echo "$newProductA"
echo "$newProductB"
echo "$newProductC"
echo "$newProductD"

# Check if latest product title in the old file matches the new one
# if [ "$newProductA" == "$oldProductA" ] || [ "$newProductA" == "$oldProductB" ] || [ "$newProductB" == "$oldProductA" ] || [ "$newProductB" == "$oldProductB" ]; then
if [[ "$newProductA" =~ ^("$oldProductA"|"$oldProductB"|"$oldProductC"|"$oldProductD")$ ]] ||
	 [[ "$newProductB" =~ ^("$oldProductA"|"$oldProductB"|"$oldProductC"|"$oldProductD")$ ]] ||
	 [[ "$newProductC" =~ ^("$oldProductA"|"$oldProductB"|"$oldProductC"|"$oldProductD")$ ]] ||
	 [[ "$newProductD" =~ ^("$oldProductA"|"$oldProductB"|"$oldProductC"|"$oldProductD")$ ]]; then
	printf "\n\n Nothing new this time \n\n\n"
else
	printf "\n\n NEW PEDAL ALERT \n\n\n"
	/usr/bin/open -a "/Applications/Google Chrome.app" "$url" # Open website in Chrome if there's something new
fi

curl -o "$originalFile" "$url" # Overwrite old file with updated HTML for next comparison