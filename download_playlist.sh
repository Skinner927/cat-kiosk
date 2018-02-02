#!/bin/bash
source config.sh

youtube-dl --yes-playlist --no-overwrites -o 'videos/%(title)s.%(ext)s' --restrict-filenames --download-archive HISTORY.txt "${PLAYLIST}"
