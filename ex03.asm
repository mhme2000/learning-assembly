# Bloco de código destinado a variável
.data 
msgInput : .asciiz "Entre com o tempo de estacionamento (em minutos): "
msgHoras : .asciiz "Tempo em horas: "
msgMinutos : .asciiz " - Tempo em minutos: "
msgValor : .asciiz " -> Valor a ser pago: "
msgPercentual1 : .asciiz "nenhum crédito "
msgPercentual2 : .asciiz "20% do valor do saldo médio "
msgPercentual3 : .asciiz "30% do valor do saldo médio "
msgPercentual4 : .asciiz "40% do valor do saldo médio "

# Bloco de código destinado a instruções
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

# movendo saldo médio para local definitivo 
move $t2, $a0

# calculando valor em horas
div $t3, $t2, $t1

# calculando resto em minutos
rem $t4, $t2, $t1

# exibindo mensagem de horas na tela
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

# exibindo mensagem de valor total na tela
li $v0, 4
la $a0, msgValor
syscall

# arredonda o valor da hora para cima, caso a quantidade em minutos seja maior que zero
beqz $t4, Condicional
ArredondaHora:
	add $t3, $t3, 1
Condicional:
	# testa se o valor armazenado em $t2 é menor ou igual a 120
	bleu $t2, 120, ValorHora1
	# testa se o valor armazenado em $t2 é menor ou igual a 240
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

