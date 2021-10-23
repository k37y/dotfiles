while true; do
	grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%2.1f%\n", usage}'
	sleep 1
done
