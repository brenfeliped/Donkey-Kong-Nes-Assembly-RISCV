.data
	Dist_escadas_direita: .word 9
.text
# fucao para identificar o movimento e da a nova posicao
# a0 = x do mario
# a1 = y do mario
# a2 = id do mario 
# e retorna a0 = x_novo a1= y_novo e  a2 = id_novo
IdMoveMent: addi sp,sp,-16
  sw a0, 0(sp) #salva na pilha o x do sprite
  sw ra, 4(sp) # slava na pilha ra
  sw a1, 8(sp) # salva y
  sw a2, 12(sp) # salva id
  jal scanTeclado
  #jal scanJoy
  #li t0,10 # teste se mario ta na escada
  #beq t0,a0,
  addi t0, zero, 100 #d
  beq t0, a0, MoveRight #caso n seja apertado nenhuma tecla volta a verificar
  addi t0, zero,68 #D
  beq t0, a0, MoveRight #caso n seja apertado nenhuma tecla volta a verificar
  
  addi t0, zero, 119 #w
  beq t0, a0, MoveUp #caso seja apertado w movimentaria para cima
  
  addi t0, zero, 97 #a
  beq t0, a0, MoveLeft #caso seja apertado a movimenta para a esquerda
  addi t0, zero, 65 #A
  beq t0, a0, MoveLeft #caso seja apertado a movimenta para a esquerda
  
  
  addi t0,zero,104#h
  beq  t0,a0,Jump # caso seja apertada pula
  addi t0,zero,72 #H
  beq  t0,a0,Jump # caso seja apertada pula
  
  
  #addi t0, zero, 115 #s
  #bne t0, a0, MoveDown #caso seja apertado s movimenta para baixo
   
   # evitar erro por apertar outras teclas 
  lw a0,0(sp) # printa o mario com os mesmos dados caso não sido apertada uma tecla valida
  lw ra,4(sp)
  lw a1,8(sp)
  lw a2, 12(sp)
  addi sp,sp,16
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
  li t0,290 # limite em x  a direita
  addi t1,a0,2
  bge t1,t0,reset_mario_animationR # verifica o limite no eixo X para direita
  addi a0,a0,2 # anda 2 pixels no eixo x
  li t0,2
  beq t0,a2,reset_mario_animationR # verica se não eh a ultima Right animation
  addi a2,a2,1 # vai pro proximo sprite da animacao
  j end_moveR
  changeToRight:li a2,0 # nao muda x so muda o sprite de direcao
  		j end_moveR
reset_mario_animationR: li a2,0 # volta para a primeira animacao Right
end_moveR:
	jal Calc_y_Right
	lw ra,4(sp)
	addi sp,sp,16
  	ret

MoveLeft:
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  la a2,fase1_cenario # carrega o mapa em a2
  li a3,15 # largura 
  li a4,16 # altura
  jal Restau_Map # paga o mario antigo
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  lw a2, 12(sp) # carrega id do mario anterior
  li t0,3
  blt a2,t0,changeToLeft #verifica se o mario esta virado para direita
  li t0,22  # limite x pela esquerda
  addi t1,a0,-2
  blt t1,t0,reset_mario_animationL # testa se o limete do eixo x para esquerda
  beq t1,t0,reset_mario_animationL
  addi a0,a0,-2 # anda 2 pixels no eixo x
  li t0,5
  beq a2,t0,reset_mario_animationL  # verica se não eh a ultima Left animation
  addi a2,a2,1 # vai pro proximo sprite da animacao 
  j end_moveL
  changeToLeft: li a2,3 # nao muda x so muda o sprite de direcao 
  j end_moveL
reset_mario_animationL: li a2,3  # volta para a primeira animacao Left
end_moveL:
  jal Calc_y_Left
  lw ra,4(sp)
  addi sp,sp,16
  ret

	 
Calc_y_Right:
	addi s1,a1,16
	li t0,0xFF000000
	li t1,320
	mul t2,t1,s1 # t2 = y*320
	add t2,t0,t2 # t2 = y * 320 + 0xff000000
	add t2,t2,a0 # t2 = y * 320 + 0xff000000 + x (posicao no bitmap)
	sub t3,t2,t1  # t3= pos_print_mario - 320 ( linha anterior)
	lb t4, 0(t2)
	lb t5, 0(t3)
	li t1,70
	beq t1,t4,rightPos
	addi s1,s1,1
	j endCal_yR
        rightPos: bne t5,t1,endCal_yR
        addi s1,s1,-1
        endCal_yR:
        	addi a1,s1,-16
		ret

