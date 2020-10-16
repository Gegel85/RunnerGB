include "src/sound/krool_music/channel1.asm"
include "src/sound/krool_music/channel2.asm"
include "src/sound/krool_music/channel3.asm"
include "src/sound/krool_music/channel4.asm"

kingKRoolTheme::
	db $00
	db %100
	dw musicChan1KRoolTheme
	dw musicChan2KRoolTheme
	dw musicChan3KRoolTheme
	dw musicChan4KRoolTheme