#!/bin/bash

echo "Downloading Patches......"
cat patches.txt| while read -r line; do
    URL="$line"
    CACHEFILE="$(basename "$URL")"
    
    if [ ! -f "$CACHEFILE" ]; then
        echo "Downloading $URL"
        wget "$URL"
    fi

done
