IdMoveMent:
  sw ra,16(sp)
  jal scanTeclado
  addi t0, zero, 100 #d
  beq t0, a0, MoveRight #caso n seja apertado nenhuma tecla volta a verificar
  
  #addi t0, zero, 119 #w
  #bne t0, a0, MoveUp #caso seja apertado w movimentaria para cima
  
  addi t0, zero, 97 #a
  beq t0, a0, MoveLeft #caso seja apertado a movimenta para a esquerda
  
  #addi t0, zero, 115 #s
  #bne t0, a0, MoveDown #caso seja apertado s movimenta para baixo
  
  lw ra,16(sp)
  ret
  
MoveRight:
  lw a0, 0(sp) #pega a atual posicao que o mario se encontra
  lw a1, 4(sp)
  li t0, 0 #flag de movimento a direita
  sw t0, 20(sp) #salva na pilha
  addi a0, a0, 10 #adiciona +10 ao eixo x do mario
  jal UpdateMario #atualiza a posicao
  lw ra,16(sp)
  ret

MoveLeft:
  lw a0, 0(sp) #pega a atual posicao que o mario se encontra
  lw a1, 4(sp)
  li t0, 1 #flag de movimento a direita
  sw t0, 20(sp) #salva na pilha
  addi a0, a0, -10 #adiciona -10 ao eixo x do mario
  jal UpdateMario #atualiza a posicao
  lw ra,16(sp)
  ret

Jump:
  #precisa ser implementado
  lw ra,16(sp)
  ret
