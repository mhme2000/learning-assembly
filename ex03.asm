.data 
msgInput : .asciiz "Entre com a quantidade de horas de estacionamento: "
msgHoras : .asciiz "Tempo em horas: "
msgMinutos : .asciiz " - Tempo em minutos: "
msgValor : .asciiz " -> Valor a ser pago: "
msgPercentual1 : .asciiz "nenhum crédito "
msgPercentual2 : .asciiz "20% do valor do saldo médio "
msgPercentual3 : .asciiz "30% do valor do saldo médio "
msgPercentual4 : .asciiz "40% do valor do saldo médio "

.text
# carregando valores para comparação
li $t6, 10
li $t7, 17
li $t8, 30
li $t1, 60

# exibindo mensagem de input para horas estacionamento
li $v0, 51
la $a0, msgInput
syscall

# movendo para local definitivo saldo médio
move $t2, $a0

# calculando valor em horas
div $t3, $t2, $t1
rem $t4, $t2, $t1

# exibindo mensagem horas na tela
li $v0, 4
la $a0, msgHoras
syscall

# escrevendo horas na tela
move $a0, $t3
li $v0, 1
syscall

# exibindo mensagem minutos na tela
li $v0, 4
la $a0, msgMinutos
syscall

# escrevendo minutos na tela
move $a0, $t4
li $v0, 1
syscall

# exibindo mensagem crédito na tela
li $v0, 4
la $a0, msgValor
syscall

beqz $t4, Condicional
ArredondaHora:
	add $t3, $t3, 1
Condicional:
	# testa se o valor armazenado em $t2 é menor ou igual a 120
	bleu $t2, 120, ValorHora1
	# testa se o valor armazenado em $f12 é menor ou igual a 240
	bleu $t2, 240, ValorHora2
	b ValorHora3

ValorHora1:
	mulu $a0, $t3, $t6
	li $v0, 1
	syscall
	b Fim

ValorHora2:
	mulu $a0, $t3, $t7
	li $v0, 1
	syscall
	b Fim
	
ValorHora3:
	mulu $a0, $t3, $t8
	li $v0, 1
	syscall
	b Fim
	
Fim:
	# finalizando o programa
	li $v0, 10

