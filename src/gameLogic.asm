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
	ld a, [GROUND_POS_X8]
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
	xor a
	ld d, a
	ret

.onGround:
	ld a, e
	ld [hli], a

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
;    de -> Preserved
;    hl -> Preserved
createNewTile::
	ld a, 1 ;the amount of tile to add/sub
	ld b, a
	call random
    bit 0, a
	jr z, .incValue

.decValue:
	ld a, [GROUND_POS + 21]
	sub b
	jr .checkNewTile
.incValue:
	ld a, [GROUND_POS + 21]
	add b
	jr .checkNewTile
.setMaxHeight:
	ld b, $20
	jr .checkNewTile

.setMinHeight:
	ld b, $0C
	jr .saveNewTile

.checkNewTile:
	; min should be 0x4 and max 0x0C
	ld b, a
	sub $4 ; to avoid too high ground
	jr c, .setMaxHeight
	ld a, b
	sub $0C
	jr nc, .setMinHeight
.saveNewTile:
	ld a, b
	ld [GROUND_POS + 21], a
	sla a
	sla a
	sla a
	ld [GROUND_POS_X8 + 21], a
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
	ld b, 21
.loop:
	inc hl
	ld a, [hl]
	dec hl
	ld [hl], a
	inc hl
	dec b

	jr nz, .loop
	ret