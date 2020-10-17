; Update all spikes
; Params:
;    None
; Return:
;    e -> The number of spikes after update
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
updateSpikes:
	ld hl, NB_SPIKES
	ld a, [hli]
	and a
	ret z

	ld e, a
	ld c, a
	ld a, [CURRENT_SCROLL]
	ld d, a
	xor a
	ld b, a
.updateSpikeLoop:
	ld a, [hl]
	sub d
	ld [hli], a
	cp a, $F9
	jr nc, .keepSpike
	cp a, $C0
	jr c, .keepSpike

	push hl
	ld hl, NB_SPIKES
	dec [hl]
	pop hl

	dec e
	ret z

	add sp, -2
	push de
	push bc

	ld d, h
	ld e, l
	dec de
	call copyMemory

	pop bc
	pop de
	pop hl
	dec hl

	jr .nextSpike
.keepSpike:
	cp 40
	jr c, .nextSpike
	cp 43
	jr nc, .nextSpike
	ld b, a
	ld a, [PLAYER_Y]
	cp $60
	jr c, .nextSpike

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
	jp gameOver

.nextSpike:
	dec c
	jr nz, .updateSpikeLoop
	or 1
	ret


; Display all spikes
; Params:
;    e -> Number of spikes to show
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
displaySpikes:
	ld b, e
	ld hl, SPRITES_BUFFER + $18
	ld de, SPIKES
.displayLoop:
	ld a, 121
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, (SpikeSprite - BackgroundChrs) / $10
	ld [hli], a
	ld a, 0
	ld [hli], a
	dec b
	jr nz, .displayLoop
	jr .delLastSprite

.noSpikes:
	ld hl, SPRITES_BUFFER + $18
.delLastSprite:
	xor a
	ld [hl], a
	ret