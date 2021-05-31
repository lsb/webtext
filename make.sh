#!/bin/bash

which jq || (echo 'requires jq' ; exit)
(which zstd && which xz) || (echo requires zstd and xz ; exit)
(which cargo && (which htmlq || stat ~/.cargo/bin/htmlq)) || (echo requires the htmlq crate ; exit)

./01-get-raw-rs-list.sh > raw-rs-list.txt
parallel --eta 'wget -nv -O - {} | bzip2 -d | ./02-raw-rs-to-urk.sh > {/.}.urk.json' ::: $(cat raw-rs-list.txt | grep 'bz2')
parallel --eta 'wget -nv -O - {} | zstd -d | ./02-raw-rs-to-urk.sh > {/.}.urk.json' ::: $(cat raw-rs-list.txt | grep 'zst')
parallel --eta 'wget -nv -O - {} | xz -d | ./02-raw-rs-to-urk.sh > {/.}.urk.json' ::: $(cat raw-rs-list.txt | grep 'xz')
parallel --eta 'split -C 200M -d {} {}- && gzip -9 {}-* && rm {}'  ::: RS_*.json
#parallel --eta --line-buffer 'zcat {} | jq -r -c -f clean-urls-and-quantize-time.jq | sort -u' ::: RS_20*.urk.json-*.gz | sort -u > url-time1m.tsv
