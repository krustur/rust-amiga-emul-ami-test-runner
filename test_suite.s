
test_suite
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	; no more tests
	dc.l	$0

test_offs_name		equ	$00
test_offs_arrange_mem	equ	$04
test_offs_arrange_regs	equ	$08
test_offs_code		equ	$0c
test_offs_assert_mem	equ	$10
test_offs_assert_regs	equ	$14

LSL_B_register_by_immediate
 dc.l .name		; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .code		; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14

 dc.l .name_fail	; $00 ; LSL_B_register_by_immediate_fail
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .code_fail	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14

.name
 dc.b "LSL_B_register_by_immediate",0
 even

.name_fail
 dc.b "LSL_B_register_by_immediate_FAIL",0
 even

.arrange_mem
 ; size,address,ptr
 ; dc.bytes!
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000001,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.code
 ; size,address
 dc.l $00000001,$00070000
 LSL.B #6,D0
 dc.b $ed,$08

.code_fail
 ; size,address
 dc.l $00000001,$00070000
 LSL.B #6,D0
 dc.b $ed,$09

.assert_mem
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000040,$00000001,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----
