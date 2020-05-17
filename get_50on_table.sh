#!/bin/bash
set -eu
cd $(dirname $0)

. settings.sh

# main
./environment/run.sh
./analyzer/run.sh npx ts-node get50onTable.ts $1
