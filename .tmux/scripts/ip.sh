while true; do
	if nc -zw1 google.com 443 2>/dev/null; then
		curl -s -w '\n' --connect-timeout 1 https://ifconfig.me 2>/dev/null
	else
		echo offline
	fi
	sleep 5
done
