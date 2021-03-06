include "src/constants.asm"
include "src/macro.asm"

SECTION "Main", ROM0

notCGB::
	call waitVBLANK
	reset LCD_CONTROL
	reg BGP, $E4
	ld hl, NoCGBScreen
	ld de, VRAM_START
	ld bc, NoCGBScreenMap - NoCGBScreen
	call copyMemory

	ld b, 18
	push hl
	ld hl, VRAM_BG_START
	pop de
.loop:
	ld c, 20
.miniLoop:
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .miniLoop
	push bc
	ld bc, 12
	add hl, bc
	pop bc
	dec b
	jr nz, .loop

	reg LCD_CONTROL, %11010001

; Locks the CPU
; Params:
;	None
; Return:
;	None
; Registers:
;	N/A
lockup::
	reset INTERRUPT_REQUEST
	ld [INTERRUPT_ENABLED], a
.loop:
	halt
	jr .loop

; Main function
main::
	ld sp, $FFFF
	cp CGB_A_INIT
	jp nz, notCGB
	call init

mainMenu::
	ld de, PLAYING_MUSICS
	ld hl, MainMenuTheme
	call startMusic

	reg WX, 167 - 70
	reg WY, 144 - 18

	call waitVBLANK
	reset LCD_CONTROL

	reg VBK, 1
	ld a, 3
	ld de, $9C00
	ld bc, 200
	call fillMemory
	reset VBK

	ld de, VRAM_START
	ld hl, MainMenuChrs
	ld bc, EndMMChr - MainMenuChrs
	call copyMemory

	ld hl, LogoChrs
	ld bc, EndLogoChr - LogoChrs
	call copyMemory

	ld de, $8880
	ld hl, ScoreZoneSprite
	ld bc, NumbersSprite - ScoreZoneSprite
	call copyMemory

	ld hl, $9C00
	ld de, ScoreZoneMap
	ld bc, $20 - 9
.copypyLoop:
	ld a, [de]
	inc de
	add $88
	ld [hli], a
	bit 3, l
	jr z, .copypyLoop
	bit 0, l
	jr z, .copypyLoop
	add hl, bc
	bit 7, l
	jr z, .copypyLoop

	ld de, BGPI
	ld a, $98
	ld [de], a
	inc e
	ld b, 8
	ld hl, scoreZonePal
.bgPalLoopk:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .bgPalLoopk


	ld de, VRAM_START + $A00
	ld hl, NumbersSprite
	ld bc, NumbersEnd - NumbersSprite
	call copyMemory

	ld hl, $9800
	ld de, MainMenuMap
	ld bc, $20 - 20
.copyLoop:
	ld a, [de]
	inc de
	ld [hli], a
	bit 2, l
	jr z, .copyLoop
	bit 4, l
	jr z, .copyLoop
	add hl, bc
	bit 2, h
	jr z, .copyLoop

	reg VBK, 1
	xor a
	ld de, VRAM_BG_START
	ld bc, 32 * 32
	call fillMemory
	reset VBK

	ld hl, $A000
	ld de, SCORE
	ld bc, 3
	call copyMemory

	call drawScore

	ld hl, mainMenuPal
	ld de, BGPI
	ld a, $80
	ld [de], a
	inc e
	ld b, 8 + 6
.bgPalLoop:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .bgPalLoop
	xor a
	ld [de], a
	ld [de], a

	ld b, 8
	ld hl, logoPal
.bgPalLoop2:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .bgPalLoop2

	ld hl, $9844
	ld de, LogoMap
	ld b, 12
.copyLoop2:
	reg VBK, 1
	ld a, [de]
	add (EndMMChr - MainMenuChrs) / $10
	inc de
	ld [hl], 2
	ld c, a
	reset VBK
	ld a, c
	ld [hli], a
	dec b
	jr nz, .copyLoop2
	ld bc, $20 - 12
	add hl, bc
	ld b, 12
	ld a, $E4
	cp l
	jr nz, .copyLoop2

	reg LCD_CONTROL, %11110010

.loop:
	reset INTERRUPT_REQUEST
	ld [SCROLL_PAST_TILE], a
	halt
	ld hl, LY
	ld a, $90
	cp [hl]
	jr nc, .loop

	call getKeys
	bit SELECT_BIT, a
	jp z, showCredits
	bit START_BIT, a
	jr nz, .loop

game::
	call waitVBLANK
	reset LCD_CONTROL

	ld hl, SpriteInitArray
	ld bc, $18
	ld de, SPRITES_BUFFER
	call copyMemory

	ld de, VRAM_START
	ld hl, BackgroundChrs
	ld bc, NumbersSprite - BackgroundChrs
	call copyMemory

	ld de, BGPI
	ld a, $80
	ld [de], a
	inc e
	ld b, 8 * 3
	ld hl, bgPal
.bgPalLoop:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .bgPalLoop

	inc e
	ld a, $80
	ld [de], a
	inc e
	ld b, 8 * 3
