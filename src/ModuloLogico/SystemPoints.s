# sistema de pontos
.eqv XIpoints 40
.eqv YIpoints 24
.eqv XBpoints 225
.eqv YBpoints 40
.eqv CorPoints 0x00FF

.data

.text

InitializeCounter:
  add s10, zero, zero #inicializa o contador
  addi s9, zero, 490 #inicializa a pontuacao bonus
  #jal PrintPoints
  ret
  
CountBonusCycle:
  beq s9, zero, RTCYCLE
  blt s9, zero, RTCYCLE
  addi s9, s9, -10
  ret
RTCYCLE:
  addi s9, zero, 0
  ret

CountPoint: #conta a pontuacao feita pelo jogador e salva em s0
  addi s10, s10, 1 #add mais um ponto a cada chamada do contador
  ret

PrintPoints:
  addi a0, s10, 0 #carrega o valor salvo da pontuaçao do usuario em a0
  li a1, XIpoints #carrega a posicao da pontuacao a ser printada
  li a2, YIpoints
  li a4, 0
  li a3, CorPoints #carrega as cores dos pontos
  li a7, 101
  M_Ecall
  addi a0, s9, 0 #carrega a pontuacao bonus
  li a1, XBpoints
  li a2, YBpoints
  M_Ecall
  #addi a7, zero, 1
  #ecall
  ret
