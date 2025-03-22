
 ; rts in case this source is run
 rts

test_suite
 dc.l LSL_B_register_by_immediate
 dc.l LSL_B_register_by_immediate_FAIL
 dc.l ADDI_W_immediate_data_to_absolute_long
 ; no more tests
 dc.l	$0

;======================================

LSL_B_register_by_immediate
 dc.l .name		; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "LSL_B_register_by_immediate",0
 even


.arrange_mem
 ; length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000001,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.arrange_code
 ; length,address
 dc.l $00000001,$00070000
 dc.b $ed,$08 ; LSL.B #6,D0

.assert_mem
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000040,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.assert_code
 LSL.B #6,D0

;======================================

LSL_B_register_by_immediate_FAIL

 dc.l .name		; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "LSL_B_register_by_immediate_FAIL",0
 even

.arrange_mem
 ; length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000001,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.arrange_code
 ; length,address
 dc.l $00000001,$00070000
 dc.b $ed,$08

.assert_mem
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000040,$00000001,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.assert_code
  LSL.B #6,D1

;======================================

ADDI_W_immediate_data_to_absolute_long

 dc.l .name		; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "ADDI_W_immediate_data_to_absolute_long",0
 even

.arrange_mem
 ; length,address,ptr
 dc.l $00000002,$00040000,.arrange_mem_00040000
 dc.l $00000000

.arrange_mem_00040000
 dc.b $3c,$09

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.arrange_code
 ; length,address
 dc.l $00000004,$00070000
 dc.b $06,$79,$38,$78,$00,$04,$00,$00

.assert_mem
 dc.l $00000002,$00040000,.assert_mem_00040000
 dc.l $00000000

.assert_mem_00040000
 dc.b $74,$81

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.l $00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
 dc.w $0000 ; SR -----

.assert_code
 ADDI.W #$3878,($00040000).L
