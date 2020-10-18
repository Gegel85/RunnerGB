musicChan4AlarmOneTheme::
	setRegisters $00, $87, $19, $C0

	repeat 4
	setVolume $87
	playRaw $80
	wait QUAVER
	setVolume $00
	wait CROTCHET
	stopMusic
	continue
.loop:
	wait 0
	jump .loop