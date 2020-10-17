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
;    d  -> Not preserved
;    e  -> Preserved
;    hl -> Not preserved
updatePlayerState::
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
	ld d, a
	ret

.onGround:
	ld a, $62
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