SECTION "Assets", ROMX[$6000], BANK[1]

BackgroundTileMap::
	incbin "assets/bg.map"

BackgroundChrs::
	incbin "assets/bg.cfx"

PlayerSprite::
	incbin "assets/player.fx"

GroundSprite::
	incbin "assets/ground.cfx"

SpikeSprite::
	incbin "assets/spike.ofx"

MoonSprite::
	incbin "assets/moon.ofx"

NumbersSprite::
	incbin "assets/numbers.zfx"
NoCGBScreen::
NumbersEnd::
	incbin "assets/nocgberror.fx"
NoCGBScreenMap::
	incbin "assets/nocgberror.map"

include "src/palettes.asm"