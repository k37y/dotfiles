xrdb -merge .Xresources.rxvt
xrdb -merge .Xresources.dropdown
xrdb -merge .Xresources.rofi
xrdb -merge .Xresources.xterm
conky -c $HOME/.conky/conkylog &
conky -c $HOME/.conky/conkytodo &
conky -c $HOME/.conky/conkygit &
exec i3 &
#exec startxfce4
#exec openbox &
lpid=$!
#idesk &
xsetroot -solid "#112233"
xautolock -time 1 -locker "xtrlock" &
wait $lpid
