musicChan2AlarmOneTheme::
	repeat 4
	setRegisters $00, $00, $00, $00
	stopMusic
	continue
.loop:
	wait 0
	jump .loop
