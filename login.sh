#!/bin/sh

USERNAME='[redacted]'
PASSWORD='[redacted]'

mkdir -p tmp

curl 'https://auth.lis.curtin.edu.au/cgi-bin/auth-ng/authredirect.cgi' \
	 -c tmp/cookies.txt \
	 -d 'userid='"$USERNAME"'&password='"$PASSWORD"'&redirurl'
