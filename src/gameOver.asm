gameOver::
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
.loop:
	halt
	ld hl, LY
	ld a, $90
	cp [hl]
	jr nc, .loop
	ld a, [BG_1_POS]
	ld [SCROLL_X], a
	call getKeys
	bit START_BIT, a
	jp z, initGame
	jr .loop
