#!/bin/bash
set -eu
cd $(dirname $0)

. ../settings.sh

# functions
function kill_db() {
  echo killing db...
  docker kill $DB_CONTAINER_NAME
}

# main
function exit_handler() {
  echo "[analuzer/run.sh: exit handler] killing db. please wait..."
  kill_db
}
trap exit_handler 1 2 3 15

export WORDS_LENGTH=$1

## launch database
docker run \
  --name $DB_CONTAINER_NAME \
  --rm \
  -d \
  -e MYSQL_DATABASE="dict" \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_PASSWORD=$MYSQL_PASSWD \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWD \
  --mount type=bind,source=$REPO_ROOT/environment/initdb,target=/docker-entrypoint-initdb.d \
  --mount type=volume,source=$DB_VOLUMENAME,target=/var/lib/mysql \
  -p 3306:3306 \
  -it mysql:8 \
  --default-authentication-plugin=mysql_native_password \
  --secure-file-priv=/docker-entrypoint-initdb.d

npx ts-node index.ts

kill_db
