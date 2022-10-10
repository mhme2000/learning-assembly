# Bloco de código destinado a variável
.data 
msgEleitor: .asciiz "Vote 1 para chapa 1, 2 para chapa 2, 3 para chapa 3, e 0 para voto em branco: "
msgChapa1: .asciiz  "Quantidade de votos chapa 1:  "
msgChapa2: .asciiz  " - Quantidade de votos chapa 2:  "
msgChapa3: .asciiz  " - Quantidade de votos chapa 3:  "
msgBranco: .asciiz  " - Quantidade de votos em branco:  "
msgNulo: .asciiz  " - Quantidade de votos nulos:  "
msgSegundoTurno: .asciiz  " - Votação irá para o segundo turno. "
msgChapa1Vencedora: .asciiz  " - Votação foi vencida pela chapa 1 em primeiro turno."
msgChapa2Vencedora: .asciiz  " - Votação foi vencida pela chapa 2 em primeiro turno."
msgChapa3Vencedora: .asciiz  " - Votação foi vencida pela chapa 3 em primeiro turno."

# Bloco de código destinado a instruções
.text 

#numeroVotosChapa1 $t1
#numeroVotosChapa2 $t2
#numeroVotosChapa3 $t3
#numeroVotosEmBranco $t4
#numeroVotosNulo $t5
#numeroVotosTotais $t6
#numeroVotosValidos $t7

# início laço votação
LacoVotacao:
	# Input para eleitor inserir seu voto
	li $v0, 51
	la $a0, msgEleitor
	syscall

	# Computando o voto do eleitor a quantidade de votos totais
	add $t6, $t6, 1

	beq $a0, 0, AdicionaVotoEmBranco
	beq $a0, 1, AdicionaVotoChapa1
	beq $a0, 2, AdicionaVotoChapa2
	beq $a0, 3, AdicionaVotoChapa3	
	b AdicionaVotoNulo

AdicionaVotoChapa1:
	# Computando o voto do eleitor a quantidade de votos da chapa 1
	add $t1, $t1, 
	
	# Computando o voto do eleitor a quantidade de votos válidos
	add $t7, $t7, 1

	# Retorna ao laço caso a quantidade total de eleitores seja menor ou igual a 199
	blt $t6, 199, LacoVotacao
	b ImprimirResultado

AdicionaVotoChapa2:
	# Computando o voto do eleitor a quantidade de votos da chapa 2
	add $t2, $t2, 1

	# Computando o voto do eleitor a quantidade de votos válidos
	add $t7, $t7, 1

	# Retorna ao laço caso a quantidade total de eleitores seja menor ou igual a 199
	ble $t6, 199, LacoVotacao
	b ImprimirResultado
	
AdicionaVotoChapa3:
	# Computando o voto do eleitor a quantidade de votos da chapa 3
	add $t3, $t3, 1
	
	# Computando o voto do eleitor a quantidade de votos válidos
	add $t7, $t7, 1

	# Retorna ao laço caso a quantidade total de eleitores seja menor ou igual a 199
	ble $t6, 199, LacoVotacao
	b ImprimirResultado
	
AdicionaVotoEmBranco:
	# Computando o voto do eleitor a quantidade de votos em branco
	add $t4, $t4, 1

	# Retorna ao laço caso a quantidade total de eleitores seja menor ou igual a 199
	ble $t6, 199, LacoVotacao
	b ImprimirResultado
	
AdicionaVotoNulo:
	# Computando o voto do eleitor a quantidade de votos nulos
	add $t5, $t5, 1

	# Retorna ao laço caso a quantidade total de eleitores seja menor ou igual a 199
	ble $t6, 199, LacoVotacao
	b ImprimirResultado

ImprimirResultado:
	# Imprimir mensagem de votos da chapa 1
	li $v0, 4
	la $a0, msgChapa1
	syscall
	
	# Imprimir quantidade de votos da chapa 1
	li $v0, 1
	move $a0, $t1
	syscall

	# Imprimir mensagem de votos da chapa 2
	li $v0, 4
	la $a0, msgChapa2
	syscall

	# Imprimir quantidade de votos da chapa 2
	li $v0, 1
	move $a0, $t2
	syscall

	# Imprimir mensagem de votos da chapa 3
	li $v0, 4
	la $a0, msgChapa3
	syscall
	
	# Imprimir quantidade de votos da chapa 3
	li $v0, 1
	move $a0, $t3
	syscall

	# Imprimir mensagem de votos em branco
	li $v0, 4
	la $a0, msgBranco
	syscall

	# Imprimir quantidade de votos em branco
	li $v0, 1
	move $a0, $t4
	syscall

	# Imprimir mensagem de votos nulos
	li $v0, 4
	la $a0, msgNulo
	syscall

	# Imprimir quantidade de votos nulos
	li $v0, 1
	move $a0, $t5
	syscall

	# Verifica se alguma chapa atingiu mais de 50 por cento dos votos válidos
	div $t0, $t7, 2
	bgt $t1, $t0, ImprimeChapa1Vencedora
	bgt $t2, $t0, ImprimeChapa2Vencedora
	bgt $t3, $t0, ImprimeChapa3Vencedora
	
	# Imprimir mensagem de segundo turno
	li $v0, 4
	la $a0, msgSegundoTurno
	syscall
	
	b Fim
	
ImprimeChapa1Vencedora:
	li $v0, 4
	la $a0, msgChapa1Vencedora
	syscall
	b Fim
	
ImprimeChapa2Vencedora:
	li $v0, 4
	la $a0, msgChapa2Vencedora
	syscall
	b Fim
	
ImprimeChapa3Vencedora:
	li $v0, 4
	la $a0, msgChapa3Vencedora
	syscall
	b Fim

Fim:
	# finalizando o programa
	li $v0, 10