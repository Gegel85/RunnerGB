musicChan2MainMenuTheme::
	setRegisters $00, $00, $00, $00
.loop:
	setVolume $A5
	disableTerminals TERMINAL_TWO
	wait SEMIBREVE * 8
	enableTerminals  TERMINAL_TWO

	repeat 2
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait MINIM
	disableTerminals TERMINAL_TWO
	wait MINIM
	enableTerminals  TERMINAL_TWO


	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_E * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_E * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_E * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait MINIM
	disableTerminals TERMINAL_TWO
	wait MINIM
	enableTerminals  TERMINAL_TWO


	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	setFrequency NOTE_F * 2, $80
	wait MINIM
	disableTerminals TERMINAL_TWO
	wait MINIM
	enableTerminals  TERMINAL_TWO


	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_E * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	disableTerminals TERMINAL_TWO
	wait CROTCHET
	enableTerminals  TERMINAL_TWO
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	disableTerminals TERMINAL_TWO
	wait CROTCHET
	enableTerminals  TERMINAL_TWO
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_E * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait MINIM
	disableTerminals TERMINAL_TWO
	wait MINIM
	enableTerminals  TERMINAL_TWO
	continue

	repeat 3
	setFrequency NOTE_E * 2, $80
	wait SEMIBREVE
	setFrequency NOTE_D * 2, $80
	wait SEMIBREVE
	setFrequency NOTE_C * 2, $80
	wait SEMIBREVE
	setFrequency NOTE_D * 2, $80
	wait MINIM
	disableTerminals TERMINAL_TWO
	wait MINIM
	enableTerminals  TERMINAL_TWO
	continue

	setFrequency NOTE_C * 2, $80
	wait SEMIBREVE
	setFrequency NOTE_B * 2, $80
	wait SEMIBREVE
	setFrequency NOTE_A * 2, $80
	wait SEMIBREVE
	setFrequency NOTE_G, $80
	wait SEMIBREVE
	stopMusic
	jump .loop
