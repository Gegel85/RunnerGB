musicChan1AlarmTwoTheme::
	setRegisters $05, $C1, $00, $00, $00

.loop:
	stopMusic
	jump .loop
