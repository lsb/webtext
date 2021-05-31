[(.u | sub("^(?=/r/)";"https://reddit.com")), (((.t | tonumber) / 1000000) | floor) * 1000000] | select(.[0] | test("^https?://[^ ]+$")) | @tsv
