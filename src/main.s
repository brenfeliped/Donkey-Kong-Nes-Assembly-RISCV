.data
.include "include_imgs.s"
.include "macros2.s"
.text
main:
  M_SetEcall(exceptionHandling)	# Macro de SetEcall - não tem ainda na DE1-SoC
  #addi sp, sp, -20 #dealoca 5 espacos na pilha
  la a0, fase1_cenario #carrega o cenario
  jal LoadScreen
  li a0, 65 #posicao x e y inicial do mario
  li a1, 199
  li a2, 0 #sprite 0 inicial
  jal LoadMario #carrega o mario
  li a0,65
  li a1,199
  li a2,0 # id do marioStopRight
  li s1,216 # id do solo posicao y
  jal InitializeCounter #inicializa o contador de pontos
ingame: #loop infinito enquanto o jogo roda
  jal IdMoveMent #Identifica o movimento do mario realizado
  addi sp,sp,-12
  sw a0,0(sp) # carrega a0 na pilha = x do mario
  sw a1,4(sp) # carrega a1 na pilha = y do mario
  sw a2,8(sp) # carrega a2 na pilha = id
  jal LoadMario
  jal CountPoint #conta a pontuacao do jogador
  jal CountBonusCycle #conta a pontuação bonus do jogador
  jal PrintPoints #printa a pontuação do jogador
  lw a0, 0(sp)
  lw a1,4(sp)
  lw a2,8(sp)
  addi sp,sp,12
  #jal ReloadMario #recarrega o mario
  
  j ingame #volta pra label ingame
  li a7,10 #termina
  ecall
  
.include "includes.s"
