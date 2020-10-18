musicChan3MainMenuTheme::
	setRegisters $80, $00, $00, $AC, $85

.loop:

    wait SEMIBREVE * 24
    setVolume %01100000

    repeat 4
    setFrequency NOTE_C, $80
	wait CROTCHET
    setFrequency NOTE_D, $80
    wait CROTCHET
    setFrequency NOTE_E, $80
    wait CROTCHET
    setFrequency NOTE_F, $80
    wait CROTCHET
    setFrequency NOTE_E, $80
    wait CROTCHET
    setFrequency NOTE_D, $80
    wait CROTCHET
    setFrequency NOTE_E, $80
    wait CROTCHET
    setFrequency NOTE_D, $80
    wait CROTCHET
    setFrequency NOTE_C, $80
    wait CROTCHET
    setFrequency NOTE_D, $80
    wait CROTCHET
    setFrequency NOTE_E, $80
    wait CROTCHET
    setFrequency NOTE_F, $80
    wait CROTCHET
    setFrequency NOTE_E, $80
	wait CROTCHET
    setFrequency NOTE_D, $80
    wait CROTCHET
    setFrequency NOTE_C, $80
    wait CROTCHET
	disableTerminals TERMINAL_THREE
	wait CROTCHET
	enableTerminals  TERMINAL_THREE
	continue

    disableTerminals TERMINAL_THREE
    wait SEMIBREVE * 16
    enableTerminals  TERMINAL_THREE

	stopMusic
	jump .loop

