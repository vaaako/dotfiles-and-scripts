#!/usr/bin/bash

set -eu

RETROARCH_FOLDER="$HOME/.var/app/org.libretro.RetroArch/config/retroarch"
RETROARCH_BACKUP=("retroarch.cfg" "config" "cores" "playlists" "saves" "system" "thumbnails")
TARGET="retroarch_backup"

mkdir -p $TARGET

for FILE in ${RETROARCH_BACKUP[@]}; do
	FULLPATH="$RETROARCH_FOLDER/$FILE" 
	echo "[+] Copying $FULLPATH"
	cp -r $FULLPATH $TARGET
done

echo "[+] Backup done!"
