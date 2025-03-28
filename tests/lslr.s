; ----------------------T----------------------------------

; Path: D:\Amiga\KrustWB3\Output\Dev\github\rust-amiga-emul-ami-test-runner\tests\lslr.s
; This file is autogenerated

 ;rts in case this source is run by mistake
 rts

;===========================================

this_test_is_for_testing_purposes_only
 dc.l .name	; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "this_test_is_for_testing_purposes_only",0
 even

.arrange_mem
 ;length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000001,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $001f ; ENZOC

.arrange_code
 ;length,address
 dc.l $00000001,$00040000
 dc.b $ED,$08

.assert_mem
 ;length,address,ptr
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000040,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $0000 ; -----

.assert_code
 LSL.B #$06,D0

;===========================================

lsl_b_register_by_immediate
 dc.l .name	; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "lsl_b_register_by_immediate",0
 even

.arrange_mem
 ;length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000001,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $001f ; ENZOC

.arrange_code
 ;length,address
 dc.l $00000001,$00040000
 dc.b $ED,$08

.assert_mem
 ;length,address,ptr
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000040,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $0000 ; -----

.assert_code
 LSL.B #$06,D0

;===========================================

lsl_register_by_immediate_byte_negative
 dc.l .name	; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "lsl_register_by_immediate_byte_negative",0
 even

.arrange_mem
 ;length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000003,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $001f ; ENZOC

.arrange_code
 ;length,address
 dc.l $00000001,$00040000
 dc.b $ED,$08

.assert_mem
 ;length,address,ptr
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $000000c0,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $0008 ; -N---

.assert_code
 LSL.B #$06,D0

;===========================================

lsl_register_by_immediate_byte_zero
 dc.l .name	; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "lsl_register_by_immediate_byte_zero",0
 even

.arrange_mem
 ;length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $001f ; ENZOC

.arrange_code
 ;length,address
 dc.l $00000001,$00040000
 dc.b $ED,$08

.assert_mem
 ;length,address,ptr
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$000000d7
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $0004 ; --Z--

.assert_code
 LSL.B #$06,D0

;===========================================

lsl_register_by_immediate_byte_extend_carry
 dc.l .name	; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "lsl_register_by_immediate_byte_extend_carry",0
 even

.arrange_mem
 ;length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$00000081
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $001f ; ENZOC

.arrange_code
 ;length,address
 dc.l $00000001,$00040000
 dc.b $E3,$0F

.assert_mem
 ;length,address,ptr
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$000000d6,$00000002
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $0011 ; E---C

.assert_code
 LSL.B #$01,D7

;===========================================

lsl_register_by_immediate_word
 dc.l .name	; $00
 dc.l .arrange_mem	; $04
 dc.l .arrange_regs	; $08
 dc.l .arrange_code	; $0c
 dc.l .assert_mem	; $10
 dc.l .assert_regs	; $14
 dc.l .assert_code	; $18

.name
 dc.b "lsl_register_by_immediate_word",0
 even

.arrange_mem
 ;length,address,ptr
 dc.l $00000000

.arrange_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$00002001,$00000081
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $001f ; ENZOC

.arrange_code
 ;length,address
 dc.l $00000001,$00040000
 dc.b $E3,$4E

.assert_mem
 ;length,address,ptr
 dc.l $00000000

.assert_regs
 ;    D0/A0     D1/A1     D2/A2     D3/A3     D4/A4     D5/A5     D6/A6     D7/A7
 dc.l $00000000,$000000d1,$000000d2,$000000d3,$000000d4,$000000d5,$00004002,$00000081
 dc.l $000000a0,$000000a1,$000000a2,$000000a3,$000000a4,$000000a5,$000000a6,$000000a7
 dc.w $0000 ; -----

.assert_code
 LSL.W #$01,D6

