.data
.text
UpdateMario:
  #a0=x a1=y
  lw t0,0(sp)
  lw t1,4(sp) #faz a leitura da posicao atual do mario
  sw a0,0(sp) #escreve nas posicoes alocadas da pilha para a posicao do mario
  sw a1,4(sp)
  sw ra,12(sp)
  lw a2,8(sp) #carrega o id sprite atual printado(0..14)
  
  sub t0, a0, t0 #diferenca entre a posicao atual e a proxima posicao
  sub t1, a1, t1
  
  addi t2, zero, 10 #testa se a diferenca foi 10 a0>t0
  jal SwitchSpriteMarioR #troca o sprite para a animacao
  add a2, a0, zero #carrega o endereço do sprite
  lw a0, 0(sp) #recarrega as posicoes em a0 e a1
  lw a1, 4(sp)
  beq t2, t0, PrintSprite #caso seja printa o sprite correspondente
  
  addi t2, zero, -10 #testa se a diferenca foi -10 a0<t0
  jal SwitchSpriteMarioL #troca o sprite para a animacao
  lw ra,12(sp)
  add a2, a0, zero
  lw a0, 0(sp) #recarrega as posicoes em a0 e a1
  lw a1, 4(sp)
  beq t2, t0, PrintSprite #caso seja
  
  ret
  
  
UpdateBarril:



