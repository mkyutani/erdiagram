#!/usr/bin/env bash
## -*- mode: shell-script -*-

IMAGE="eralchemy"

docker build . --tag ${IMAGE} --no-cache

