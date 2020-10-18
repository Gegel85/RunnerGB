SECTION "Assets", ROMX[$6000], BANK[1]

BackgroundTileMap::
	incbin "assets/bg.map"

BackgroundChrs::
	incbin "assets/bg.cfx"

MoonSprite::
	incbin "assets/moon.ofx"

GroundSprite::
	incbin "assets/ground.cfx"

SpikeSprite::
	incbin "assets/spike.ofx"

PlayerSprite::
	incbin "assets/hero1.cfx"
	incbin "assets/hero2.cfx"

PlayerJmp::
	incbin "assets/hero_jump.cfx"
	incbin "assets/hero_jump.cfx"

NumbersSprite::
	incbin "assets/numbers.zfx"
NoCGBScreen::
NumbersEnd::
	incbin "assets/nocgberror.fx"
NoCGBScreenMap::
	incbin "assets/nocgberror.map"

include "src/palettes.asm"