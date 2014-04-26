#!/bin/sh

OUT="$(echo "$1" | sed -r 's/%/\\\\x/g' | xargs printf | sed -r 's/_/ /g')"

echo "$OUT"

curl "http://edocs.library.curtin.edu.au/exam_display.cgi?url=$1&copyright=1" \
	-b tmp/cookies.txt \
	--create-dirs \
	-o "out/$OUT" \
	-s
