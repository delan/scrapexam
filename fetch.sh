#!/bin/sh

OUT="$(
	echo "$1" |
	# decode URI component
	sed -r 's/%/\\\\x/g' |
	xargs printf |
	# underscores to spaces
	sed -r 's/_/ /g' |
	# collapse multiple spaces
	sed -r 's/ +/ /g' |
	# split path components
	tr '/' '\n' |
	# trim each path component
	sed -r 's/\s*(.+)\s*/\1/' |
	# get last two path components
	tail -n 2 |
	# join path components
	paste -s -d '/'
)"

URL="http://edocs.library.curtin.edu.au/exam_display.cgi?url=$1&copyright=1"

curl "$URL" \
	-b tmp/cookies.txt \
	--create-dirs \
	-o "out/$OUT" \
	-f -s -C -

RETVAL=$?

# Curtin server does not support the Range header

if [ $RETVAL -eq 0 ]; then
	echo "Success: $OUT"
elif [ $RETVAL -eq 33 ]; then
	echo "Exists: $OUT"
else
	echo "Failed $RETVAL: $OUT"
	exit 1
fi
