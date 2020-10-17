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

	ld c, a
	ld a, [CURRENT_SCROLL]
	ld d, a
	xor a
	ld b, a
.updateSpikeLoop:
	inc hl
	ld a, [hl]
	sub d
	ld [hli], a

	cp 40
	jr c, .nextSpike
	cp 43
	jr nc, .nextSpike
	ld b, a
	ld a, [PLAYER_Y]
	cp $60
	jr nc, gameOver

.nextSpike:
	dec c
	jr nz, .updateSpikeLoop

	ld a, [SPIKES + 1]
	cp a, $F9
	jr nc, .keepSpike
	cp a, $C0
	jr c, .keepSpike

	ld hl, NB_SPIKES
	ld a, [hl]
	dec a
	ld [hl], a
	ret z

	push af
	ld de, SPIKES
	ld hl, SPIKES + 2
	ld b, 0
	sla a
	ld c, a
	call copyMemory
	pop af
	ld e, a
.keepSpike:
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
	ld hl, NB_SPIKES
	xor a
	or [hl]
	ret z
	ld b, a
	ld hl, SPRITES_BUFFER + $18
	ld de, SPIKES
.displayLoop:
	ld a, [de]
	inc de
	add $18
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, (SpikeSprite - BackgroundChrs) / $10
	ld [hli], a
	ld a, 2
	ld [hli], a
	dec b
	jr nz, .displayLoop
	jr .delLastSprite

.noSpikes:
	ld hl, SPRITES_BUFFER + $18
.delLastSprite:
	xor a
	ld [hli], a
	ret