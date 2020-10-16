include "src/constants.asm"
include "src/macro.asm"

SECTION "Main", ROM0


copyBgMap::
	xor a
	push af
	ld hl, BackgroundTileMap
	ld de, VRAM_BG_START
.copyLoop:
	ld c, 16
.copyLoop2:
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copyLoop2

	pop af
	xor 1
	push af
	jr z, .skip

	push bc
	ld bc, -16
	add hl, bc
	pop bc
	jr .copyLoop
.skip:
	bit 2, d
	jr z, .copyLoop
	pop af
	ret

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

moveSprites:
	ld de, 4
	ld hl, SPRITES_BUFFER

	; Player
	ld a, [PLAYER_Y]
	add $10
	ld [hl], a
	add hl, de
	add $8
	ld [hli], a
	add hl, de

	; Moon
	ld a, [MOON_POS]
	ld [hl], a
	add hl, de
	ld [hl], a
	add hl, de
	add a, 8
	ld [hl], a
	add hl, de
	ld [hl], a
	add hl, de
	ret

SpriteInitArray::
	db 114,      40, (PlayerSprite - BackgroundChrs) / $10    , 0
	db 114 + 8,  40, (PlayerSprite - BackgroundChrs) / $10 + 1, 0
	db 24     , $80,   (MoonSprite - BackgroundChrs) / $10    , 1 << 4
	db 24 + 8 , $80,   (MoonSprite - BackgroundChrs) / $10 + 1, 1 << 4
	db 24     , $88,   (MoonSprite - BackgroundChrs) / $10 + 2, 1 << 4
	db 24 + 8 , $88,   (MoonSprite - BackgroundChrs) / $10 + 3, 1 << 4

; Main function
main::
	call init

game::
	ld hl, SpriteInitArray
	ld bc, main - SpriteInitArray
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

	ld hl, SpriteInitArray
	ld bc, main - SpriteInitArray
	ld de, SPRITES_BUFFER
	call copyMemory

.init:
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

drawScore:
	ld de, SCORE
	ld hl, VRAM_WIN_START + $06
.loop:
	ld a, [de]
	inc de
	ld b, a
	swap b
	and %00001111
	or $80
	dec l
	ld [hld], a
	ld a, b
	and %00001111
	or $80
	ld [hl], a
	xor a
	or l
	jr nz, .loop

incrementScore:
	ld hl, SCORE
	ld a, [CURRENT_SCROLL]
	ld b, a

	ld a, [hl]
	add b
	daa
	ld [hli], a

	ld a, [hl]
	push af
	and $10
	ld d, a
	pop af
	adc $0
	daa
	ld [hli], a

	ld a, [hl]
	adc $0
	daa
	ld [hli], a

updateBgSpeed:
	ld a, [SCORE + 1]
	and $10
	xor d
	jr z, scrollBg

	ld hl, MAX_SCROLL_COUNTER
	ld a, [hl]
	dec a
	and $3
	ld [hld], a
	cp 3
	jr nz, scrollBg

	dec hl
	dec hl
	inc [hl]

scrollBg:
	ld a, [CURRENT_SCROLL]
	ld hl, SCROLL_X
	add [hl]
	ld [hl], a
	call moveSprites

handleAnimations:
	; Animation
	ld a, [CURRENT_SCROLL]
	ld hl, ANIMATION_COUNTER
	dec [hl]
	jr nz, playerGravity

	ld d, a
	ld hl, MOON_POS
	dec [hl]

	ld hl, SPRITES_BUFFER + $07
	ld a, 1 << 5
	xor [hl]
	ld [hl], a

	ld a, d
	dec a
	sla a

	ld d, a
	ld a, 5
	sub d

	ld [ANIMATION_COUNTER], a

playerGravity:
	ld hl, PLAYER_SPEED_Y
	ld a, [hld]
	add [hl]
	ld [hl], a
	cp $62
	jr nc, .onGround

	inc hl
	inc hl
	dec [hl]
	ld a, [hld]
	and %111
	jr nz, .noSpeedChange
	inc [hl]
