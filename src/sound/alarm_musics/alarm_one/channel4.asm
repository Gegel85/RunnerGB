musicChan4AlarmOneTheme::
	setRegisters $00, $87, $19, $C0

.loop:
    setVolume $87
    playRaw $80
	wait QUAVER
	setVolume $00
    wait CROTCHET
	continue
    stopMusic
    jump .loop