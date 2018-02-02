#!/bin/bash
source config.sh

# Exit handler
trap "exit 0" SIGINT SIGTERM;

while true; do

  # Download playlist
  echo 'Updating Playlist'
  mkdir -p "$VIDEO_DIR"
  ./download_playlist.sh | tee "${DIR}/youtube-dl.log"

  # Play each file in videos
  for f in $(ls "$VIDEO_DIR"); do
    if [[ $DELAY > 0 ]]; then
      vcgencmd display_power 1  # Turn on screen as it may have been off
    fi

    echo "Last played $f" | tee "${DIR}/last-played.log"
    omxplayer -b -o local "${VIDEO_DIR}/${f}"

    if [[ $DELAY > 0 ]]; then
      vcgencmd display_power 0  # Turn off screen
      sleep $DELAY
    fi
  done

done
