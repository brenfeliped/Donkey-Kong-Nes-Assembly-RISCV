# fucao para identificar o movimento e da a nova posicao
# a0 = x
# a1 = y 
# a2 = id do mario 
# e retorna a0 = x_novo a1= y_novo e  a2 = id_novo
IdMoveMent:
  addi sp,sp,-16
  sw a0, 0(sp) #salva na pilha o x do sprite
  sw ra, 4(sp) # slava na pilha ra
  sw a1, 8(sp) # salva y
  sw a2, 12(sp) # salva id
  jal scanTeclado
  addi t0, zero, 100 #d
  beq t0, a0, MoveRight #caso n seja apertado nenhuma tecla volta a verificar
  
  #addi t0, zero, 119 #w
  #bne t0, a0, MoveUp #caso seja apertado w movimentaria para cima
  
  addi t0, zero, 97 #a
  beq t0, a0, MoveLeft #caso seja apertado a movimenta para a esquerda
  
  #addi t0, zero, 115 #s
  #bne t0, a0, MoveDown #caso seja apertado s movimenta para baixo
  lw ra,4(sp)
  ret
  
MoveRight:
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  la a2,fase1_cenario # carrega o mapa em a2
  li a3,15 # largura 
  li a4,17 # altura
  jal Restau_Map # paga o mario antigo
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  lw a2, 12(sp) # carrega id do mario anterior
  li t0,3
  bge a2,t0,changeToRight # verifica se o mario esta virado para esquerda
  li t0,2
  addi a0,a0,2 # anda cinco pixels no eixo x
  beq t0,a2,reset_mario_animationR # verica se não eh a ultima Right animation
  addi a2,a2,1 # vai pro proximo sprite da animacao
  j end_moveR
  changeToRight:li a2,0 # nao muda x so muda o sprite de direcao
  		j end_moveR
reset_mario_animationR: li a2,0 # volta para a primeira animacao Right
end_moveR:  
	lw ra,4(sp)
	addi sp,sp,16
  	ret

MoveLeft:
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  la a2,fase1_cenario # carrega o mapa em a2
  li a3,15 # largura 
  li a4,17 # altura
  jal Restau_Map # paga o mario antigo
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  lw a2, 12(sp) # carrega id do mario anterior
  li t0,3
  blt a2,t0,changeToLeft #verifica se o mario esta virado para direita
  li t0,5
  addi a0,a0,-2 # anda cinco pixels no eixo x
  beq a2,t0,reset_mario_animationL  # verica se não eh a ultima Left animation
  addi a2,a2,1 # vai pro proximo sprite da animacao 
  j end_moveL
  changeToLeft: li a2,3 # nao muda x so muda o sprite de direcao 
  j end_moveL
reset_mario_animationL: li a2,3  # volta para a primeira animacao Left
end_moveL:
  lw ra,4(sp)
  addi sp,sp,16
  ret

CalculaY:# receber y em a1 e retorna novo y em a1
	#la t0,AddrBaseEVGA
	li t1,320
	addi t3,a1,1 # t3=y+1
	mul t2,t1,a1 # t2 = y*320
	add t2,t0,t2 # t2 = y * 320 + 0xff000000
	add t2,t2,a0 # t2 = y * 320 + 0xff000000 + x (posicao no bitmap)
	add t3,t2,t1  # t3= pos_print_mario + 320 (proxima linha)
	li t4,4
	lw t5,0(t2)
	#loop_cal: beq 
Jump:
  #precisa ser implementado
  addi sp,sp,16
  lw ra,4(sp)
  ret
