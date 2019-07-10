.data
.text
# Funcao de animacoa do DK
LoaderDK: # ler do enderco DKPosition retorna em a2 sprite do DK a ser printado
	#la t0,DKPosition
	lw t0, 0(t0)
	li t1,0
	la a2,dnk_frente
	beq t1,t0,endLoaderDK
	la a2,dnk_frente_handUp_dir
	beq t1,t0,endLoaderDK
	la a2,dnk_frente_handUp_esq
	endLoaderDK: ret
