#!/bin/bash
killall dunst
dunst &
# to test a 'high' urgency notification add '-u critical '
notify-send -i /usr/share/icons/Adwaita/scalable/devices/video-display.svg \
	"Test" "This -> is a test with 'monitor' icon"
