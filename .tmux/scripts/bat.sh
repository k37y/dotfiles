while true; do
	upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | awk '{print $2}'
	sleep 1
done
