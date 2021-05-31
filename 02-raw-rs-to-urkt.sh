#!/bin/sh
grep --text -E '^[{]' | jq -c 'select(.score >= 3) | {"u": .url, "r": .subreddit, "k": .score, "t": .created_utc}' | sort

