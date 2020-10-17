include "src/sound/alarm_musics/alarm_one/channel1.asm"
include "src/sound/alarm_musics/alarm_one/channel2.asm"
include "src/sound/alarm_musics/alarm_one/channel3.asm"
include "src/sound/alarm_musics/alarm_one/channel4.asm"

AlarmOneTheme::
	db $A0
	db %100
	dw musicChan1AlarmOneTheme
	dw musicChan2AlarmOneTheme
	dw musicChan3AlarmOneTheme
	dw musicChan4AlarmOneTheme
