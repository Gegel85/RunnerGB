SECTION "crash", ROM0
	jp crash

SECTION "vblank", ROM0
	jp vblank_interrupt

SECTION "hblank", ROM0
	jp hblank_interrupt

SECTION "timer", ROM0
	jp timer_interrupt

SECTION "serial", ROM0
	jp serial_interrupt

SECTION "joypad", ROM0
	jp joypad_interrupt

crash::
	ld b, b
	ld hl, $FF44
	ld a, $90
	cp [hl]
	jr nc, crash

	dec l
	xor a
	ld [hld], a
	ld [hl], a

	ld hl, crashText
	ld c, 22
	ld de, $9800
.loop:
	ld a, [hli]
	ld [de], a
	inc e
	dec c
	jr nz, .loop
	jp lockup

SECTION "Start", ROM0
	nop
	jp main

SECTION "Header", ROM0
	ds $150 - $104
