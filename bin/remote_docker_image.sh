#!/bin/bash

docker images --format '{{.Repository}}:{{.Tag}}' |
while read -r image; do
    [[ "$image" == *'<none>'* ]] && continue

    if docker buildx imagetools inspect "$image" >/dev/null 2>&1; then
        printf 'REMOTE EXISTS  %s\n' "$image"
    else
        printf 'NOT FOUND/UNAVAILABLE  %s\n' "$image"
    fi
done
