IF=$(ip r | grep '^default' | cut -d' ' -f5)

while true
do
        R1=`cat /sys/class/net/${IF}/statistics/rx_bytes`
        T1=`cat /sys/class/net/${IF}/statistics/tx_bytes`
        sleep 1
        R2=`cat /sys/class/net/${IF}/statistics/rx_bytes`
        T2=`cat /sys/class/net/${IF}/statistics/tx_bytes`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TKBPS=`expr $TBPS / 1024`
        RKBPS=`expr $RBPS / 1024`
	if [[ $1 == upload ]]; then
		echo "↑ $(echo $TKBPS | awk '{printf "%0004d\n", $1}') KB/s"
	elif [[ $1 == download ]]; then
		echo "↓ $( echo $RKBPS | awk '{printf "%0004d\n", $1}') KB/s"
	fi
done
