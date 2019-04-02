#! /bin/bash

if [[ "$(docker images -q zego-documentation 2> /dev/null)" == "" ]]; then
     make build-image
fi
