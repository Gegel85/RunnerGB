musicChan3SleepingTheme::
	setRegisters $80, $00, $00, $AC, $85
	stopMusic
	jump musicChan3SleepingTheme

	repeat 27 * 4
	enableTerminals  %00000100
	disableTerminals %01000000
	setVolume %01000000
	wait SEMIQUAVER

	setVolume %01100000
	wait SEMIQUAVER

	enableTerminals  %01000000
	disableTerminals %00000100
	setVolume %01000000
	wait SEMIQUAVER

	setVolume %01100000
	wait SEMIQUAVER
	continue
	setVolume 0