.noSpeedChange:
	xor a
	push af
	jr controlPlayer

.onGround:
	ld a, $62
	ld [hli], a

.resetSpeed:
	push af
	xor a
	ld [hli], a
	ld [hli], a

controlPlayer:
	call getKeys
	bit DOWN_BIT, a
	jr nz, .noDown
	ld hl, PLAYER_SPEED_Y
	inc [hl]
.noDown:
	bit A_BIT, a
	jr z, .jump
	bit UP_BIT, a
	jr nz, .noJump
.jump:
	call random
	pop af
	or a
	jr z, updateSpikes

	ld hl, jumpSfx
	call playSfx
	reg PLAYER_SPEED_Y, -2
	jr updateSpikes
.noJump:
	pop af

updateSpikes:
	ld hl, NB_SPIKES
	ld a, [hli]
	and a
	jp z, displaySpikes.noSpikes
	ld e, a
	ld c, a
	ld a, [CURRENT_SCROLL]
	ld d, a
	xor a
	ld b, a
.updateSpikeLoop:
	ld a, [hl]
	sub d
	ld [hli], a
	cp a, $F9
	jr nc, .keepSpike
	cp a, $C0
	jr c, .keepSpike

	push hl
	push hl
	ld hl, NB_SPIKES
	dec [hl]
	pop hl

	dec e
	jr z, displaySpikes.noSpikes

	push de
	push bc

	ld d, h
	ld e, l
	dec de
	call copyMemory

	pop bc
	pop de
	pop hl
	dec hl

	jr .nextSpike
.keepSpike:
	cp 40
	jr c, .nextSpike
	cp 43
	jr nc, .nextSpike
	ld b, a
	ld a, [PLAYER_Y]
	cp $60
	jr c, .nextSpike

	call moveSprites

	ld hl, SPRITES_BUFFER + $19
	ld d, 0
	ld a, [NB_SPIKES]
	sub c
	sla a
	sla a
	ld e, a
	add hl, de
	ld a, b
	ld [hl], a
.lockup::
	halt
	call getKeys
	bit START_BIT, a
	jp z, game.init
	jr .lockup
.nextSpike:
	dec c
	jr nz, .updateSpikeLoop

displaySpikes:
	ld b, e
	ld hl, SPRITES_BUFFER + $18
	ld de, SPIKES
.displayLoop:
	ld a, 121
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, (SpikeSprite - BackgroundChrs) / $10
	ld [hli], a
	ld a, 0
	ld [hli], a
	dec b
	jr nz, .displayLoop
	jr .delLastSprite

.noSpikes:
	ld hl, SPRITES_BUFFER + $18
.delLastSprite:
	xor a
	ld [hl], a

spawnSpike:
	ld hl, SPAWN_COUNTER
	ld a, [CURRENT_SCROLL]
	add [hl]
	ld [hl], a
	and %11100000
	jr z, calcNextScroll

	call random
	and %1111
	jr nz, calcNextScroll

	ld [hl], a
	ld d, a
	ld hl, NB_SPIKES
	inc [hl]
	ld a, [hl]
	ld e, a
	add hl, de
	ld [hl], $C0

calcNextScroll:
	ld a, [MAX_SCROLL]
	ld b, a
	ld hl, SCROLL_COUNTER
	xor a
	or [hl]
	jr z, .fullSpeed

	dec [hl]
	dec b
	jr .scroll

.fullSpeed:
	ld hl, MAX_SCROLL_COUNTER
	ld a, [hld]
	ld [hl], a

.scroll:
	ld a, b
	ld [CURRENT_SCROLL], a
	jp gameLoop


include "src/interrupts.asm"
include "src/init.asm"
include "src/sound/music.asm"
include "src/sound/sfx.asm"
include "src/sound/sfx/sfxs.asm"
include "src/sound/krool_music/main.asm"
include "src/utils.asm"