.data
.include "include_imgs.s"

.text
main:
  #addi sp, sp, -20 #dealoca 5 espacos na pilha
  la a0, fase1_cenario #carrega o cenario
  jal LoadScreen
  li a0, 12 #posicao x e y inicial do mario
  li a1, 198
  li a2, 0 #sprite 0 inicial
  jal LoadMario #carrega o mario
  li a0,12
  li a1,198
  li a2,0 # id do marioStopRight

ingame: #loop infinito enquanto o jogo roda
  jal IdMoveMent #Identifica o movimento do mario realizado
  addi sp,sp,-12
  sw a0,0(sp) # carrega a0 na pilha = x
  sw a1,4(sp) # carrega a1 na pilha = y
  sw a2,8(sp) # carrega a2 na pilha = id
  jal LoadMario
  lw a0, 0(sp)
  lw a1,4(sp)
  lw a2,8(sp)
  addi sp,sp,12
  #jal ReloadMario #recarrega o mario
  j ingame #volta pra label ingame
  #addi sp, sp, 20
  li a7,10 #termina
  ecall
  
.include "includes.s"
