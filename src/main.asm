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

	ld a, $FF
	ld hl, SOUND_TERM_CONTROL
	writeRegisterI a
	writeRegisterI a
	writeRegisterI a
	ld de, PLAYING_MUSICS
	ld hl, SleepingTheme
	call startMusic

	reg WX, $78
	reg WY, $88

initGame:
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

	ld hl, LEFT_MAP_PTR
	ld a, (BackgroundTileMap + $1C0) & $FF
	ld [hli], a
	ld a, (BackgroundTileMap + $1C0) >> 8
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0) & $FF
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0) >> 8
	ld [hli], a
	ld a, (BackgroundTileMap + $1C0 + 21) & $FF
	ld [hli], a
	ld a, (BackgroundTileMap + $1C0 + 21) >> 8
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0 + 21) & $FF
	ld [hli], a
	ld a, (VRAM_BG_START + $1C0 + 21) >> 8
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

	reg VBK, 1
	ld a, 1
	ld de, $99C0
	ld bc, 22
	call fillMemory

	reset VBK
	ld a, (GroundSprite - BackgroundChrs) / $10
	ld de, $99C0
	ld bc, 22
	call fillMemory

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

	ld hl, SPAWN_COUNTER
	ld a, [CURRENT_SCROLL]
	add [hl]
	ld b, a
	and %00000111
	ld [hl], a

	ld a, b
	and %11111000
	jr z, .noSpawn

	reg SCROLL_PAST_TILE, 1

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
	ld a, [GROUND_POS_X8 + 20]
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
include "src/sound/sfx/sfxs.asm"
include "src/sound/krool_music/main.asm"
include "src/utils.asm"