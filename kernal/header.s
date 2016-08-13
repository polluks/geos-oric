; GEOS KERNAL
;
; KERNAL header and reboot from BASIC

.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"

.global BootKernal
.global dateCopy
.global sysFlgCopy

.segment "header"

.assert * = $C000, error, "Header not at $C000"

BootKernal:
	jmp _BootKernal
	jmp InitKernal

bootName:
	.byte "GEOS BOOT"
version:
	.byte $20
nationality:
	.byte $00,$00
sysFlgCopy:
	.byte $00
c128Flag:
	.byte $00

	.byte $05,$00,$00,$00 ; ???

dateCopy:
.ifdef maurice
	.byte 92,3,23
.else
	.byte 88,4,20
.endif

_BootKernal:
	bbsf 5, sysFlgCopy, BootREU
	jsr $FF90
	lda #version-bootName
	ldx #<bootName
	ldy #>bootName
	jsr $FFBD
	lda #$50
	ldx #8
	ldy #1
	jsr $FFBA
	lda #0
	jsr $FFD5
	bcc _RunREU
	jmp ($0302)
BootREU:
	ldy #8
BootREU1:
	lda BootREUTab,Y
	sta EXP_BASE+1,Y
	dey
	bpl BootREU1
BootREU2:
	dey
	bne BootREU2
_RunREU:
	jmp RunREU
BootREUTab:
	.word $0091
	.word $0060
	.word $007e
	.word $0500
	.word $0000
