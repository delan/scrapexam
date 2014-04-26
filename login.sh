#!/bin/sh

USERNAME='[redacted]'
PASSWORD='[redacted]'

mkdir -p tmp

if ! curl 'https://auth.lis.curtin.edu.au/cgi-bin/auth-ng/authredirect.cgi' \
	-c tmp/cookies.txt \
	-d 'userid='"$USERNAME"'&password='"$PASSWORD"'&redirurl' \
	-f -s |
	egrep '<title>' |
	egrep -q 'Accepted'; then
	echo 'login.sh: error: failed to log in'
	exit 1
fi
