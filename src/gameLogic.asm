; Change the game speed
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Preserved
;    hl -> Preserved
updateBgSpeed:
	ld hl, MAX_SCROLL_COUNTER
	ld a, [hl]
	dec a
	and $3
	ld [hld], a
	cp 3
	ret nz

	dec hl
	dec hl
	inc [hl]
	ret


; Increment the score according to the game speed
; Params:
;    None
; Return:
;    d -> The second score byte before increment
;    e -> The second score byte after increment
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
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
	ld e, a

	ld a, [hl]
	adc $0
	daa
	ld [hli], a
	ret


; Update the player state, apply speed to pos and gravity to speed
; Params:
;    None
; Return:
;    d -> 0 if the player is not able to jump, else a non 0 value
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    de -> Not preserved
;    hl -> Not preserved
updatePlayerState::
	ld a, [GROUND_POS_X8 + 5]
	ld e, a
	ld hl, PLAYER_SPEED_Y
	ld a, [hld]
	add [hl]
	ld [hl], a
	cp e
	jr nc, .onGround

	inc hl
	inc hl
	dec [hl]
	ld a, [hld]
	and %111
	jr nz, .noSpeedChange
	inc [hl]
.noSpeedChange:
	ld de, 4
	ld hl, SPRITES_BUFFER + $02
	set 2, [hl]
	add hl, de
	set 2, [hl]
	ret

.onGround:
	ld a, e
	ld [hli], a
	ld de, 4
	push hl
	ld hl, SPRITES_BUFFER + $02
	res 2, [hl]
	add hl, de
	res 2, [hl]
	pop hl

.resetSpeed:
	ld d, a
	xor a
	ld [hli], a
	ld [hli], a
	ret


; Makes the player jump
; Params:
;    d -> 0 if the player is not able to jump, else a non 0 value
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    de -> Preserved
;    hl -> Not preserved
playerJump:
	call random
	ld a, d
	or a
	ret z

	ld hl, jumpSfx
	call playSfx
	reg PLAYER_SPEED_Y, -2
	ret


; Calculates the next scroll (in pixels)
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    b  -> Not preserved
;    c  -> Preserved
;    de -> Preserved
;    hl -> Not preserved
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
	ret


; Set the height value for the next ground tile
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    b  -> Not preserved
;    c  -> Preserved
;    d  -> Not preserved
;    hl -> Preserved
createNewTile::
	ld d, $FF
	call random
	ld b, a
	and %110

	ld hl, GROUND_POS_X8 + 24
	ld a, [hl]
	jr nz, .saveNewTile

	bit 0, b
	jr z, .incValue

.decValue:
	cp $08 * 8 ; to avoid too high ground
	jr c, .saveNewTile
	sub 8
	ld d, 0
	jr .saveNewTile
.incValue:
	cp $D * 8
	jr z, .saveNewTile
	add 8
	ld d, 1
.saveNewTile:
	ld [hl], a

	ld hl, RIGHT_MAP_PTR
	ld a, [hli]
	push hl
	ld h, [hl]
	ld b, a
	inc a
	and 31
	ld l, a
	ld a, ~31
	and b
	or l
	ld l, a

	bit 1, d
	jr nz, .save

	bit 0, d
	jr z, .sub

	ld de, $20
	jr .end
.sub:
	ld de, -$20
.end:
	add hl, de
.save:
	ld b, l
	ld a, h
	pop hl
	ld [hld], a
	ld [hl], b
	ret

; Shift all the tiles of GROUND_POS and GROUND_POS_X8
; Params:
;    hl -> startAddress
; Return:
;    None
; Registers:
;    af -> Not preserved
;    b  -> Not preserved
;    c  -> Preserved
;    de -> Preserved
;    hl -> Not preserved
shiftTiles::
	ld b, 24
.loop:
	inc hl
	ld a, [hld]
	ld [hli], a
	dec b

	jr nz, .loop
	ret

showCredits::
	call waitVBLANK
	reset LCD_CONTROL
	reg BGP, $E4

	ld hl, NumbersCredits
    ld de, VRAM_START
    ld bc, EndNumbersCredits - NumbersCredits
	call copyMemory

	ld b, 18
	push hl
	ld hl, VRAM_BG_START
	ld de, CreditsMap
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

	; palettes
	ld hl, creditsPal
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

	reg LCD_CONTROL, %11010001

.creditsLoop:
	reset INTERRUPT_REQUEST
	ld [SCROLL_PAST_TILE], a
	halt
	ld hl, LY
	ld a, $90
	cp [hl]
	jr nc, .creditsLoop

	call getKeys
    cpl
    or a
    jp nz, mainMenu
    jr .creditsLoop