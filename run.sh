#!/bin/bash
set -eu
cd $(dirname $0)

# main
./environment/run.sh
./analyzer/run.sh $@
