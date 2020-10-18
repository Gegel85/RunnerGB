SECTION "Assets", ROMX[$4000], BANK[1]

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

ScoreZoneSprite::
	incbin "assets/scoring_zone.cfx"

NumbersSprite::
	incbin "assets/numbers.fx"
NoCGBScreen::
NumbersEnd::
	incbin "assets/nocgberror.fx"
NoCGBScreenMap::
	incbin "assets/nocgberror.map"

ScoreZoneMap::
	incbin "assets/scoring_zone.map"

NumbersCredits::
	incbin "assets/credits.cfx"
Credits::
	incbin "assets/credits.map"

include "src/palettes.asm"