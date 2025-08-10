#!/bin/bash

src=/home/ubuntu/DevOps/Scripts
tgt=/home/ubuntu/zordaar/backups

filename=$(date +'%d-%m-%Y:%H:%M').tar.gz

echo $filename.tar
echo "backup started"

tar -cvf $tgt/$filename $src

echo "backup completed"
