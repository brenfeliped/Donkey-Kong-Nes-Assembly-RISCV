.data
.include "include_imgs.s"
.text
main:
  #addi sp, sp, -20 #dealoca 5 espacos na pilha
  la a0, fase1_cenario #carrega o cenario
  jal LoadScreen
  #jal BeginPoints
  la a2,fire_barril1
  li a0,44
  li a1,191
  jal print_sprite
  li a0,100
  li a1,27
  la a2,princesa_left
  jal print_sprite
  li a0,44
  li a1,33
  la a2,dnk_frente
  jal print_sprite # printar o DK
  li a0, 63 #posicao x e y inicial do mario
  li a1, 199
  li a2, 0 #sprite 0 inicial
  jal LoadMario #carrega o mario
  li a0,63
  li a1,199
  li a2,0 # id do marioStopRight
  li s1,216 # id do solo posicao y
ingame: #loop infinito enquanto o jogo roda
  jal IdMoveMent #Identifica o movimento do mario realizado
  addi sp,sp,-12
  sw a0,0(sp) # carrega a0 na pilha = x do mario
  sw a1,4(sp) # carrega a1 na pilha = y do mario
  sw a2,8(sp) # carrega a2 na pilha = id
  jal LoadMario
  lw a0, 0(sp)
  lw a1,4(sp)
  lw a2,8(sp)
  addi sp,sp,12
  #jal ReloadMario #recarrega o mario
  j ingame #volta pra label ingame
  li a7,10 #termina
  ecall
  
.include "includes.s"
