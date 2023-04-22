;APS000000C8000019B300001B18000018CE000019B3000019B3000019B3000019B3000019B3000019B3
;---------------T---------T---------------------T------------------

LVOSupervisor	equ	-30
LVOForbid	equ	-132
LVOPermit	equ	-138
LVOCacheClearU	equ	-636

jmp_instr	equ	$4ef9

start_of_all_code

start
	;; Disable system
		
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	sp,save_global_sp

	move.l	$4.w,a6
	jsr	LVOForbid(a6)


	; Setup test-runner
	
	lea	test_suite,a0
	move.l	a0,next_test


test_loop
	; Fetch next test
	
	move.l	next_test,a0
	move.l	(a0)+,d0

	; Exit if no more tests

	beq	exit

	; Point to next test

	move.l	a0,next_test

	; Run test in supervisor mode
	move.l	d0,a0
	lea	run_test,a5
	move.l	$4,a6
	jsr	LVOSupervisor(a6)


	; Loop tests
	
	bra	test_loop

exit
	; Reenable system

	move.l	$4.w,a6
	jsr	LVOPermit(a6)
	
	move.l	save_global_sp,sp
	movem.l	(sp)+,d0-d7/a0-a6

	move.l	test_count_tot,d0
	move.l	test_count_ok,d1
	move.l	test_count_fail,d2

	rts

save_global_sp	dc.l	$0
next_test	dc.l	$0


;
; note: This is run in Supervisor mode so we can arrange and assert SR
;
; param:
;  A0 = test

run_test
	;; A5 = test
	
	move.l	a0,a5
	move.l	a5,current_test

	; increase total test count

	add.l	#1,test_count_tot

	; Backup&Safety: Memory areas
	; Backup&Safety: Code

	move.l	test_offset_act_code(a5),a0
	move.l	(a0)+,d0	; d0 = code length
	move.l	(a0)+,a1	; a1 = code target address
			; a0 = code source address (ignored)

	lea	code_backup,a2
	asr.l	#1,d0
	addq.l	#3-1,d0	; 3 extra word for jmp back
.backup_code_loop
	move.w	(a1)+,(a2)+
	dbf	d0,.backup_code_loop	

		
	; Arrange: Memory areas

	; Arrange: Code

	move.l	test_offset_act_code(a5),a0
	move.l	(a0)+,d0	; d0 = code length
	move.l	(a0)+,a1	; a1 = code target address
			; a0 = code source address

	move.l	a1,.test_jmp_address
	
	lea	code_copy,a2
	asr.l	#1,d0
	subq	#1,d0
.copy_test_code_loop
	move.w	(a0),(a1)+
	move.w	(a0)+,(a2)+
	dbf	d0,.copy_test_code_loop	
	move.w	#jmp_instr,(a1)+
	move.w	#jmp_instr,(a2)+
	move.l	#.return_here_after_test,(a1)+
	move.l	#.return_here_after_test,(a2)+

	; Arrange: Clear caches

	move.l	$4.w,a6
	jsr	LVOCacheClearU(a6)

	; Backup&Safety: Stack Pointer

	move.l	sp,sp_backup

	; Arrange: A-/D-regs + SR

	move.l	test_offset_arrange_regs(a5),a7

	; SR

	move.w	64(a7),d0
	move.w	sr,d1
	and.w	#$ffe0,d1
	or.w	d1,d0
	move.w	d0,arrange_sr

	; Regs
	
	movem.l	(a7)+,d0-d7/a0-a6
	move.l	(a7),a7
	move.w	arrange_sr,sr

	; Act: Run test!
	
	; this is a jmp (xxx).l instruction to the
	; test code
	dc.w	jmp_instr
.test_jmp_address
	dc.l	$12345678

	; the test will jmp back to this address 
	; after test code is run
.return_here_after_test

	; Act: Collect regs

	move.w	sr,collected_sr
	and.w	#$001f,collected_sr
	move.l	d0,collected_regs+$00
	move.l	d1,collected_regs+$04
	move.l	d2,collected_regs+$08
	move.l	d3,collected_regs+$0c
	move.l	d4,collected_regs+$10
	move.l	d5,collected_regs+$14
	move.l	d6,collected_regs+$18
	move.l	d7,collected_regs+$1c
	move.l	a0,collected_regs+$20
	move.l	a1,collected_regs+$24
	move.l	a2,collected_regs+$28
	move.l	a3,collected_regs+$2c
	move.l	a4,collected_regs+$30
	move.l	a5,collected_regs+$34
	move.l	a6,collected_regs+$38
	move.l	a7,collected_regs+$3c

	; Restore: SP

	move.l	sp_backup,sp

	; Restore: Code

	move.l	current_test,a5
	move.l	test_offset_act_code(a5),a0
	move.l	(a0)+,d0		; d0 = code length
	move.l	(a0)+,a1		; a1 = code target address
				; a0 = code source address

	lea	code_backup,a2
	asr.l	#1,d0
	addq.l	#3-1,d0
