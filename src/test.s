.data
.include "..\sprites\teste_mario.s"
.text


# Preenche a tela de vermelho
	li t1,0xFF000000	# endereco inicial da Memoria VGA
	li t2,0xFF012C00	# endereco final 
	li t3,0x00000000	# cor vermelho|vermelho|vermelhor|vermelho
LOOP: 	beq t1,t2,FORA		# Se for o último endereço então sai do loop
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	j LOOP			# volta a verificar
FORA:
# Carrega a fase1
PrintFase:	li t1,0xFF000000	# endereco inicial da Memoria VGA
	li t2,0xFF012C00	# endereco final 
	la s1,teste_mario       # endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	beq t1,t2,FIM		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1			# volta a verificar

    
# devolve o controle ao sistema operacional
FIM:	#li a7,10		# syscall de exit
	#ecall
	j FIM
