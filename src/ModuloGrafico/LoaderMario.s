.data
.text
# LoadMario vai carregar o mario dado
# a0=x
#a1=y
# a2= id do sprite mario
LoadMario: #a0=x, a1=y, a2=id
  addi sp,sp,-4
  #sw a0, 0(sp)
  #sw a1, 4(sp)
  #sw a2, 8(sp)
  sw ra, 0(sp) #salva o registrador de retorno
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
  la a2 marioLeftLegFrontUp
  beq t1, t0, RETLOAD #testa se o id=4
  
  li t0, 5
  la a2, marioLeftLegBackUp
  beq t1, t0, RETLOAD #testa se o id=5
  
  ## Jump mario
  li t0,6
  la a2,mario_jump_left
  beq t1,t0,RETLOAD # testa se o id=6
  
  li t0,7
  la a2,mario_jump_right
  beq t1,t0,RETLOAD # testa se o id=7
  
  li t0,8
  la a2,mario_falling_left
  beq t1,t0,RETLOAD # testa se o id=8
  
  li t0,9
  la a2,mario_jump_right
  beq t1,t0,RETLOAD # testa se o id=9
  
  # subir escadas
  li t0,10
  la a2,mario_back
  beq t1,t0,RETLOAD # testa se o id=10
  
  li t0,11
  la a2,mario_back_left_hand_up
  beq t1,t0,,RETLOAD # testa se o id=11
  
  li t0,12
  la a2,mario_back_right_hand_up
  beq t1,t0,RETLOAD  # testa se o id=12
  
  li t0,13
  la a2,mario_terminando_de_subir_escala
  beq t1,t0,RETLOAD # testa se o id=13
  
  
  j RETLOAD_fim
RETLOAD:
  jal print_sprite
RETLOAD_fim:lw ra, 0(sp)
  addi sp,sp,4
  ret
  
