#! /bin/bash

CONTOUR_BIN="${HOME}/usr/opt/contour/bin/contour"

connected_outputs() {
	xrandr --current | grep -w connected | awk '{print $1}'
}

connected_monitor_count() {
	connected_outputs | wc -l
}

primary_monitor_only() {
	local count=$(connected_monitor_count)
	test "${count}" -eq 1
}

if primary_monitor_only; then
	echo "Laptop-Mode"
	exec $CONTOUR_BIN -p mobile
else
	echo "Desktop-Mode"
	exec $CONTOUR_BIN
fi
