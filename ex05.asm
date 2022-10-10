# Bloco de código destinado a variável
.data 
msgOutput: .asciiz "Valor de S: "

# Bloco de código destinado a instruções
.text 

# montando primeira parte da fração da sequência - numerador
addi $t1, $t1, 1

# convertendo valor do numerador para ponto flutuante
mtc1 $t1, $f1
cvt.s.w $f1, $f1

# montando primeira parte da fração da sequência - denominador
addi $t2, $t2, 1

# convertendo valor do denominador para ponto flutuante
mtc1 $t2, $f2
cvt.s.w $f2, $f2

# montando fração - numerador dividido pelo denominador
div.s $f3, $f1, $f2

# adicionando valor ao registrador da somatória
add.s $f12, $f12, $f3	

# início laço somatório
somatorio: 
	# montando numerador fração
	addi $t1, $t1, 2

	# convertendo valor do numerador para ponto flutuante
	mtc1 $t1, $f1
	cvt.s.w $f1, $f1

	# montando denominador fração	
	addi $t2, $t2, 1

	# convertendo valor do numerador para ponto flutuante	
	mtc1 $t2, $f2
	cvt.s.w $f2, $f2

	# montando fração - numerador dividido pelo denominador	
	div.s $f3, $f1, $f2

	# adicionando valor ao registrador da somatória	
	add.s $f12, $f12, $f3

	# desvia para a label somatorio caso o valor do denominador seja menor que 50	
	blt $t2, 50, somatorio	

# imprimir mensagem do somatório S
li $v0, 4
la $a0, msgOutput
syscall

# imprimir valor do somatório S
li $v0, 2
syscall

# finalizando o programa
li $v0, 10