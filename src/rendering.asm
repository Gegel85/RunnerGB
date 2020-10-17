; Scrolls the background and moves the player and moon sprites accordingly
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Ppreserved
;    de -> Not preserved
;    hl -> Not preserved
scrollBg::
	ld a, [CURRENT_SCROLL]
	ld hl, SCROLL_X
	add [hl]
	ld [hl], a

; Moves the player and moon sprites accordingly
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Ppreserved
;    de -> Not preserved
;    hl -> Not preserved
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

; The initial value of the sprite array
SpriteInitArray::
	db 114,      40, (PlayerSprite - BackgroundChrs) / $10    , 0
	db 114 + 8,  40, (PlayerSprite - BackgroundChrs) / $10 + 1, 0
	db 24     , $80,   (MoonSprite - BackgroundChrs) / $10    , 1 << 4
	db 24 + 8 , $80,   (MoonSprite - BackgroundChrs) / $10 + 1, 1 << 4
	db 24     , $88,   (MoonSprite - BackgroundChrs) / $10 + 2, 1 << 4
	db 24 + 8 , $88,   (MoonSprite - BackgroundChrs) / $10 + 3, 1 << 4

; Copy the background tile map in VRAM
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
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

; Draw the score on the window
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
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
	ret


; Animate the player and the moon
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    d  -> Not preserved
;    e  -> Preserved
;    hl -> Not preserved
animatePlayerMoon::
	ld hl, MOON_POS
	dec [hl]

	ld hl, SPRITES_BUFFER + $07
	ld a, 1 << 5
	xor [hl]
	ld [hl], a

	ld a, [CURRENT_SCROLL]
	dec a
	sla a

	ld d, a
	ld a, 5
	sub d

	ld [ANIMATION_COUNTER], a
	ret