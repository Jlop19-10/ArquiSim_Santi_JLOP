# Programa 24 -- Reto: contar los números negativos de un arreglo
#
#   int CONTAR(int *A, int n)   { cuenta cuántos A[i] < 0 }
#   RES = CONTAR(ARR, 8);       // se guarda en .data con sw
#   Se pinta un píxel ROJO por cada negativo, en la fila 0 de la pantalla.
#
# Convención: $a0 = dirección del arreglo, $a1 = tamaño, $v0 = resultado.
# Necesita: lw, sw, sb, sll, slt, beq, j, jal, jr (+ pseudoinstrucciones li y la)

.data
ARR:    .word 5, -3, 8, -1, 0, -7, 12, -20    # 8 palabras: 4 son negativas
RES:    .word 0                               # aquí se guarda el resultado

.text
main:   la   $a0, ARR               # $a0 = dirección del arreglo (0x200)
        li   $a1, 8                 # $a1 = tamaño
        jal  CONTAR                 # $v0 = cantidad de negativos ($ra = PC + 4)
        sw   $v0, RES($zero)        # RES = $v0

# Pintar un píxel rojo (color 1) por cada negativo en la fila 0: (0,0), (1,0), ...
        li   $t0, 0x400             # base de la pantalla = píxel (0, 0)
        li   $t1, 1                 # color rojo
        add  $t2, $zero, $zero      # x = 0
PINTAR: beq  $t2, $v0, FIN          # ya se pintaron $v0 píxeles
        add  $t3, $t0, $t2          # dirección del píxel (x, 0)
        sb   $t1, 0($t3)
        addi $t2, $t2, 1
        j    PINTAR

# int CONTAR(int *A, int n)
CONTAR: add  $v0, $zero, $zero      # cuenta = 0
        add  $t0, $zero, $zero      # i = 0
CLOOP:  beq  $t0, $a1, CRET         # si i == n, terminar
        sll  $t1, $t0, 2            # 4 * i
        add  $t1, $a0, $t1          # &A[i]
        lw   $t2, 0($t1)            # $t2 = A[i]
        slt  $t3, $t2, $zero        # $t3 = 1 si A[i] < 0
        add  $v0, $v0, $t3          # cuenta += $t3
        addi $t0, $t0, 1            # i++
        j    CLOOP
CRET:   jr   $ra                    # volver a main
FIN:
