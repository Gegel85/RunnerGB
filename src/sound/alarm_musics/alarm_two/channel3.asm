musicChan3AlarmTwoTheme::
	setRegisters $80, $00, $00, $AC, $85
.loop:
	stopMusic
	jump .loop
