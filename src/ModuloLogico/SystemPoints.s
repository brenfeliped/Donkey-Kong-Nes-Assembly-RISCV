# sistema de pontos
BeginPoints:
addi sp,sp,-4
sw ra,0(sp)
la a2,n0 # enderesso incial do numero 0
li a0,41 # x incial
li a1,24 # y incial
jal print_sprite
lw ra, 0(sp)
addi sp,sp,4
ret