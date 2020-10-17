gameOver::
	halt
	call getKeys
	bit START_BIT, a
	jp z, initGame
	jr gameOver