.objPalLoop:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .objPalLoop

initGame:
	ld de, PLAYING_MUSICS
	ld hl, SleepingTheme
	call startMusic

	xor a
	ld de, FRAME_COUNTER
	ld bc, MAX_SCROLL_COUNTER - FRAME_COUNTER + 1
	call fillMemory

	ld de, SPRITES_BUFFER + $18
	ld bc, $A0 - $18
	call fillMemory

	reg PLAYER_Y, $60
	call moveSprites

	reg ANIMATION_COUNTER, 5
	reg MAX_SCROLL, 1
	reset SCROLL_X
	reg MOON_POS, $80

	call waitVBLANK
	reset LCD_CONTROL
	ld [BG_1_POS], a
	ld [BG_2_POS], a
	ld [BG_1_POS_COUNTER], a

	ld hl, LEFT_MAP_PTR
	ld a, (BackgroundTileMap) & $FF
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0 + 23) & $FF
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0 + 23) >> 8
	ld [hli], a

	ld a, $60
	ld de, GROUND_POS_X8
	ld bc, 25
	call fillMemory

	call copyBgMap

	;reg VBK, 1
	;ld a, 1
	;ld de, $99C0
	;ld bc, 23
	;call fillMemory

	reset VBK
	ld a, (GroundSprite - BackgroundChrs) / $10
	ld de, $99C0
	ld bc, 23
	call fillMemory

	reg CLOCK_ANIM, 1
	reg LYC, 68
	reg STAT_CONTROL, %01000000

	reg LCD_CONTROL, %11110011
gameLoop:
	reset INTERRUPT_REQUEST
	ld [SCROLL_PAST_TILE], a
	halt
	ld hl, LY
	ld a, $90
	cp [hl]
	jr nc, gameLoop

	ld hl, CLOCK_ANIM
	dec [hl]
	jr nz, .skip
	ld [hl], 60
	ld hl, $9c22
	ld a, [hl]
	xor %00111010
	ld [hli], a
	inc l
	inc l
	ld a, [hl]
	xor %00111010
	ld [hli], a
.skip:
	ld hl, SPAWN_COUNTER
	ld a, [CURRENT_SCROLL]
	add [hl]
	ld b, a
	and %00000111
	ld [hl], a

	ld a, b
	and %11111000
	jr z, .noSpawn
	; ground height
	; création new tile

	reg SCROLL_PAST_TILE, 1

	; Remove the block at the left of the screen
	ld a, [GROUND_POS_X8]
	add $10
	ld c, a
	ld a, 0
	adc 0
	ld b, a
	sla c
	rl b
	sla c
	rl b
	ld hl, LEFT_MAP_PTR
	ld a, [hl]
	inc [hl]
	and 31
	add c
	ld c, a
	ld hl, $9800
	add hl, bc
	ld d, h
	ld e, l
	ld hl, BackgroundTileMap
	add hl, bc
	ld a, [hl]
	ld [de], a

	ld hl, RIGHT_MAP_PTR
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], (GroundSprite - BackgroundChrs) / $10
;	reg VBK, 1
;	ld [hl], 1
;	reset VBK
.noSpawn:
	call drawScore
	call scrollBg

	; Animation
	ld hl, ANIMATION_COUNTER
	dec [hl]
	call z, animatePlayerMoon

	call updateSpikes
	call displaySpikes

	call incrementScore

	ld a, e
	and $10
	xor d
	call nz, updateBgSpeed
	call updatePlayerState

	call getKeys
	bit DOWN_BIT, a
	jr nz, .noDown
	ld hl, PLAYER_SPEED_Y
	inc [hl]
.noDown:
	bit A_BIT, a
	call z, playerJump
	bit UP_BIT, a
	call z, playerJump

	ld a, [SCROLL_PAST_TILE]
	or a
	jr z, .calcNextScroll

	call createNewTile
	ld hl, GROUND_POS_X8
	call shiftTiles

	call random
	and %11
	jr nz, .calcNextScroll

	ld d, a
	ld hl, NB_SPIKES
	inc [hl]
	ld a, [hl]
	ld e, a
	sla e
	add hl, de
	ld a, [CURRENT_SCROLL]
	ld b, a
	ld a, $C0
	sub b
	ld [hld], a
	ld a, [GROUND_POS_X8 + 23]
	ld [hl], a

.calcNextScroll:
	call calcNextScroll
	jp gameLoop


include "src/init.asm"
include "src/interrupts.asm"
include "src/sound/music.asm"
include "src/sound/sfx.asm"
include "src/gameOver.asm"
include "src/spikes.asm"
include "src/gameLogic.asm"
include "src/rendering.asm"
include "src/sound/alarm_musics/alarm_one/main.asm"
include "src/sound/alarm_musics/alarm_two/main.asm"
include "src/sound/main_menu_music/main.asm"

include "src/sound/sfx/sfxs.asm"
include "src/sound/sleeping_music/main.asm"
include "src/utils.asm"