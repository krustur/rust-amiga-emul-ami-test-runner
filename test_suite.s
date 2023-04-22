;APS00001FDF00001FDF0000213400001F5100001FDF00001FDF00001FDF00001FDF00001FDF00001FDF
test_suite:
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	dc.l	LSL_B_register_by_immediate
	; no more tests
	dc.l	$0

test_offset_name		equ	$00
test_offset_arrange_memory_list	equ	$04
test_offset_arrange_stack	equ	$08
test_offset_arrange_regs	equ	$0c
test_offset_act_code		equ	$10
test_offset_assert_memory_list	equ	$14
test_offset_assert_stack	equ	$18
test_offset_assert_regs		equ	$1c

LSL_B_register_by_immediate:
 dc.l .name                  ; $00
 dc.l .arrange_memory_list   ; $04
 dc.l .arrange_stack         ; $08
 dc.l .arrange_regs          ; $0c
 dc.l .act_code              ; $10
 dc.l .assert_memory_list    ; $14
 dc.l .assert_stack          ; $18
 dc.l .assert_regs           ; $1c

.name
 dc.b "LSL_B_register_by_immediate",0
 even

 ; Arrange

.arrange_memory_list
 ; address, size
 ; dc.bytes!
 dc.l $00000000

.arrange_stack
 ;    Stack size/address
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
 dc.l $00000002,code_temp ; $00c00000
 ;    Code 
 dc.b $ed,$08	; LSL.B #6,D0

 ; Assert

.assert_memory_list
 dc.l $00000000

.assert_stack
 
.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7     D8/A8
 dc.l $00000040,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 ;    SR "XNZVC"
 dc.b "-----",0
