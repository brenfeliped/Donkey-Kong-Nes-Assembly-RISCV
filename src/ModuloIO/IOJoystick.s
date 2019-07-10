.eqv ADC_CH0_CoordX 0xFF200200
.eqv ADC_CH1_CoordY 0xFF200204
.eqv ADC_CH2_Botao  0xFF200208

scanJoy:
	li t0, bufft
  	lw a0, 0(t0) #ler a flag do teclado
  	andi a0, a0, 0x0001 #mascara o bit 0
  	beq a0, zero, Verifica_Joy #testa se uma tecla foi pressionada
  	lw a0, 4(t0)
  	ret
Verifica_Joy:li t0,ADC_CH0_CoordX
	li t1,ADC_CH1_CoordY
	li t2,ADC_CH2_Botao
	lw t0, 0(t0)
	lw t1,0(t1)
	lw t2,0(t2)
	srli t0,t0,8 # descarta o os 8 primeiros bits da coorx
	srli t1,t1,8 # descarta o os 8 primeiros bits da coory
	srli t2,t2,8 # descarta o os 8 primeiros bits do botao
	li t3,-9
	add t4,t0,t3
	beq t4,zero,Dont_Move_X
	blt t4,zero,Move_x_right
	Move_left: li a0,100
	j  end_scanJoy
	Move_x_right: li a0,97
	j end_scanJoy
	Dont_Move_X:
		j scanJoy
	# para implementar coord Y e botao :)	
end_scanJoy:
	ret 