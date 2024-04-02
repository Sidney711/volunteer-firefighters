#!/bin/sh

BASE_CMD="docker-compose exec web"

if [ $# -eq 0 ]
then
  exit 1
else
  eval "$BASE_CMD $@"
fi