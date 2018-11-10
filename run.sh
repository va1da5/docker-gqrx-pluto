#!/usr/bin/env bash

xhost +local:docker

USER_UID=$(id -u)

docker run --rm -d \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    --add-host pluto.local:192.168.2.1 \
    --network host \
    --device /dev/snd \
    --device /dev/dri \
    --volume /run/user/${USER_UID}/pulse:/run/user/1000/pulse \
    --name gqrx \
    gqrx
