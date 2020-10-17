include "src/sound/krool_music/channel1.asm"
include "src/sound/krool_music/channel2.asm"
include "src/sound/krool_music/channel3.asm"
include "src/sound/krool_music/channel4.asm"

SleepingTheme::
	db $A0
	db %100
	dw musicChan1SleepingTheme
	dw musicChan2SleepingTheme
	dw musicChan3SleepingTheme
	dw musicChan4SleepingTheme