.restore_code_loop 
	move.w	(a2)+,(a1)+
	dbf	d0,.restore_code_loop	


	; Restore: Clear caches
	move.l	$4.w,a6
	jsr	LVOCacheClearU(a6)
	

	; Assert: Check if ok/fail

	; Registers

	move.l	current_test,a5
	move.l	test_offset_assert_regs(a5),a0
	
	move.l	collected_regs+$00,d0	; D0
	cmp.l	$00(a0),d0
	bne.w	.fail
	move.l	collected_regs+$04,d0	; D1
	cmp.l	$04(a0),d0
	bne.w	.fail
	move.l	collected_regs+$08,d0	; D2
	cmp.l	$08(a0),d0
	bne.w	.fail
	move.l	collected_regs+$0c,d0	; D3
	cmp.l	$0c(a0),d0
	bne.w	.fail
	move.l	collected_regs+$10,d0	; D4
	cmp.l	$10(a0),d0
	bne.w	.fail
	move.l	collected_regs+$14,d0	; D5
	cmp.l	$14(a0),d0
	bne.w	.fail
	move.l	collected_regs+$18,d0	; D6
	cmp.l	$18(a0),d0
	bne.w	.fail
	move.l	collected_regs+$1c,d0	; D7
	cmp.l	$1c(a0),d0
	bne.w	.fail
	move.l	collected_regs+$20,d0	; A0
	cmp.l	$20(a0),d0
	bne.s	.fail
	move.l	collected_regs+$24,d0	; A1
	cmp.l	$24(a0),d0
	bne.s	.fail
	move.l	collected_regs+$28,d0	; A2
	cmp.l	$28(a0),d0
	bne.s	.fail
	move.l	collected_regs+$2c,d0	; A3
	cmp.l	$2c(a0),d0
	bne.s	.fail
	move.l	collected_regs+$30,d0	; A4
	cmp.l	$30(a0),d0
	bne.s	.fail
	move.l	collected_regs+$34,d0	; A5
	cmp.l	$34(a0),d0
	bne.s	.fail
	move.l	collected_regs+$38,d0	; A6
	cmp.l	$38(a0),d0
	bne.s	.fail
	move.l	collected_regs+$3c,d0	; A7
	cmp.l	$3c(a0),d0
	bne.s	.fail
	move.w	collected_sr,d0	; SR
	cmp.w	$40(a0),d0
	bne.s	.fail

	; Memory

	; ok!
	
	add.l	#1,test_count_ok

	bsr	log_str_ok
	move.l	(a5),a0
	bsr	log_strz
	bsr	log_str_eol

	rte

	; fail!
.fail
	add.l	#1,test_count_fail
	
	bsr	log_str_fail
	move.l	(a5),a0
	bsr	log_strz
	bsr	log_str_eol

	
	; Assert: Log fail details


	rte

current_test	dc.l	$00000000
test_count_tot	dc.l	$00000000
test_count_ok	dc.l	$00000000
test_count_fail	dc.l	$00000000

arrange_sr	dc.w	$0000
collected_sr	dc.w	$0000
collected_regs	blk.l	16,$00000000

code_backup	blk.b	512,$00
code_copy	blk.b	512,$00
sp_backup	dc.l	$00000000

code_temp	moveq	#2,d0

 

; Logger functions

log_strz
	movem.l	d0/a1-a2,-(sp)
	;move.l	d0,log_save_d0
	;move.l	a1,log_save_a1
	;move.l	a2,log_save_a2

	move.l	log_current_ptr,a1
	lea.l	log_buffer_end,a2
.loop
	move.b	(a0)+,d0
	beq.s	.done

	cmp.l	a1,a2
	beq.s	.overflow

	move.b	d0,(a1)+
	bra.s	.loop

.overflow
	bsr.s	log_overflow
;	bra	.done

.done
	move.l	a1,log_current_ptr

	;move.l	log_save_a2,a2
	;move.l	log_save_a1,a1
	;move.l  log_save_d0,d0
	movem.l	(sp)+,d0/a1-a2
	rts

log_str_ok
	move.l	a0,-(sp)
	lea	.str,a0
	bsr	log_strz
	move.l	(sp)+,a0
	rts

.str	dc.b	"  ok ",0
	even
	
log_str_fail
	move.l	a0,-(sp)
	lea	.str,a0
	bsr	log_strz
	move.l	(sp)+,a0
	rts

.str	dc.b	"fail ",0
	even

log_str_eol
	move.l	a0,-(sp)
	lea	.str,a0
	bsr	log_strz
	move.l	(sp)+,a0
	rts

.str	dc.b	$0a,0
	even
	
	
log_overflow
	move.l	#"log ",log
	move.l	#"over",log+4
	move.l	#"flow",log+8
	rts



log_current_ptr	dc.l log
;log_save_d0	dc.l $00000000
;log_save_a1	dc.l $00000000	

log	blk.b 1000*100,$00
log_buffer_end
	; final zero ending here in case we 
	; fill the entire log
	dc.b	$00
	even

	; Just spend some time to test Disable/reenable system stuff
;	moveq	#9,d0
;.loopa	moveq	#-1,d1
;.loopb	dbf	d1,.loopb
;	dbf	d0,.loopa


	; include test suite
	
	include	"dev:github/rust-amiga-emul-ami-test-runner/test_suite.s"

end_of_all_code
