initDMA::
        ld [START_DMA], a
        ld a, DMA_DELAY
.wait:
        dec a
        jr nz, .wait
        ret

WPRAM_init::
	db $00, $11, $22, $33, $44, $55, $66, $77
	db $88, $99, $AA, $BB, $CC, $DD, $EE, $FF

; Enable interrupts and init RAM
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
init::
	reg INTERRUPT_ENABLED, VBLANK_INTERRUPT | TIMER_INTERRUPT | LCD_STAT_INTERRUPT

	call waitVBLANK
	reset LCD_CONTROL

	xor a
	ld bc, $6000
	ld de, VRAM_START
	call fillMemory

	ld bc, $10
	ld hl, WPRAM_init
	ld de, $FF30
	call copyMemory

	ld de, VRAM_START
	ld hl, BackgroundChrs
	ld bc, NumbersSprite - BackgroundChrs
	call copyMemory

	ld de, VRAM_START + $A00
	ld hl, NumbersSprite
	ld bc, NumbersEnd - NumbersSprite
	call uncompress

        ld de, $FF80
        ld hl, initDMA
	ld bc, init - initDMA
        call copyMemory

	ld de, BGPI
	ld a, $80
	ld [de], a
	inc e
	ld b, 8 * 2
	ld hl, bgPal
.bgPalLoop:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .bgPalLoop

	inc e
	ld a, $80
	ld [de], a
	inc e
	ld b, 8 * 3
.objPalLoop:
	ld a, [hli]
	ld [de], a
	dec b
	jr nz, .objPalLoop

	pop de
	ld sp, $E000
	push de

	ei
	ret