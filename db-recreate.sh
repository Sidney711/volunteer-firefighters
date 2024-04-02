#!/bin/sh
docker-compose exec web rails db:drop db:create db:migrate db:seed