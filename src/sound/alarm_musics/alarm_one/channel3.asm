musicChan3AlarmOneTheme::
	repeat 4
	setRegisters $80, $00, $00, $AC, $85
	stopMusic
	continue
.loop:
	wait 0
	jump .loop
