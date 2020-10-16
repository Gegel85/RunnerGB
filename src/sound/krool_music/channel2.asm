musicChan2KRoolTheme::
	setRegisters $C1, $E1, $00, $00
.loop:
	wait SEMIBREVE * 4

	setVolume $E1

	repeat 2
	setFrequency NOTE_Bb, $80
	wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER

	play NOTE_Bb, $80
	wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait QUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER
	play NOTE_Bb, $80
        wait SEMIQUAVER

	setFrequency NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER

	play NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait QUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
	play NOTE_A, $80
        wait SEMIQUAVER
        continue

	setVolume $F1
	setFrequency NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_Bb, $80
        wait QUAVER
	setFrequency NOTE_G / 2, $80
        wait CROTCHET
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_Bb, $80
        wait CROTCHET

	setFrequency NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_Bb, $80
        wait QUAVER
	setFrequency NOTE_G / 2, $80
        wait CROTCHET
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_F / 2, $80
        wait CROTCHET

	setFrequency NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_Bb, $80
        wait QUAVER
	setFrequency NOTE_G / 2, $80
        wait CROTCHET
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_Bb, $80
        wait CROTCHET

	setFrequency NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_Bb, $80
        wait QUAVER
	setFrequency NOTE_G / 2, $80
        wait CROTCHET
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	play NOTE_G / 2, $80
        wait SEMIQUAVER
	setFrequency NOTE_A, $80
        wait CROTCHET

	repeat 2
	setFrequency NOTE_A, $80
	wait QUAVER
	play NOTE_A, $80
	wait QUAVER
	wait QUAVER
	play NOTE_A, $80
	wait QUAVER
	play NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
	wait QUAVER
	wait QUAVER
	play NOTE_A, $80
	wait QUAVER

	setFrequency NOTE_G / 2, $80
	wait QUAVER
	play NOTE_G / 2, $80
	wait QUAVER
	wait QUAVER
	play NOTE_G / 2, $80
	wait QUAVER
	setFrequency NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
	wait QUAVER
	play NOTE_A, $80
	wait QUAVER
	play NOTE_A, $80
	wait SEMIQUAVER
	play NOTE_A, $80
	wait SEMIQUAVER
	continue
	stopMusic
	jump .loop
