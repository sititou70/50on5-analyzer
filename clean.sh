#!/bin/bash
set -eu
cd $(dirname $0)

. settings.sh

if [ "$(docker volume ls | grep "$DB_VOLUMENAME")" != "" ]; then
  docker volume rm $DB_VOLUMENAME
fi
