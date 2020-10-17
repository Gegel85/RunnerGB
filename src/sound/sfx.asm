updateSfx::
	ld b, 4
	ld c, $10
	ld a, 6
	ld d, 0
	ld e, d
	ld hl, PLAYING_SFX_TIMERS
	push af
.loop:
	xor a
	or [hl]
	jr z, .skip

	dec [hl]
	jr nz, .skip

	pop af
	push af
	push bc
	push de
	push hl
	ld hl, PLAYING_MUSICS
	add hl, de
	set 1, [hl]

	ld d, $FF
	ld h, $CD
	ld e, c
	ld l, c
	ld b, a
	bit 2, b
	jr z, .restoreLoop
	dec b
.restoreLoop:
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .restoreLoop

	ld b, 3
	ld b, b
	ld e, $24
	ld l, e
.restoreLoop2:
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .restoreLoop2

	pop hl
	pop de
	pop bc
.skip:
	ld a, e
	add MUSIC_STRUCT_SIZE
	ld e, a

	pop af
	push af
	add c
	ld c, a

	pop af
	xor 2
	push af
	inc hl
	dec b
	jr nz, .loop
	pop af
	ret

; Plays a sound effect
; Params:
;    hl -> Pointer to the SFX struct
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
playSfx::
	reg CHAN_TERM_SELECT, $FF
	di
	ld a, [hli]
	ld c, a
	sla a
	sla a
	add c
	ld e, a

	ld a, [hli]
	push hl
	push de
	ld b, 0
	ld hl, PLAYING_SFX_TIMERS
	add hl, bc
	ld [hl], a

	ld de, MUSIC_STRUCT_SIZE
	ld hl, PLAYING_MUSICS
	ld a, c
.addLoop:
	or a
	jr z, .endLoop
	add hl, de
	dec a
	jr .addLoop
.endLoop:
	res 1, [hl]

	pop de
	ld d, 0
	ld hl, registersProperties
	add hl, de
	ld d, h
	ld e, l
	pop hl

	ld a, [de]
	ld b, a
	inc de

	ld a, [de]
	inc de
	ld c, a

	ld a, [de]
	ld d, a
	ld e, c

.regInitLoop:
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .regInitLoop
	ei
	ret