while true; do
	free | grep Mem | awk '{print $3/$2    *100}' | cut -d"." -f1
	sleep 1
done
