jumpSfx::
	db 0                       ; Channel (0-3)
	db $20                     ; Sound duration in frames
	db $77, $C1, $73, $72, $86 ; Sound data copied in channel registers