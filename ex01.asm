# Bloco de código destinado a variável
.data
inputNota1 : .asciiz "Digite a nota da primeira prova: "
inputNota2 : .asciiz "Digite a nota da segunda prova: "
inputNota3 : .asciiz "Digite a nota da terceira prova: "
outputFinal : .asciiz "Nota final: "
pesoNota1 : .float 1.0
pesoNota2 : .float 2.0
pesoNota3 : .float 3.0
numeroDeNotasVezesPeso : .float 6.0

# Bloco de código destinado a instruções
.text

# carregando peso das notas
lwc1 $f28, numeroDeNotasVezesPeso
lwc1 $f29, pesoNota1
lwc1 $f30, pesoNota2  
lwc1 $f31, pesoNota3


# exibindo mensagem nota 1
li $v0, 52
la $a0, inputNota1
syscall

# movendo para local definitivo nota 1
mov.s $f1, $f0

# exibindo mensagem nota 2
li $v0, 52
la $a0, inputNota2
syscall

# movendo para local definitivo nota 2
mov.s $f2, $f0

# exibindo mensagem nota 3
li $v0, 52
la $a0, inputNota3
syscall

# movendo para local definitivo nota 3
mov.s $f3, $f0

# multiplicando peso da nota 1
mul.s $f1, $f1, $f29

# multiplicando peso da nota 2
mul.s $f2, $f2, $f30

# multiplicando peso da nota 3
mul.s $f3, $f3, $f31

# somando nota final = nota1 + nota2
add.s $f12, $f1, $f2

# somando nota final = (nota1 + nota2) + nota3
add.s $f12, $f12, $f3

# divindindo pela quantidade de notas
div.s $f12, $f12, $f28

# exibindo mensagem final
li $v0, 4
la $a0, outputFinal
syscall

# escrevendo resultado final na tela
li $v0, 2
syscall

# finalizando o programa
li $v0, 10
