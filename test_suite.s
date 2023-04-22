;APS00001FDF00001FDF0000213400001F5100001FDF00001FDF00001FDF00001FDF00001FDF00001FDF
test_suite:
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate+$18
	; no more tests
	dc.l	$0

test_offset_name		equ	$00
test_offset_arrange_memory_list	equ	$04
test_offset_arrange_regs	equ	$08
test_offset_act_code		equ	$0c
test_offset_assert_memory_list	equ	$10
test_offset_assert_regs		equ	$14

LSL_B_register_by_immediate
 dc.l .name                  ; $00
 dc.l .arrange_memory_list   ; $04
 dc.l .arrange_regs          ; $08
 dc.l .act_code              ; $0c
 dc.l .assert_memory_list    ; $10
 dc.l .assert_regs           ; $14

; LSL_B_register_by_immediate_fail
 dc.l .name                  ; $00
 dc.l .arrange_memory_list   ; $04
 dc.l .arrange_regs          ; $08
 dc.l .act_code_fail         ; $0c
 dc.l .assert_memory_list    ; $10
 dc.l .assert_regs           ; $14

.name
 dc.b "LSL_B_register_by_immediate",0
 even

 ; Arrange

.arrange_memory_list
 ; address, size
 ; dc.bytes!
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7     D8/A8
 dc.l $00000001,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 ;    SR      "XNZVC"
 dc.w $0000 ; "-----"


 ; Act

.act_code
 ;    Code size/address
 dc.l $00000001,code_temp ; $00c00000
 ;    Code 
 dc.b $ed,$08	; LSL.B #6,D0

.act_code_fail
 ;    Code size/address
 dc.l $00000001,code_temp ; $00c00000
 ;    Code 
 LSL.B	#6,D1
 dc.b $ed,$08	; LSL.B #6,D0

 ; Assert

.assert_memory_list
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7     D8/A8
 dc.l $00000040,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 ;    SR      "XNZVC"
 dc.w $0000 ; "-----"
