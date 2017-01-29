#!/bin/bash
# import json parser library: https://github.com/kristopolous/TickTick
. ticktick.sh

# extract the file type from the URL given
postfix=${1##*.}
outfile="temp.$postfix"
# download image from the internet
curl "$1" > $outfile

# hipstafy
convert -sepia-tone 60% +polaroid "$outfile" "$outfile"

#upload to imgur
# read the OAuth2 token for this app from a file
authtoken=$(cat token)
response=$(curl --header "Authorization: Client-ID $authtoken" -X POST --data-binary "@temp.jpg" https://api.imgur.com/3/image)

# parse the response
tickParse "$response"

# the response contains boolean 'success' that is True if the request was successful
# it also returns information about the uploaded image in the table 'data'
# its field 'address' contains the address to the image just uploaded
returncode=$(echo ``success``)
address=$(echo ``data["link"]``)
httpstatus=$(echo ``status``)


# if successful, print url, remove escape characters
# otherwise print http status
if [ "$returncode" == "true" ]; then
    echo "link: $(echo $address | sed 's/\\//g')"
else
        echo "There was an error, HTTP status code: $status"
fi

