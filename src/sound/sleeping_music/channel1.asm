musicChan1SleepingTheme::
	setRegisters $05, $C1, $57, $00, $00
	enableTerminals  %00010001
.loop:
    setVolume $57

    repeat 3
    setFrequency NOTE_G / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_B, $80
    wait DOTTED_SEMIBREVE
    setFrequency NOTE_A, $80
    wait MINIM
    setFrequency NOTE_G / 2, $80
    wait SEMIBREVE
    disableTerminals %00010001
    wait DOTTED_SEMIBREVE
    enableTerminals  %00010001
    continue

    setFrequency NOTE_B, $80
    wait SEMIBREVE
    setFrequency NOTE_G / 2, $80
    wait DOTTED_SEMIBREVE
    setFrequency NOTE_A, $80
    wait MINIM
    setFrequency NOTE_G / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_A, $80
    wait MINIM
    setFrequency NOTE_G / 2, $80
    wait SEMIBREVE

    repeat 2
    setFrequency NOTE_A, $80
    wait SEMIBREVE
    setFrequency NOTE_B, $80
    wait SEMIBREVE
    setFrequency NOTE_A, $80
    wait DOTTED_SEMIBREVE
    setFrequency NOTE_G / 2, $80
    wait DOTTED_SEMIBREVE
    setFrequency NOTE_F / 2, $80
    wait DOTTED_SEMIBREVE
    setFrequency NOTE_G / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_A, $80
    wait DOTTED_SEMIBREVE
    setFrequency NOTE_G / 2, $80
    wait DOTTED_SEMIBREVE
    disableTerminals %00010001
    wait MINIM
    enableTerminals  %00010001
    continue


    setFrequency NOTE_G / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_F / 2, $80
    wait SEMIBREVE
    disableTerminals %00010001
    wait MINIM
    enableTerminals  %00010001


    setFrequency NOTE_F / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_E / 2, $80
    wait SEMIBREVE
    disableTerminals %00010001
    wait MINIM
    enableTerminals  %00010001


    setFrequency NOTE_F / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_E / 2, $80
    wait MINIM
    setFrequency NOTE_F / 2, $80
    wait SEMIBREVE
    setFrequency NOTE_D / 2, $80
    wait MINIM
    setFrequency NOTE_C / 2, $80
    wait DOTTED_SEMIBREVE
    disableTerminals %00010001
    wait MINIM
    enableTerminals  %00010001
    stopMusic
    jump .loop
