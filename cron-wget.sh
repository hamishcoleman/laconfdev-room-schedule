#!/bin/sh
#
# Regularly fetch the schedule json
#

URL=https://2024.everythingopen.au/schedule/conference.json
FILE=~/static/conference.json

mkdir -p $(dirname ${FILE})

curl -f -s -o ${FILE}.tmp ${URL}
S=$?

if [ $S -ne 0 ]; then
    exit $S
fi

mv -f ${FILE}.tmp ${FILE}
