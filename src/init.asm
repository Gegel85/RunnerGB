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
	reg INTERRUPT_ENABLED, VBLANK_INTERRUPT | TIMER_INTERRUPT

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
	ld bc, BackgroundTileMap - BackgroundChrs
	call copyMemory

	ld de, VRAM_START + $800
	ld hl, NumbersSprite
	ld bc, NumbersEnd - NumbersSprite
	call uncompress

        ld de, $FF80
        ld hl, initDMA
	ld bc, init - initDMA
        call copyMemory

	ld hl, BGPI
	ld a, $80
	ld [hli], a
	ld [hl], $FF
	ld [hl], $7F
	ld [hl], $B5
	ld [hl], $56
	ld [hl], $4a
	ld [hl], $29
	xor a
	ld [hl], a
	ld [hli], a

	set 7, a
	ld [hli], a
	ld [hl], $FF
	ld [hl], $7F
	ld [hl], $B5
	ld [hl], $56
	ld [hl], $4a
	ld [hl], $29
	xor a
	ld [hl], a
	ld [hl], a
	ld [hl], $FF
	ld [hl], $7F
	ld [hl], $B5
	ld [hl], $56
	ld [hl], $FF
	ld [hl], $7F
	ld [hl], $4a
	ld [hl], $29

	pop de
	ld sp, $E000
	push de

	ei
	ret