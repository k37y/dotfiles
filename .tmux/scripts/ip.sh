while true; do
	if nc -zw1 google.com 443 2>/dev/null; then
		curl -s -w '\n' --connect-timeout 1 https://ifconfig.me | awk '{printf "%.3d.%.3d.%.3d.%.3d\n",$1,$2,$3,$4}' FS=. 2>/dev/null
		sleep 3
		ip a s $(ip r | grep default | awk '{print $5}') | grep inet | awk '{print $2}' | cut -d'/' -f1 | awk '{printf "%.3d.%.3d.%.3d.%.3d\n",$1,$2,$3,$4}' FS=. 2>/dev/null
		sleep 3
	else
		echo offline
		sleep 1
	fi
done
