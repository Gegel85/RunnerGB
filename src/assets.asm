SECTION "Assets", ROMX[$4000], BANK[1]

BackgroundTileMap::
	incbin "assets/bg.tilemap"

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
	incbin "assets/nocgberror.tilemap"

ScoreZoneMap::
	incbin "assets/scoring_zone.tilemap"

MainMenuMap::
	incbin "assets/main_menu.tilemap"

MainMenuChrs::
	incbin "assets/main_menu.cfx"
EndMMChr::

LogoMap::
	incbin "assets/logo.tilemap"

LogoChrs::
	incbin "assets/logo.cfx"
EndLogoChr::

NumbersCredits::
	incbin "assets/credits.cfx"
Credits::
	incbin "assets/credits.map"

include "src/palettes.asm"