# declaração de posicoes de memoria
.data 
msgOutput: .asciiz "Valor de S: "

# iniciando leituras
.text 
# carregando peso das notas
addi $t1, $t1, 1
mtc1 $t1, $f1
cvt.s.w $f1, $f1
addi $t2, $t2, 1
mtc1 $t2, $f2
cvt.s.w $f2, $f2
div.s $f3, $f1, $f2
add.s $f12, $f12, $f3	

# inicio laço somatoria
somatorio: 
	addi $t1, $t1, 2
	mtc1 $t1, $f1
	cvt.s.w $f1, $f1
	addi $t2, $t2, 1
	mtc1 $t2, $f2
	cvt.s.w $f2, $f2
	div.s $f3, $f1, $f2
	add.s $f12, $f12, $f3	
	blt $t2, 50, somatorio	

li $v0, 4
la $a0, msgOutput
syscall

li $v0, 2
syscall

# finalizando o programa
li $v0, 10