#!/bin/bash

origin=$(pwd)
cd /d/Repositories/Idea/master/ormsui/client/lfm/
current=$(pwd)
# bash ./build_scripts/build-all.sh

echo origin=$origin
echo current=$current
echo $(dirname $0)
cd $(dirname $0)
echo current=$current