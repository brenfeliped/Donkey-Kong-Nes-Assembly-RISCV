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
        
# Essa funcao renderiza uma sprite na tela, dado endereco da sprite, largura, altura e coordenadas (x,y)
# a0 = coordenada x do bitmap display onde comeca a renderizacao
# a1 = coordenada y do bitmap display onde comeca a renderizacao
# a2 = endereco da sprite
# a5 = renderziacao parcial
# a6 = flip sprite horizontalmente
PrintSprite:
  li   t0, AddrBaseEVGA  # carrega o endereco inicial do bitmap display
  addi t1, zero, 320   # largura do bitmap display
  mul  t2, t1, a1      # bmp display vezes coordenada y
  add  t0, t0, a0      # desloca a memoria em x bytes para a direita
  add  t0, t0, t2	     # desloca a memoria em y bytes para baixo

  lw t5, 0(a2) #carrega a largura e a altura do sprite
  lw t6, 4(a2)
  
  mul t2, t5, t6   # nro de pixels = largura x altura
  add t3, zero, t5 # contador de largura = largura
  sub t1, t1, t5   # valor para pular para a proxima linha = 320 - largura
  	
  beq a6, zero, loop_render # renderiza normal
  add t0, t0, t5 # x inicial passa a ser x + largura
		
  loop_render: beq t2, zero, loop_render_end # while (nro de pixels > 0)
    lb t4, 0(a2) # carrega um pixel da sprite
    sb t4, 0(t0) # carrega o pixel no bitmap display
			
    addi a2, a2, 1   # proximo pixel
    addi t3, t3, -1          # decrementa o contador de largura
    beq  t3, zero, next_line # if contador de largura == 0
		
    addi t0, t0, 1     # desloca o endereco do bmp display em 1 byte
    jal zero, continue # prepara para o proximo loop
    next_line:
	add t3, zero, t5 # restaura o valor da largura
	add t0, t0, t1   # endereco do bmp display += 320+1 - largura
			
        beq a6, zero, next_line_no_flip
	add t0, t0, t5
	add t0, t0, t5
			
next_line_no_flip: 
	bne a5, zero, partial_render
	jal zero, continue
			
	partial_render:
	  add a2, a2, t1 # alem de deslocar no bitmap display, desloca na memoria
	  addi a2, a2, -1
			
	continue:
	  addi t2, t2, -1 # diminui o contador de pixels
			
	  beq a6, zero, loop_render # continua o loop
          addi t0, t0, -2 # decrementa -2 por vai ser somado +1 na linha seguinte
			
	  jal zero, loop_render
loop_render_end:
  ret # retorna
