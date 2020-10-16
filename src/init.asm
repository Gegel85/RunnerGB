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
	pop de
	ld sp, $FFFF
	push de

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

	reg OBP0, %10010000
	reg OBP1, %10000100
	reg BGP, $E4

	pop de
	ld sp, $E000
	push de

	ei
	ret