#!/bin/bash
source config.sh

# Exit handler
trap "exit 0" SIGINT SIGTERM;

while true; do

  # Download playlist
  echo 'Updating Playlist'
  ./download_playlist.sh 2>&1 | tee "${DIR}/youtube-dl.log"

  # Play each file in videos
  for f in $(ls "$VIDEO_DIR"); do
    if [ $DELAY -gt 0 ]; then
      vcgencmd display_power 1  # Turn on screen as it may have been off
    fi

    echo "Last played $f" | tee "${DIR}/playing.log"
    omxplayer -b -o local "${VIDEO_DIR}/${f}"
    CAN_SLEEP=$?

    if [ $DELAY -gt 0 ]; then
      vcgencmd display_power 0  # Turn off screen
      if [ $CAN_SLEEP -eq 0 ]; then
        sleep $DELAY
      fi
    fi
  done

done
