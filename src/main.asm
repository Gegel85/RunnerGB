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
	reg INTERRUPT_ENABLED, JOYPAD_INTERRUPT
	halt
	jr lockup

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
	;ld de, PLAYING_MUSICS
	;ld hl, kingKRoolTheme
	;call startMusic


	reg WX, $78
	reg WY, $88

	reg MOON_POS, $80

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
	ld [MOON_POS], a

	call waitVBLANK
	reset LCD_CONTROL

	ld a, $C
	ld de, GROUND_POS
	ld bc, 21
	call fillMemory

	ld a, $60
	ld de, GROUND_POS_X8
	ld bc, 21
	call fillMemory

	call copyBgMap

	ld a, $6A
	ld de, $99C0
	ld bc, 20
	call fillMemory
	reg LCD_CONTROL, %11110011
gameLoop:
	halt
	ld hl, LY
	ld a, $90
	cp [hl]
	jr nc, gameLoop

	reset INTERRUPT_REQUEST

	call drawScore
	call scrollBg
	call updateSpikes
	call displaySpikes

	; Animation
	ld hl, ANIMATION_COUNTER
	dec [hl]
	call z, animatePlayerMoon

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
	sla e
	add hl, de
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