Calc_y_Left:
	addi s1,a1,16
	li t0,0xFF000000
	li t1,320
	mul t2,t1,s1 # t2 = y*320
	add t2,t0,t2 # t2 = y * 320 + 0xff000000
	add t2,t2,a0 # t2 = y * 320 + 0xff000000 + x (posicao no bitmap)
	sub t3,t2,t1  # t3= pos_print_mario - 320 ( linha anterior)
	lb t4, 0(t2)
	lb t5, 0(t3)
	li t1,70
	beq t1,t4,UpY_left
        DownY_left:addi s1,s1,1
        UpY_left: 
        	bne t5,t1,endCal_yL
        	addi s1,s1,-1
        endCal_yL:
        	addi a1,s1,-16
		ret
	
Jump:
  #precisa ser implementado
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  la a2,fase1_cenario # carrega o mapa em a2
  li a3,15 # largura 
  li a4,17 # altura
  jal Restau_Map # paga o mario antigo
  jal TOCA_PASSO_PULO
  lw a0,0(sp) # carrega x do sprite  anterior
  lw a1, 8(sp) # carrega y do sprite  anterior
  lw a2, 12(sp) # carrega id do mario anterior
  li t0,3
  blt a2,t0,JumpRight #verifica a direcao do mario
  Jumleft: li a2,6
  	jal LoadMario
  	li s3,12
  	lw a1, 8(sp) # carrega y do sprite  anterior
  	mv s4,a1    # s1 = y
  	loop_jumpUpL:beq s3,zero,end_loopL # faz a subida no pulo
  		     lw a0,0(sp) # carrega x do sprite  anterior
  		     mv a1,s4
  		     la a2,fase1_cenario
  		     li a3, 16
  		     li a4, 16
  		     jal Restau_Map
  		     lw a0,0(sp) # carrega x do sprite  anterior
  		     addi s4,s4,-1
  		     mv a1,s4
  		     li a2,6 # id do mario pullando esquerda
  		     addi s3,s3,-1
  		     jal LoadMario
  		     li a0,35 # sleep de 35 milisegundos
  		     li a7,32
  		     M_Ecall
  		     lw a0,0(sp)
  		     j loop_jumpUpL
        end_loopL:
        	     addi a1,s4,-2
  		     la a2,fase1_cenario
  		     li a3, 16
  		     li a4, 16
  		     jal Restau_Map
  		     li s3,12 
        	loop_JumpDownL: beq s3,zero,end_JumpDownL
        		       mv a1,s4
  		     	       la a2,fase1_cenario
  		     	       li a3, 16
  		     	       li a4, 16
  		     	       jal Restau_Map
  		     	       #lw a0,0(sp) # carrega x do sprite  anterior
  		     	       addi s4,s4,1
  		    	       mv a1,s4
  		     	       li a2,6 # id do mario pullando esquerda
  		     	       addi s3,s3,-1
  		     	       jal LoadMario
  		     	       li a0,35 # sleep de 35 milisegundos
  		     	       li a7,32
  		     	       M_Ecall
  		               lw a0,0(sp)
  		     	       j loop_JumpDownL
  		 end_JumpDownL:
  		 	     mv a1,s4
  		     	     la a2,fase1_cenario
  		     	     li a3, 16
  		     	     li a4, 16
  		     	     jal Restau_Map
  		     	     li a2,8 # id od mario aterrisando esquerda
  		     	     jal LoadMario
  		     	     la a2,fase1_cenario
  		     	     li a3, 16
  		     	     li a4, 16
  		     	     jal Restau_Map
  		     	     li a2,3
  		     	     jal LoadMario
  		     	     li a2,3 # para se perder o mario no mapa
  	j endJump
  JumpRight:
  	li a2,7
  	jal LoadMario
  	li s3, 12
  	mv s4,a1
  	loop_jumpUpR:beq s3,zero,end_loopR # faz a subida no pulo
  		     lw a0,0(sp) # carrega x do sprite  anterior
  		     mv a1,s4
  		     la a2,fase1_cenario
  		     li a3, 16
  		     li a4, 16
  		     jal Restau_Map
  		     lw a0,0(sp) # carrega x do sprite  anterior
  		     addi s4,s4,-1
  		     mv a1,s4
  		     li a2,7     # id do mario pullando direita
  		     addi s3,s3,-1
  		     jal LoadMario
  		     li a0,35 # sleep de 35 milisegundos
  		     li a7,32
  		     M_Ecall
		     lw a0,0(sp)
  		     j loop_jumpUpR
        end_loopR:
        	     addi a1,s4,-2
  		     la a2,fase1_cenario
  		     li a3, 16
  		     li a4, 16
  		     jal Restau_Map
  		     li s3,12 
        	loop_JumpDownR: beq s3,zero,end_JumpDownR
        		       mv a1,s4
  		     	       la a2,fase1_cenario
  		     	       li a3, 16
  		     	       li a4, 16
  		     	       jal Restau_Map
  		     	       lw a0,0(sp) # carrega x do sprite  anterior
  		     	       addi s4,s4,1
  		    	       mv a1,s4
  		     	       li a2,7 # id do mario pullando direita
  		     	       addi s3,s3,-1
  		     	       jal LoadMario
  		     	       li a0,35 # sleep de 35 milisegundos
  		     	       li a7,32
  		     	       M_Ecall
  		               lw a0,0(sp)
  		     	       j loop_JumpDownR
  		 end_JumpDownR:
  		 	     mv a1,s4
  		     	     la a2,fase1_cenario
  		     	     li a3, 16
  		     	     li a4, 16
  		     	     jal Restau_Map
  		     	     li a2,9 # id od mario aterrisando direita
  		     	     jal LoadMario
  		     	     la a2,fase1_cenario
  		     	     li a3, 16
  		     	     li a4, 16
  		     	     jal Restau_Map
  		     	     lw a0,0(sp) # carrega x do sprite  anterior
  		     	     li a2,0
  		     	     jal LoadMario
  		     	     li a2,0 # para se perder o mario no mapa	  
