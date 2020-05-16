#!/bin/bash
set -eu
cd $(dirname $0)

. settings.sh

[ -e "$WORDLIST_FILE" ] && rm -f $WORDLIST_FILE
[ "$(docker volume ls | grep "$DB_VOLUMENAME")" != "" ] && docker volume rm $DB_VOLUMENAME
