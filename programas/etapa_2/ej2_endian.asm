# Ejercicio 2 -- Big-endian: los bytes de una palabra
# Instrucciones: lbu, sb (+ las de la Etapa 1)
#
# X = 0x11223344 está en 0x200. ArquiSim es BIG-ENDIAN: el byte más significativo
# va en la dirección MENOR.
#
# 1. Cargue con lbu los bytes de 0x200, 0x201, 0x202 y 0x203 en $s0, $s1, $s2 y $s3.
#    Prediga cada valor ANTES de ejecutar.
# 2. Escriba en Y (0x204) la misma palabra en orden LITTLE-ENDIAN, byte por byte con sb
#    (el byte menos significativo en la dirección menor).
# 3. Lea Y como palabra con lw en $s4: ¿qué número ve un procesador big-endian?
#
# Preguntas: ¿cómo cambiaría su respuesta del punto 1 en un procesador little-endian
# (como x86)? ¿Por qué importa esto al enviar datos entre dos computadores?
#
# Complete ej2_endian.esperado y verifique con:
#   ./sim -t programas/etapa_2/ej2_endian.asm
.data
X:      .word 0x11223344
Y:      .space 4
.text
# escriba aquí su código

# 1. Cargar bytes de X (Big-Endian)
        ori  $t0, $zero, X       # $t0 = dirección base de X
        lbu  $s0, 0($t0)         # $s0 = 0x11 (Predicción: byte más significativo)
        lbu  $s1, 1($t0)         # $s1 = 0x22
        lbu  $s2, 2($t0)         # $s2 = 0x33
        lbu  $s3, 3($t0)         # $s3 = 0x44 (Predicción: byte menos significativo)

# 2. Escribir en Y (0x204) en orden Little-Endian byte por byte con sb
        ori  $t1, $zero, Y       # $t1 = dirección base de Y
        sb   $s3, 0($t1)         # Guarda 0x44 en Y+0 (el byte menor va en la dirección menor)
        sb   $s2, 1($t1)         # Guarda 0x33 en Y+1
        sb   $s1, 2($t1)         # Guarda 0x22 en Y+2
        sb   $s0, 3($t1)         # Guarda 0x11 en Y+3

# 3. Leer Y como palabra con lw en $s4
        lw   $s4, 0($t1)         # $s4 contendrá el valor 0x44332211
