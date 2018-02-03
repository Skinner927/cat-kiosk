#!/bin/bash
source config.sh

mkdir -p "$VIDEO_DIR"
pushd "$VIDEO_DIR"
youtube-dl --yes-playlist --no-overwrites -o '%(title)s' --write-info-json --restrict-filenames "${PLAYLIST}"

# Remove videos that don't exist in playlist
# We cheaply do this by seeing who doesn't have a .json file and removing them
for f in $(ls | grep -v '.json'); do
  if [ ! -f "./${f}.info.json" ]; then
    echo "Removing $f as it is no longer in the playlist"
    rm "$f"
  fi
done

# Remove all json
rm *.json
popd
