#!/bin/bash
echo "Put repo in src format somewhere."
mkdir -p /home/git/src/$1 && cat | tar -x -C /home/git/src/$1
echo "Building Docker image."
BASE=`basename $1 .git`
echo "Base: $BASE"
# TODO: Find out the old container ID.
sudo docker build -t nonfiction/$BASE /home/git/src/$1
ID=$(sudo docker run -P -d nonfiction/$BASE)
# Get the $PORT from this container.
PORT=$(sudo docker port $ID 5000 | sed 's/0.0.0.0://')
echo "$BASE is running on port $PORT"

# Connect $BASE.handbill.io to the $PORT
/usr/bin/redis-cli rpush frontend:$BASE.handbill.io $BASE
/usr/bin/redis-cli rpush frontend:$BASE.handbill.io http://127.0.0.1:$PORT

# Kill the old container by ID.