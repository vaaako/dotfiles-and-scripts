#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
	echo "Run as root"
	exit 1
fi

# Find backup folder. Get first find
BACKUP_FOLDER=$(find . -type d -name "dotfiles" | head -n 1)
if [ -z "$BACKUP_FOLDER" ]; then
	BACKUP_FOLDER="./"
fi

FSTAB_BKP="$BACKUP_FOLDER/fstab.bak"

# ---

echo "Target (bf/rf/es)"
echo "bf: Backup fstsb"
echo "rf: Restore fstsb (run once)"
echo "es: Enable password stars (run once)"
read -p "Target? " target
target=${target,,} # To lowercase

# ---

case "$target" in
	bf)
		tail -n 2 /etc/fstab > "$FSTAB_BKP"
		echo "Backup created."
		;;

	rf)
		cat "$FSTAB_BKP" >> /etc/fstab
		echo "Backup appended."
		;;

	es)
		echo "Defaults pwfeedback" > /etc/sudoers.d/pwfeedback
		chmod 440 /etc/sudoers.d/pwfeedback
		echo "Enabled."
		;;

	*)
		echo "Invalid."
		exit 1
		;;
esac

