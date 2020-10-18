musicChan2SleepingTheme::
	setRegisters $00, $A5, $00, $00
	enableTerminals  %00100010
.loop:
	setVolume $A5
	setFrequency NOTE_G, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM

	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_G, $80
	wait SEMIBREVE
	disableTerminals %00100010
	wait SEMIBREVE
	enableTerminals  %00100010


	setFrequency NOTE_G, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM

	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait SEMIBREVE
	disableTerminals %00100010
	wait SEMIBREVE
	enableTerminals  %00100010

	setFrequency NOTE_G, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM

	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_G, $80
	wait SEMIBREVE
	disableTerminals %00100010
	wait SEMIBREVE
	enableTerminals  %00100010

	setFrequency NOTE_D * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM

	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_G, $80
	wait SEMIBREVE
	disableTerminals %00100010
	wait SEMIBREVE
	enableTerminals  %00100010


	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM
	setFrequency NOTE_E * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010

	setFrequency NOTE_A * 4, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_A * 4, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_G * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010


	setFrequency NOTE_G, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010

	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_G * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_F * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010


	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM
	setFrequency NOTE_E * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010

	setFrequency NOTE_B * 4, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_B * 4, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_A * 4, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_A * 4, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010


	setFrequency NOTE_G, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010

	setFrequency NOTE_G * 2, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_G * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	setFrequency NOTE_F * 2, $80
	wait CROTCHET
	disableTerminals %00100010
	wait CROTCHET
	enableTerminals  %00100010
	setFrequency NOTE_F * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010


	setFrequency NOTE_F * 2, $80
	wait MINIM
	setFrequency NOTE_E * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM
	setFrequency NOTE_E * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010


	setFrequency NOTE_E * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
	wait MINIM
	setFrequency NOTE_D * 2, $80
	wait MINIM
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010


	setFrequency NOTE_D * 2, $80
	wait MINIM
	setFrequency NOTE_C * 2, $80
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
	wait DOTTED_SEMIBREVE
	disableTerminals %00100010
	wait MINIM
	enableTerminals  %00100010
	stopMusic
	jump .loop
