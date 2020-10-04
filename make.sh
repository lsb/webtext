#!/bin/bash
./01-get-raw-rs-list.sh > raw-rs-list.txt
parallel 'wget -nv -O - {} | bzip2 -d | ./02-raw-rs-to-urk.sh > $(basename {=s/\..*//=}).urk.json' ::: $(cat raw-rs-list.txt | grep 'bz2')
parallel 'wget -nv -O - {} | zstd -d | ./02-raw-rs-to-urk.sh > $(basename {=s/\..*//=}).urk.json' ::: $(cat raw-rs-list.txt | grep 'zst')
parallel 'wget -nv -O - {} | xz -d | ./02-raw-rs-to-urk.sh > $(basename {=s/\..*//=}).urk.json' ::: $(cat raw-rs-list.txt | grep 'xz')
parallel -v 'split -C 200M -d {} {}- && gzip -9 {}-* && rm {}'  ::: RS_*.json