endJump:
  #ebreak
  lw ra,4(sp)
  addi sp,sp,16
  ret

Verifica_escada: # tp= 1 eh pra subir | tp=2 eh pra descer: 
      # inicio para subir escada ou descer escada
      li t0,257 # verificar as 3 escadas a direita do mapa (242<=x<=257 and y<=198)
      bgt a0,t0,continua_verifica_escada
      li t0,242
      blt a0,t0,continua_verifica_escada
      li a0,250 # posicao x para o mario ficar virado para escada
      li a2,11 # id do mario virado de costas
      li gp,7
      j end_verifica_escada
      continua_verifica_escada: li t0,70 # verificar as 2 escadas a esquerda do mapa (60<=x<=70 and y<=198)
      				bgt a0,t0,continua_verifica_escada2
      				li t0,53
      				blt a0,t0,continua_verifica_escada2
      				li a0,60
      				li a2,11
      				j end_verifica_escada
      continua_verifica_escada2: # para implmentar :)
      				
end_verifica_escada: jr s1

MoveUp:
      lw a0,0(sp) # carrega x do sprite  anterior
      lw a1, 8(sp) # carrega y do sprite  anterior
      la a2,fase1_cenario # carrega o mapa em a2
      li a3,15 # largura 
      li a4,17 # altura
      jal Restau_Map # paga o mario antigo
      lw a0,0(sp) # carrega x do sprite  anterior
      lw a1, 8(sp) # carrega y do sprite  anterior
      lw a2, 12(sp) # carrega id do mario anterior
      li t0,11
      beq a2,t0,Esta_na_escada
      li t0,12
      beq a2,t0,Esta_na_escada
      li t0,13
      beq a2,t0,Esta_na_escada
      li tp,1
      jal s1, Verifica_escada
      j end_MoveUp
      Esta_na_escada: li t0,257  # verificar as 3 escadas a direita do mapa (242<=x<=257 and y<=198)
      		    bgt a0,t0,prox_escada
      		    li t0,242
      		    blt a0,t0,prox_escada
      		    #la t0,Dist_escadas_direita
      		    #lw t0, 0(t0)
      		SobeEscada:#addi gp,gp,-1
      		    #sw t0,0(t0)
      		    beq gp,zero,termina_subida
      		    #sw t0,0(t0)
      		    addi a1,a1,-1
      		    li t0,11
      		    beq t0,a2,alterna_sprite_escada
      		    li a2,11
      		    j load_mario_escada
      		    alterna_sprite_escada: li a2,12
load_mario_escada:  jal LoadMario
      		    j end_MoveUp
      		    termina_subida: li t0,13
      		    		     beq t0,a2,mario_levanta
      		    		     mv a2,t0 # a2 =13
      		    		     sw t0,0(t0)
      		    		     jal LoadMario
      		    		     j end_MoveUp
      		    		     mario_levanta: addi a0,a0,-16
      		    		     li a2,10
      		    		     jal LoadMario 
      		    		     j end_MoveUp
      		    prox_escada:li t0,70  # verificar as 2 escadas a esquerda do mapa (60<=x<=70 and y<=198)
      		    bgt a0,t0,prox_escada2
      		    li t0,53
      		    blt a0,t0,prox_escada2
      		    j SobeEscada
      		    prox_escada2:
      		     
      		     
      end_MoveUp: lw ra,4(sp)
      		addi sp,sp,16
      		ret
		
