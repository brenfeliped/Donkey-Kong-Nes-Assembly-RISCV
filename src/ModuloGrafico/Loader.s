.eqv AddrBaseEVGA 0xFF000000
.eqv AddrFinalEVGA 0xFF012C00

.data

.text

LoadScreen: #a0=endereço do fundo a ser carregado
  	li t1,AddrBaseEVGA	# endereco inicial da Memoria VGA
	li t2,AddrFinalEVGA	# endereco final 
	addi a0,a0,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	beq t1,t2,FIMLS		# Se for o último endereço então sai do loop
	lw t3,0(a0)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi a0,a0,4
	j LOOP1			# volta a verificar
FIMLS:
    ret #retorna ao chamador

# print um sprite qualquer dado:
# a0 = x
# a1= y
# a2= endereco da sprite
print_sprite:
	li   t0, AddrBaseEVGA  # carrega o endereco inicial do bitmap display
  	addi t1, zero, 320   # largura do bitmap display
 	mul  t2, t1, a1      # bmp display vezes coordenada y
  	add  t0, t0, a0      # desloca a memoria em x bytes para a direita
  	add  t0, t0, t2	     # desloca a memoria em y bytes para baixo
  	lw t5, 0(a2) #carrega a largura e a altura do sprite
  	lw t6, 4(a2)
  	addi a2,a2,8
  	addi t3, zero,0 # contador de largura 
  	addi t4,zero,0  # contador de altura
  	loop_print: beq t4,t6,end_print # comparacao altura
  		    addi t3, zero,0 # contador de largura
  		    loop_linha: beq t3,t5,end_linha # compracao lagura
  		    		lb tp,0(a2) # carrega o byte da memoria
  		    		#li tp,0xFF
  		    		sb tp,0(t0) #carrega o byte na memoria
  		    		addi a2,a2,1
  		    		addi t0,t0,1
  		    		addi t3,t3,1
  		    		j loop_linha
  		    end_linha:
  		    	      addi t4,t4,1  # incrementa a linha
  		    	      andi tp,t5,1
  		    	      beq tp,zero,par
  		    	  impar:addi a2,a2,1
  		    	 par:sub  t0,t0,t5 # t0= pos_atual - largura
  		    	      addi  t0,t0,320
  		    	      j loop_print
       end_print:
       		ret
# restaura o mapa original na posicao atual nas posicoes da mandadas
# a0=x
# a1=y
# a2= endereco de incio do mapa
# a3= lagura
# a4= altura   		
Restau_Map:
li t0,AddrBaseEVGA
li t1,320
addi a2,a2,8 # pula informacao de laguraxaltura
mul t1,t1,a1 # t1= y*320
add t1,t1,a0 # t1= (y*320)+x
add t0,t1,t0 # t0= 0xFF000000 + (y*320)+x(posicao de inicio do print na tela)
add t1,t1,a2 # t1 = a2 +(y*320)+x (poisicao  de inicio da parte do mapa a ser restaurada)
li t2,0     # t2= 0 (contador altura)
li t3,0     # t3=0 (contador lagura)
loop_rm: beq t2,a4,end_rm # comparacao com a altura
         li t3,0 # t3=0 contador lagura 
         loop_linharm:beq t3,a3,end_loop_linharm
         	      lb t4,0(t1) # carrega da imagem do mapa
         	      sb t4, 0(t0) # carrega na tela 
         	      addi t3,t3,1 # incrementa linha
         	      addi t1,t1,1 # incrementa um byte no mapa
         	      addi t0,t0,1 # incrementa um byte no bitmap
         	      j loop_linharm
        end_loop_linharm:
        	      addi t3,t3,1 # incrementa a linha do mapa
        	      sub  t0,t0,a3 # t0 = pos_atual- largura
        	      addi t0,t0,320 # posicao da nova linha na tela 
		      sub t1,t1,a3 # t1 = pos_atual_mapa- largura
		      addi t1,t1,320# posicao da nova linha na imagem do mapa
		      addi t2,t2,1
		      j loop_rm
end_rm:
	ret		      
# Essa funcao renderiza uma sprite na tela, dado endereco da sprite, largura, altura e coordenadas (x,y)
# a0 = coordenada x do bitmap display onde comeca a renderizacao
# a1 = coordenada y do bitmap display onde comeca a renderizacao
# a2 = endereco da sprite
# a5 = renderziacao parcial
# a6 = flip sprite horizontalmente
#PrintSprite:
#  li   t0, AddrBaseEVGA  # carrega o endereco inicial do bitmap display
#  addi t1, zero, 320   # largura do bitmap display
#  mul  t2, t1, a1      # bmp display vezes coordenada y
#  add  t0, t0, a0      # desloca a memoria em x bytes para a direita
#  add  t0, t0, t2	     # desloca a memoria em y bytes para baixo

#  lw t5, 0(a2) #carrega a largura e a altura do sprite
#  lw t6, 4(a2)
  
#  mul t2, t5, t6   # nro de pixels = largura x altura
#  add t3, zero, t5 # contador de largura = largura
#  sub t1, t1, t5   # valor para pular para a proxima linha = 320 - largura
  
  #addi a2,a2,8  # pula as words lagura e altura		
#  beq a6, zero, loop_render # renderiza normal
#  add t0, t0, t5 # x inicial passa a ser x + largura
		
#  loop_render: beq t2, zero, loop_render_end # while (nro de pixels > 0)
#    lb t4, 0(a2) # carrega um pixel da sprite
#    sb t4, 0(t0) # carrega o pixel no bitmap display
			
#    addi a2, a2, 1   # proximo pixel
#    addi t3, t3, -1          # decrementa o contador de largura
#    beq  t3, zero, next_line # if contador de largura == 0
		
#    addi t0, t0, 1     # desloca o endereco do bmp display em 1 byte
#    jal zero, continue # prepara para o proximo loop
#    next_line:
#	add t3, zero, t5 # restaura o valor da largura
#	add t0, t0, t1   # endereco do bmp display += 320+1 - largura
			
#        beq a6, zero, next_line_no_flip
#	add t0, t0, t5
#	add t0, t0, t5
			
#next_line_no_flip: 
#	bne a5, zero, partial_render
#	jal zero, continue
			
#	partial_render:
#	  add a2, a2, t1 # alem de deslocar no bitmap display, desloca na memoria
#	  addi a2, a2, -1
			
#	continue:
#	  addi t2, t2, -1 # diminui o contador de pixels
			
#	  beq a6, zero, loop_render # continua o loop
 #         addi t0, t0, -2 # decrementa -2 por vai ser somado +1 na linha seguinte
			
#	  jal zero, loop_render
#loop_render_end:
 # ret # retorna
