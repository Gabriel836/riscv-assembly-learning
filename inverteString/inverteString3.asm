# Salvo a string na stack na forma original
# depois espelho ela no mesmo espaco alocado.
# Nao da pra salvar a string byte a byte na
# stack por causa do alinhamento da memoria.

.data
.align 0
    str1: .asciz "Estou testando uma string bem grande"

.text
.align 2
.globl main

main:
    la s0, str1         # s0: st1 ptr
    
loopSize:               # Descubro o tamanho da string
    slli t1, t0, 2
    add t1, s0, t1
    lw t1, 0(t1)
    beqz t1, saiLoop1
    addi t0, t0, 1
    j loopSize

saiLoop1:
    add s1, zero, t0    # s1: Tamanho da string em words
    slli t1, s1, 2
    not t1, t1
    addi t1, t1, 1

    add sp, sp, t1      # Espaco do tamaho da string alocado na stack
    add s2, zero, sp    # s2: ptr stack

loopCopia:
    bgt t4, s1, saiLoop2
    slli t0, t4, 2
    add t5, zero, t0

    add t0, t0, s2      # t0: OutStr ptr offset
    add t5, t5, s0      # t5: str1 ptr offset

    lw t5, 0(t5)
    sw t5, 0(t0)
    
    addi t4, t4, 1
    j loopCopia

saiLoop2:
    slli t0, s1, 2
    addi t0, t0, -1
    add t0, s2, t0

byteNaoNulo:
    lb t1, 0(t0)
    bnez t1, saiLoop3
    addi t0, t0, -1
    j byteNaoNulo

saiLoop3:
    add t1, zero, s2    # t0: ultimo byte; t1: primeiro byte

loopInversao:
    ble t0, t1, saiLoop4
    lb t2, 0(t0)
    lb t3, 0(t1)
    sb t2, 0(t1)
    sb t3, 0(t0)
    addi t0, t0, -1
    addi t1, t1, 1
    j loopInversao

saiLoop4:
    addi a7, zero, 4
    add a0, zero, s2
    ecall

    addi a7, zero, 10
    ecall



