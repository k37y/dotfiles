while true; do
	if nc -zw1 google.com 443 2>/dev/null; then
		curl -s -w '\n' --connect-timeout 1 https://ifconfig.me 2>/dev/null
		sleep 3
		ip r | grep '^default' | cut -d' ' -f3 2>/dev/null
		sleep 3
	else
		echo offline
		sleep 1
	fi
done
