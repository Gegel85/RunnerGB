include "src/constants.asm"
include "src/macro.asm"

SECTION "Main", ROM0

; Locks the CPU
; Params:
;    None
; Return:
;    None
; Registers:
;    N/A
lockup::
	reg INTERRUPT_ENABLED, JOYPAD_INTERRUPT
	halt
	jr lockup


; Main function
main::
	call init

game::
	ld hl, SpriteInitArray
	ld bc, $18
	ld de, SPRITES_BUFFER
	call copyMemory

	ld de, PLAYING_MUSICS
	ld hl, kingKRoolTheme
	call startMusic

	reg WX, $78
	reg WY, $88

	call copyBgMap
	reg LCD_CONTROL, %11110011
	reg MOON_POS, $80

initGame:
	ld a, [MOON_POS]
	push af

	xor a
	ld de, FRAME_COUNTER
	ld bc, MAX_SCROLL_COUNTER - FRAME_COUNTER + 1
	call fillMemory

	ld de, SPRITES_BUFFER + $18
	ld bc, $A0 - $18
	call fillMemory

	pop af
	ld [MOON_POS], a
	reg PLAYER_Y, $62
	call moveSprites

	reg ANIMATION_COUNTER, 5
	reg MAX_SCROLL, 1

gameLoop:
	halt
	ld hl, LY
	ld a, $90
	cp [hl]
	jr nc, gameLoop

	reset INTERRUPT_REQUEST

	call drawScore
	call incrementScore

	ld a, e
	and $10
	xor d
	call nz, updateBgSpeed
	call scrollBg

	; Animation
	ld hl, ANIMATION_COUNTER
	dec [hl]
	call z, animatePlayerMoon
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

	call updateSpikes
	call nz, displaySpikes

	ld hl, SPAWN_COUNTER
	ld a, [CURRENT_SCROLL]
	add [hl]
	ld [hl], a
	ld b, a
	and %11111000
	jr z, .calcNextScroll

	ld a, b
	and %00000111
	ld b, a
	ld [hl], a

	call random
	and %11
	jr nz, .calcNextScroll

	ld d, a
	ld hl, NB_SPIKES
	inc [hl]
	ld a, [hl]
	ld e, a
	add hl, de
	ld a, $C0
	sub b
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