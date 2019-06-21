.data
.include "include_imgs.s"

.text
main:
  addi sp, sp, -20 #dealoca 5 espacos na pilha
  la a0, fase1_cenario #carrega o cenario
  jal LoadScreen
  
  li a0, 10 #posicao x e y inicial do mario
  li a1, 220
  li a2, 0 #sprite 0 inicial
  jal LoadMario #carrega o mario
  

ingame: #loop infinito enquanto o jogo roda
  jal IdMoveMent #Identifica o movimento do mario realizado
  la a0, fase1_cenario #faz um reprint da frame da fase
  jal LoadScreen
  jal ReloadMario #recarrega o mario
  j ingame #volta pra label ingame
  addi sp, sp, 20
  li a7,10 #termina
  ecall
  
.include "includes.s"
