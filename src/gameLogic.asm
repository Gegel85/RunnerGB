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
	ld a, [GROUND_POS_X8 + 3]
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
;    d  -> Not preserved
;    hl -> Preserved
createNewTile::
	ld d, $FF
	call random
	ld b, a
	and %110

	ld hl, GROUND_POS + 21
	ld a, [hl]
	jr nz, .checkNewTile

	bit 0, b
	jr z, .incValue

.decValue:
	dec a
	ld d, 0
	jr .checkNewTile
.incValue:
	inc a
	ld d, 1
	jr .checkNewTile
.setMaxHeight:
	ld a, $06
	jr .saveNewTile
.setMinHeight:
	ld a, $0F
	jr .saveNewTile

.checkNewTile:
	; min should be 0x4 and max 0x0C
	cp $06 ; to avoid too high ground
	jr c, .setMaxHeight
	cp $0F
	jr nc, .setMinHeight
.saveNewTile:
	ld [hl], a
	sla a
	sla a
	sla a
	ld [GROUND_POS_X8 + 21], a

	bit 1, d
	ret nz
	ld a, [RIGHT_MAP_SRC_TILES]
	bit 0, d
	jr z, .sub
	add a, $20
	jr .end
.sub:
	sub a, $20

.end:
	ld [RIGHT_MAP_SRC_TILES], a
	ret nc
	ld a, [RIGHT_MAP_SRC_TILES + 1]
	jr z, .sub2
	add a, $20
	jr .end
.sub2:
	sub a, $20
.end2:
	ld [RIGHT_MAP_SRC_TILES + 1], a
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
	ld a, [hld]
	ld [hli], a
	dec b

	jr nz, .loop
	ret