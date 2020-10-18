musicChan1MainMenuTheme::
	setRegisters $05, $C1, $57, $00, $00
.loop:
	setVolume $57

	repeat 13
	setFrequency NOTE_G, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_G, $80
	wait MINIM
	disableTerminals TERMINAL_ONE
	wait MINIM
	enableTerminals  TERMINAL_ONE
	continue

	disableTerminals TERMINAL_ONE
	wait SEMIBREVE * 4
	enableTerminals  TERMINAL_ONE

	stopMusic
	jump .loop
