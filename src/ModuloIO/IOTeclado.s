.eqv bufft 0xff200000 #buffer de teclado

.data
.text
scanTeclado:
  li t0, bufft
  lw a0, 0(t0) #ler a flag do teclado
  andi a0, a0, 0x0001 #mascara o bit 0
  beq a0, zero, scanTeclado #testa se uma tecla foi pressionada
  lw a0, 4(t0)
  ret
