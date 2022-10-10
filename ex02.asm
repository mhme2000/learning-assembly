# Bloco de código destinado a variável
.data 
msgInput : .asciiz "Entre com saldo médio: "
msgSaldo : .asciiz "Saldo médio de: "
msgCredito : .asciiz " -> Valor do crédito: "
msgPercentual1 : .asciiz "nenhum crédito "
msgPercentual2 : .asciiz "20% do valor do saldo médio "
msgPercentual3 : .asciiz "30% do valor do saldo médio "
msgPercentual4 : .asciiz "40% do valor do saldo médio "
comparacao1 : .float 200.0
comparacao2 : .float 400.0
comparacao3 : .float 600.0

# Bloco de código destinado a instruções
.text
# carregando valores para comparação
lwc1 $f29, comparacao1
lwc1 $f30, comparacao2  
lwc1 $f31, comparacao3

# exibindo mensagem de input para saldo médio
li $v0, 52
la $a0, msgInput
syscall

# movendo para local definitivo saldo médio
mov.s $f12, $f0

# exibindo mensagem saldo na tela
li $v0, 4
la $a0, msgSaldo
syscall

# escrevendo saldo na tela
li $v0, 2
syscall

# exibindo mensagem crédito na tela
li $v0, 4
la $a0, msgCredito
syscall

# testa se o valor armazenado em $f12 é menor ou igual a 200
c.le.s $f12, $f29
bc1t NenhumCredito
# testa se o valor armazenado em $f12 é menor ou igual a 400
c.le.s $f12, $f30
bc1t VintePorCentoCredito
# testa se o valor armazenado em $f12 é menor ou igual a 600
c.le.s $f12, $f31
bc1t TrintaPorCentoCredito
b QuarentaPorCentoCredito

NenhumCredito:
	li $v0, 4
	la $a0, msgPercentual1
	syscall
	b Fim

VintePorCentoCredito:
	li $v0, 4
	la $a0, msgPercentual2
	syscall
	b Fim
	
TrintaPorCentoCredito:
	li $v0, 4
	la $a0, msgPercentual3
	syscall
	b Fim

QuarentaPorCentoCredito:
	li $v0, 4
	la $a0, msgPercentual4
	syscall
	b Fim
	
Fim:
	# finalizando o programa
	li $v0, 10

