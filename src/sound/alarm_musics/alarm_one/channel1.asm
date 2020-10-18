musicChan1AlarmOneTheme::
	repeat 4
	setRegisters $05, $C1, $00, $00, $00
	stopMusic
	continue
.loop:
	wait 0
	jump .loop
