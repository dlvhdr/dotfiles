#!/bin/bash

docker rm -f -v $(docker ps -aq)

docker rmi -f  $(docker images -q)

docker volume rm $(docker volume ls -q)

docker network rm $(docker network ls -q)
