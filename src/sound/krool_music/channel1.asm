musicChan1KRoolTheme::
	setRegisters $05, $00, $A3, $00, $00
.loop:
	disableTerminals %00010001
	wait MINIM
	enableTerminals  %00010001
	setVolume $A3
	setFrequency NOTE_A, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_Bb, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_Bb, $80
	wait QUAVER

	disableTerminals %00010001
	wait MINIM
	enableTerminals  %00010001
	setFrequency NOTE_B, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_C, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_C, $80
	wait SEMIQUAVER
	setFrequency NOTE_C_SHARP, $80
	wait SEMIQUAVER

	disableTerminals %00010001
	wait MINIM
	enableTerminals  %00010001
	setFrequency NOTE_C_SHARP, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_D, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_D_SHARP, $80
	wait QUAVER

	disableTerminals %00010001
	wait MINIM
	enableTerminals  %00010001
	setFrequency NOTE_E, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_F, $80
	wait DOTTED_QUAVER
	setFrequency NOTE_F, $80
	wait SEMIQUAVER
	setFrequency NOTE_F_SHARP, $80
	wait SEMIQUAVER

	disableTerminals %00010001
	wait SEMIBREVE * 4
	enableTerminals  %00010001

	setVolume $D3
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_Bb, $80
	wait QUAVER
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_Bb, $80
	wait QUAVER
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER

	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_Bb, $80
	wait QUAVER
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_Bb, $80
	wait QUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER

	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_A, $80
	wait QUAVER
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_A, $80
	wait QUAVER
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER

	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_A, $80
	wait QUAVER
	setFrequency NOTE_Eb, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER
	setFrequency NOTE_A, $80
	wait QUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait QUAVER

	disableTerminals %00010001
	wait SEMIBREVE * 4
	enableTerminals  %00010001

	setFrequency NOTE_D, $80
	wait DOTTED_QUAVER
	play NOTE_D, $80
	wait SEMIQUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_G, $80
	wait QUAVER
	setFrequency NOTE_A * 2, $80
	wait DOTTED_CROTCHET
	setFrequency NOTE_F, $80
	wait QUAVER

	setFrequency NOTE_G, $80
	wait DOTTED_QUAVER
	play NOTE_G, $80
	wait SEMIQUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_G, $80
	wait QUAVER
	setFrequency NOTE_A * 2, $80
	wait QUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait CROTCHET

	play NOTE_D, $80
	wait DOTTED_QUAVER
	play NOTE_D, $80
	wait SEMIQUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_G, $80
	wait QUAVER
	setFrequency NOTE_A * 2, $80
	wait DOTTED_CROTCHET
	setFrequency NOTE_F, $80
	wait QUAVER

	setFrequency NOTE_G, $80
	wait QUAVER
	play NOTE_G, $80
	wait QUAVER
	setFrequency NOTE_F, $80
	wait QUAVER
	setFrequency NOTE_E, $80
	wait QUAVER
	setFrequency NOTE_D, $80
	wait MINIM

	wait QUAVER
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	play NOTE_D * 2, $80
	wait QUAVER
	play NOTE_D * 2, $80
	wait DOTTED_CROTCHET
	setFrequency NOTE_C * 2, $80
	wait SEMIQUAVER
	setFrequency NOTE_Bb * 2, $80
	wait SEMIQUAVER

	setFrequency NOTE_A * 2, $80
	wait CROTCHET
	setFrequency NOTE_Bb * 2, $80
	wait QUAVER
	setFrequency NOTE_A * 2, $80
	wait QUAVER
	setFrequency NOTE_Bb * 2, $80
	wait QUAVER
	setFrequency NOTE_A * 2, $80
	wait QUAVER
	setFrequency NOTE_G, $80
	wait CROTCHET

	disableTerminals %00010001
	wait QUAVER
	enableTerminals  %00010001
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	play NOTE_D * 2, $80
	wait QUAVER
	play NOTE_D * 2, $80
	wait DOTTED_CROTCHET
	setFrequency NOTE_C * 2, $80
	wait SEMIQUAVER
	setFrequency NOTE_Bb * 2, $80
	wait SEMIQUAVER

	setFrequency NOTE_A * 2, $80
	wait DOTTED_QUAVER
	play NOTE_A * 2, $80
	wait SEMIQUAVER
	setFrequency NOTE_Bb * 2, $80
	wait QUAVER
	setFrequency NOTE_A * 2, $80
	wait DOTTED_CROTCHET
	setFrequency NOTE_C * 2, $80
	wait QUAVER
	setFrequency NOTE_Bb * 2, $80
	wait QUAVER

	setFrequency NOTE_A * 2, $80
	wait DOTTED_QUAVER
	play NOTE_A * 2, $80
	wait SEMIQUAVER
	setFrequency NOTE_Bb * 2, $80
	wait QUAVER
	setFrequency NOTE_C * 2, $80
	wait CROTCHET
	setFrequency NOTE_Bb * 2, $80
	wait SEMIQUAVER
	play NOTE_Bb * 2, $80
	wait SEMIQUAVER
	setFrequency NOTE_D * 2, $80
	wait CROTCHET
	stopMusic
	jump .loop
