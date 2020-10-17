musicChan4SleepingTheme::
	setRegisters $3F, $81, $00, $00
    stopMusic
    jump musicChan4SleepingTheme

	setVolume $81
	setFrequencyRaw $7D, $80
	wait QUAVER
	setFrequencyRaw $7D, $80
	wait QUAVER
    setFrequencyRaw $7D, $80
    wait QUAVER
    setFrequencyRaw $7D, $80
    wait QUAVER
	wait QUAVER + CROTCHET + MINIM

	setFrequencyRaw $7D, $80
	wait SEMIQUAVER
	setFrequencyRaw $7D, $80
	wait SEMIQUAVER
	wait QUAVER + CROTCHET + MINIM

	setFrequencyRaw $7D, $80
	wait SEMIQUAVER
	setFrequencyRaw $7D, $80
	wait SEMIQUAVER
	wait QUAVER + CROTCHET + MINIM



	setFrequencyRaw $7D, $80
	wait SEMIQUAVER
	setFrequencyRaw $7D, $80
	wait SEMIQUAVER
	setVolume $21
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setVolume $31
	playRaw $80
	wait SEMIQUAVER
	setVolume $41
	setFrequencyRaw $6D, $80
	wait SEMIQUAVER
	setVolume $51
	playRaw $80
	wait SEMIQUAVER
	setVolume $61
	playRaw $80
	wait SEMIQUAVER
	setVolume $71
	playRaw $80
	wait SEMIQUAVER
	setVolume $81
	setFrequencyRaw $6E, $80
	wait SEMIQUAVER
	setVolume $91
	playRaw $80
	wait SEMIQUAVER
	setVolume $A1
	playRaw $80
	wait SEMIQUAVER
	setVolume $B1
	playRaw $80
	wait SEMIQUAVER
	setVolume $C1
	setFrequencyRaw $6F, $80
	wait SEMIQUAVER
	setVolume $D1
	playRaw $80
	wait SEMIQUAVER
	setVolume $E1
	playRaw $80
	wait SEMIQUAVER
	setVolume $F1
	playRaw $80
	wait SEMIQUAVER

	repeat 8
	setVolume $A1
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setFrequencyRaw $6D, $80
	wait SEMIQUAVER
	setFrequencyRaw $6E, $80
	wait QUAVER
	setVolume $F1
	setFrequencyRaw $34, $80
	wait QUAVER
	setVolume $A1
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setFrequencyRaw $6D, $80
	wait SEMIQUAVER
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setFrequencyRaw $6E, $80
	wait QUAVER
	playRaw $80
	wait SEMIQUAVER
	setVolume $F1
	setFrequencyRaw $34, $80
	wait QUAVER
	setVolume $A1
	setFrequencyRaw $6D, $80
	wait SEMIQUAVER
	playRaw $80
	wait SEMIQUAVER
	continue

	setVolume $F1
	repeat 4
	wait CROTCHET
	setFrequencyRaw $34, $80
	wait MINIM
	setFrequencyRaw $34, $80
	wait CROTCHET
	continue

	wait SEMIBREVE * 3
	wait QUAVER
	setVolume $21
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setVolume $31
	playRaw $80
	wait SEMIQUAVER
	setVolume $41
	setFrequencyRaw $6D, $80
	wait SEMIQUAVER
	setVolume $51
	playRaw $80
	wait SEMIQUAVER
	setVolume $61
	playRaw $80
	wait SEMIQUAVER
	setVolume $71
	playRaw $80
	wait SEMIQUAVER
	setVolume $81
	setFrequencyRaw $6E, $80
	wait SEMIQUAVER
	setVolume $91
	playRaw $80
	wait SEMIQUAVER
	setVolume $A1
	playRaw $80
	wait SEMIQUAVER
	setVolume $B1
	playRaw $80
	wait SEMIQUAVER
	setVolume $C1
	setFrequencyRaw $6F, $80
	wait SEMIQUAVER
	setVolume $D1
	playRaw $80
	wait SEMIQUAVER
	setVolume $E1
	playRaw $80
	wait SEMIQUAVER
	setVolume $F1
	playRaw $80
	wait SEMIQUAVER

	repeat 7
	setVolume $A1
	setFrequencyRaw $7A, $80
	wait CROTCHET
	setVolume $F1
	setFrequencyRaw $34, $80
	wait QUAVER
	setVolume $A1
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setFrequencyRaw $6D, $80
	wait SEMIQUAVER
	setFrequencyRaw $6C, $80
	wait SEMIQUAVER
	setFrequencyRaw $6E, $80
	wait QUAVER
	playRaw $80
	wait SEMIQUAVER
	setVolume $F1
	setFrequencyRaw $34, $80
	wait CROTCHET
	continue
