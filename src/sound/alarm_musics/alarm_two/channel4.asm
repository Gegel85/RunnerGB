musicChan4AlarmTwoTheme::
	setRegisters $00, $00, $19, $C0
    stopMusic
    jump musicChan4AlarmTwoTheme

    repeat 99
    setVolume $87
    playRaw $80
	wait QUAVER
	setVolume $00
    wait CROTCHET
	continue
