# declaração de posicoes de memoria
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

# iniciando leituras
.text 
#numeroVotosChapa1 $t1
#numeroVotosChapa2 $t2
#numeroVotosChapa3 $t3
#numeroVotosEmBranco $t4
#numeroVotosNulo $t5
#numeroVotosTotais $t6
#numeroVotosValidos $t7

# inicio laço votação
LacoVotacao:
	li $v0, 51
	la $a0, msgEleitor
	syscall
	add $t6, $t6, 1
	beq $a0, 0, AdicionaVotoEmBranco
	beq $a0, 1, AdicionaVotoChapa1
	beq $a0, 2, AdicionaVotoChapa2
	beq $a0, 3, AdicionaVotoChapa3	
	b AdicionaVotoNulo

AdicionaVotoChapa1:
	add $t1, $t1, 1
	add $t7, $t7, 1
	ble $t6, 5, LacoVotacao
	b ImprimirResultado

AdicionaVotoChapa2:
	add $t2, $t2, 1
	add $t7, $t7, 1
	ble $t6, 5, LacoVotacao
	b ImprimirResultado
	
AdicionaVotoChapa3:
	add $t3, $t3, 1
	add $t7, $t7, 1
	ble $t6, 5, LacoVotacao
	b ImprimirResultado
	
AdicionaVotoEmBranco:
	add $t4, $t4, 1
	ble $t6, 5, LacoVotacao
	b ImprimirResultado
	
AdicionaVotoNulo:
	add $t5, $t5, 1
	ble $t6, 5, LacoVotacao
	b ImprimirResultado

ImprimirResultado:
	li $v0, 4
	la $a0, msgChapa1
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, msgChapa2
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 4
	la $a0, msgChapa3
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, msgBranco
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall

	li $v0, 4
	la $a0, msgNulo
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall

	div $t0, $t7, 2
	bgt $t1, $t0, ImprimeChapa1Vencedora
	bgt $t2, $t0, ImprimeChapa2Vencedora
	bgt $t3, $t0, ImprimeChapa3Vencedora
	
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