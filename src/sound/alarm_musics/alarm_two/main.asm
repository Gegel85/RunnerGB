include "src/sound/alarm_musics/alarm_two/channel1.asm"
include "src/sound/alarm_musics/alarm_two/channel2.asm"
include "src/sound/alarm_musics/alarm_two/channel3.asm"
include "src/sound/alarm_musics/alarm_two/channel4.asm"

AlarmTwoTheme::
	db $DA
	db %100
    dw musicChan1AlarmTwoTheme
    dw musicChan2AlarmTwoTheme
    dw musicChan3AlarmTwoTheme
	dw musicChan4AlarmTwoTheme