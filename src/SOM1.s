#.include "macros2.s"

.data

#GAMESTART:	.word 69, 750, 71, 250, 72, 500, 69, 500, 69, 1000,
GAMESTART:	.word 21, 750, 23, 250, 24, 500, 21, 500, 33, 1250,

STAGESTART:	.word 43, 400, 45, 300, 48, 400, 45, 400, 43, 400, 45, 400, 41, 600,
		 
HAMMER:		.word 96, 250, 96, 175, 96, 175, 96, 250, 96, 250, 88, 250, 96, 250, 88, 250, 96, 250, 88, 250, 88, 175, 88, 175, 
			88, 250, 88, 250, 91, 250, 88, 250, 91, 250, 88, 175

DEATH:		.word 46, 125, 41, 125, 38, 125, 44, 125, 48, 125, 43, 125, 47, 125, 42, 125, 46, 125, 41, 125, 44, 125, 39, 125, 43,
 			125, 38, 125, 42, 125, 37, 125, 41, 125, 48, 125, 39, 125, 46, 125, 38, 125, 45, 125, 37, 125, 44, 125, 48,
 			 125, 43, 125, 46, 125, 41, 125, 28, 250, 36, 500, 31, 500, 36, 1000,

INTRODUCTION:	.word 36, 250, 36, 250, 33, 500, 28, 250, 28, 250, 29, 250, 26, 750, 26, 250, 26, 250, 34, 500, 31, 250, 33, 250,
			 31, 250, 28, 750, 28, 250, 28, 250, 36, 500, 33, 250, 34, 250, 36, 250, 26, 750, 29, 250, 31, 250, 33, 500,
			 28, 250, 29, 250, 31, 250, 29, 500,

#LEVEL1:	.word 72, 500, 64, 500, 67, 250, 69, 250, 67, 250,
LEVEL1:		.word 36, 250, 28, 250, 31, 125, 33, 125, 31, 125,

LEVEL3:		.word 64, 250, 72, 125, 72, 125, 64, 250, 72, 125, 72, 125, 64, 250, 72, 125, 72, 125, 64, 250, 72, 125, 72, 125,

.text
	#M_SetEcall(exceptionHandling)
	#s7 = Instrumento
	#s8 = Volume
	#s9 = Quantidade de notas-1
	#s10 = Primeira Nota
	addi s7, zero, 0
	addi s8, zero, 10
	#j TOCA_STAGESTART
	#j TOCA_GAMESTART
	#j TOCA_HAMMER
	#j TOCA_DEATH
	#j TOCA_INTRODUCTION
	#j TOCA_PASSO_PULO
	#j PASSO_PULO2
		
TOCA_GAMESTART:
	addi sp,sp,-4
	sw ra, 0(sp)
	addi s9, zero, 5
	addi s10, zero, 21
	la s6, GAMESTART
	la s11, GAMESTART
	addi s11, s11, 4
	jal TOCA

TOCA_STAGESTART:
	addi s9, zero, 7
	addi s10, zero, 43
	la s6, STAGESTART
	la s11, STAGESTART
	addi s11, s11, 4
	jal TOCA

TOCA_HAMMER:
	addi sp,sp,-4
	sw ra, 0(sp)
	addi s9, zero, 19
	addi s10, zero, 96
	la s6, HAMMER
	la s11, HAMMER
	addi s11, s11, 4
	jal TOCA

TOCA_DEATH:
        addi sp,sp,-4
	sw ra, 0(sp)
	addi s9, zero, 32
	addi s10, zero, 46
	la s6, DEATH
	la s11, DEATH
	addi s11, s11, 4
	jal TOCA

TOCA_INTRODUCTION:
        addi sp,sp,-4
	sw ra, 0(sp)
	addi s9, zero, 28
	addi s10, zero, 36
	la s6, INTRODUCTION
	la s11, INTRODUCTION
	addi s11, s11, 4
	jal TOCA

TOCA_PASSO_PULO:
        addi sp,sp,-4
	sw ra, 0(sp)
	addi t5, zero, 1
	beq t6, t5, PASSO_PULO2
	
	addi s9, zero, 1
	addi s10, zero, 61
	addi s6, zero, 61
	addi s11, zero, 0
	
	addi t6, zero, 1
	jal TOCA
PASSO_PULO2:
        addi sp,sp,-4
	sw ra, 0(sp)
	addi s9, zero, 1
	addi s10, zero, 72
	addi s6, zero, 72
	addi s11, zero, 0
	
	addi t6, zero, -1
	
	jal TOCA		

.macro	sound(%base_note, %note, %duration, %instrument, %volume)
	lw a0, 0(%note)
	add a0, a0, %base_note
	lw a1, 0(%duration)
	li a2, 80
	li a3, 250
	jal SOUND
.end_macro
SOUND:
	addi a1,a1,320
	li t0, 100
	bge s0,t0,PULA
	addi a1,a1,195
PULA:
	li a7, 31	#syscall for midi
	M_Ecall
	jr ra

.macro	sleep(%duration)
	lw a0, 0(%duration)
	jal SLEEP
.end_macro
SLEEP:
	addi a0,a0,10
	li a7, 32	#syscall for sleep
	M_Ecall
	jr ra

TOCA:
	sound(s10,s6,s11,s7,s8)
	sleep(s11)
	addi s9, s9, -1
	beqz s9, DEPOIS
	addi s6, s6, 8
	addi s11, s11, 8
	j TOCA
DEPOIS:
	lw ra,0(sp)
	addi sp,sp,4
	jr ra


#.include "SYSTEMv13.s"
