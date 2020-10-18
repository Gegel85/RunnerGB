include "src/sound/main_menu_music/channel1.asm"
include "src/sound/main_menu_music/channel2.asm"
include "src/sound/main_menu_music/channel3.asm"
include "src/sound/main_menu_music/channel4.asm"

MainMenuTheme::
	db $A0
	db %100
	dw musicChan1MainMenuTheme
	dw musicChan2MainMenuTheme
	dw musicChan3MainMenuTheme
	dw musicChan4MainMenuTheme