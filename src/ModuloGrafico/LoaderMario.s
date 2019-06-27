.data
.text
# LoadMario vai carregar o mario dado
# a0=x
#a1=y
# a2= id do sprite mario
# retorna ////
LoadMario: #a0=x, a1=y, a2=id
  addi sp,sp,-16
  sw a0, 0(sp)
  sw a1, 4(sp)
  sw a2, 8(sp)
  sw ra, 12(sp) #salva o registrador de retorno
  addi t1, a2, 0 #salva o valor de a2 em t1
  
  li t0, 0 #carrega o possivel id do sprite em t0
  la a2, marioRightStop #carrega o sprite de id=0 em a2
  beq t1, t0, RETLOAD #testa se o id=0
  
  li t0, 1
  la a2, marioRightLegFrontUp
  beq t1, t0, RETLOAD #testa se o id=1
  
  li t0, 2
  la a2, marioRightLegBackUp
  beq t1, t0, RETLOAD #testa se o id=2
  
  li t0, 3 #carrega o possivel id do sprite em t0
  la a2, marioLeftStop #carrega o sprite de id=3 em a2
  beq t1, t0, RETLOAD #testa se o id=3
  
  li t0, 4
  la a2, marioLeftLegFrontUp
  beq t1, t0, RETLOAD #testa se o id=4
  
  li t0, 5
  la a2, marioLeftLegBackUp
  beq t1, t0, RETLOAD #testa se o id=5
  
RETLOAD:
  jal print_sprite
  lw ra, 12(sp)
  ret
  
#ReloadMario: #recarrega o mario no sprite 0 ou 3
#  sw ra, 12(sp)
#  lw a0, 0(sp)
#  lw a1, 4(sp)
#  lw t0, 20(sp) #carrega a flag da ultima direcao apontada
  
#  li t1, 1
  
#  beq t0, t1, Rleft #testa se a ultima direcao foi a esquerda
#  la a2, marioRightStop #carrega o sprite de id=0 em a2
#  jal print_sprite
#  lw ra, 12(sp)
#  ret
#Rleft:
#  li t1, 3
#  la a2, marioLeftStop #carrega o sprite de id=3 em a2
#  jal print_sprite
#  lw ra, 12(sp)
#  ret

#SwitchSpriteMarioR: #a2 possui o id do sprite retorna a0 com o sprite switado a1 com o novo id
#  la a0, marioRightLegFrontUp #faz a leitura do novo sprite
#  li a1, 1 #novo id do sprite
#  beq a2, zero, returnSPRM #testa se o id=0 e retorna ao chamador
#  addi t3, zero, 3
#  beq a2, t3, returnSPRM
#  addi t3, zero, 1 #t3 = id
#  la a0, marioRightLegBackUp
#  li a1, 2
#  beq a2, t3, returnSPRM #testa se o id=1 e retorna ao chamador
#  li a1, 0
#  la a0, marioRightStop
#returnSPRM:
#  ret
  
#SwitchSpriteMarioL: #a2 possui o id do sprite retorna a0 com o sprite switado a1 com o novo id
#  addi t3, zero, 0
#  la a0, marioLeftLegFrontUp #faz a leitura do novo sprite
#  li a1, 4 #novo id do sprite
#  beq a2, t3, returnSPRM2 #testa se o id=0 e retorna ao chamador
#  addi t3, zero, 3
#  beq a2, t3, returnSPRM2
#  addi t3, zero, 4 #t3 = id
#  la a0, marioLeftLegBackUp
#  li a1, 5
#  beq a2, t3, returnSPRM2 #testa se o id=1 e retorna ao chamador
#  li a1, 3
#  la a0, marioLeftStop
#returnSPRM2:
#  ret
  
#SwitchSpriteMarioUp: #necessario implementar
 # ret
