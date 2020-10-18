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
;    None
; Return:
;    None
; Registers:
;    N/A
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

game::
	ld hl, SpriteInitArray
	ld bc, $18
	ld de, SPRITES_BUFFER
	call copyMemory

	reg WX, 167 - 70
	reg WY, 144 - 18

	ld hl, $9C00
	ld de, ScoreZoneMap
	ld bc, $20 - 9
.copyLoop:
	ld a, [de]
	inc de
	add $88
	ld [hli], a
	bit 3, l
	jr z, .copyLoop
	bit 0, l
	jr z, .copyLoop
	add hl, bc
	bit 7, l
	jr z, .copyLoop

	reg VBK, 1
	ld a, 2
	ld de, $9C00
	ld bc, 200
	call fillMemory

	reset VBK

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
	ld a, (BackgroundTileMap + $1C0) & $FF
	ld [hli], a
	ld a, (BackgroundTileMap + $1C0) >> 8
	ld [hli], a
	ld a, 0
	ld [hli], a
	ld [hli], a
	ld a, (BackgroundTileMap + $1C0 + 22) & $FF
	ld [hli], a
	ld a, (BackgroundTileMap + $1C0 + 22) >> 8
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0 + 22) & $FF
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0 + 22) >> 8
	ld [hli], a

	ld a, $C
	ld de, GROUND_POS
	ld bc, 22
	call fillMemory

	ld a, $60
	ld de, GROUND_POS_X8
	ld bc, 22
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
	ld l, a
	ld h, 0
	sla l
	rl h
	sla l
	rl h
	ld de, $983F
	add hl, de ; hl now contains the right line, need to get the right collumn now.

	ld a, [LEFT_MAP_SRC_TILES]
	inc a
	cp $20
	jp nz, .noLeftOverflow
	ld a, 0
.noLeftOverflow:
	ld [LEFT_MAP_SRC_TILES], a
	ld e, a
	ld d, 0
	add hl, de
	ld b, b
	push hl ; hl now contains the position of the block to the left.

	ld hl, LEFT_MAP_PTR
	inc [hl]
	ld a, [hli]
	cp $C0 + 32
	; Oups, does not work.
	jp nz, .noIconOverflow
	ld [hl], $C0
	ld a, $C0
.noIconOverflow:
	ld h, [hl]
	ld l, a
	ld a, [hl]
	pop hl
	ld [hl], a

	; Create a new block at the right of the screen
	ld a, [RIGHT_MAP_SRC_TILES]
	inc a
	ld b, a
	; IF a ends with %1111 (aka $1F), the number is at the end of the line.
	and $1F
	ld a, b
	jp nz, .noOverflow
	sub $20
	and $F0
.noOverflow:
	ld [RIGHT_MAP_SRC_TILES], a
	ld l, a
	ld a, [RIGHT_MAP_SRC_TILES + 1]
	ld h, a

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
	ld hl, GROUND_POS
	call shiftTiles
	ld hl, GROUND_POS_X8
	call shiftTiles

	call random
	and %11
	jr nz, .calcNextScroll

;	ld d, a
;	ld hl, NB_SPIKES
;	inc [hl]
;	ld a, [hl]
;	ld e, a
;	sla e
;	add hl, de
;	ld a, [CURRENT_SCROLL]
;	ld b, a
;	ld a, $C0
;	sub b
;	ld [hld], a
;	ld a, [GROUND_POS_X8 + 20]
;	ld [hl], a

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
include "src/sound/sfx/sfxs.asm"
include "src/sound/sleeping_music/main.asm"
include "src/utils.asm"