#!/bin/sh

echo "$1"

curl -s "$1" | \
	egrep '<p><a href="[^"]+" >' |
	sed -r 's/.+"([^"]+)".+/\1/' |
	sed -r 's/ /%20/g' |
	xargs -P 4 -I %% ./walk.sh "$1%%/"

curl -s "$1" | \
	egrep '<p><a href="[^"]+" target="_blank">' |
	sed -r 's/.+url=([^"]+).+/\t\1/' |
	xargs -P 4 -I %% ./fetch.sh '%%'
