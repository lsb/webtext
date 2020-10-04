#!/bin/sh
DIRNAME=https://files.pushshift.io/reddit/submissions/
wget -O - $DIRNAME | ~/.cargo/bin/htmlq -a href tr.file td:first-child a | awk '/RS/ { print "'${DIRNAME}'" $0 }'
