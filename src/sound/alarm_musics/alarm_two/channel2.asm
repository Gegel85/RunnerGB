musicChan2AlarmTwoTheme::
	setRegisters $00, $A7, $00, $00

	setVolume $A7
	setFrequency NOTE_E * 2, $80
	wait CROTCHET
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	setFrequency NOTE_F_SHARP, $80
	wait MINIM
	setFrequency NOTE_G_SHARP, $80
	wait MINIM
	setFrequency NOTE_C_SHARP * 2, $80
	wait CROTCHET
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_D, $80
	wait MINIM
	setFrequency NOTE_E, $80
	wait MINIM
	setFrequency NOTE_B * 2, $80
	wait CROTCHET
	setFrequency NOTE_A * 2, $80
	wait CROTCHET
	setFrequency NOTE_C_SHARP, $80
	wait MINIM
	setFrequency NOTE_E, $80
	wait MINIM
	setFrequency NOTE_A * 2, $80
	wait SEMIBREVE
	setVolume $00
	wait SEMIBREVE

.loop:
	stopMusic
	jump .loop
