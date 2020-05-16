#!/bin/bash
set -eu

# general
export REPO_ROOT=$(git rev-parse --show-superproject-working-tree --show-toplevel | head -1)

# environment
export WORDLIST_FILE="$REPO_ROOT/environment/initdb/TEMP_word.list"
export DB_CONTAINER_NAME="50on5"
export DB_VOLUMENAME="50on5-db"
export MYSQL_USER="mysql"
export MYSQL_PASSWD="50on5"
