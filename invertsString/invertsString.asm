# This code inverts the characters of a string located on main memory

# String is saved on stack
# just like its read and then
# manipulated there. Apparently
# you cant save char by char
# since stack has 16-bit alignment

# Still coudnt implement user input

.data
.align 0
    str1: .asciz "Estou testando uma string bem grande"

.text
.align 2
.globl main

main:
    la s0, str1         # s0: st1 ptr
    
loopSize:               # find string size
    slli t1, t0, 2
    add t1, s0, t1
    lw t1, 0(t1)
    beqz t1, exitLoop1
    addi t0, t0, 1
    j loopSize

exitLoop1:
    add s1, zero, t0    # s1: string size in words
    slli t1, s1, 2
    not t1, t1
    addi t1, t1, 1

    add sp, sp, t1      # alloc space into the stack
    add s2, zero, sp    # s2: ptr stack

copyLoop:
    bgt t4, s1, exitLoop2
    slli t0, t4, 2
    add t5, zero, t0

    add t0, t0, s2      # t0: OutStr ptr offset
    add t5, t5, s0      # t5: str1 ptr offset

    lw t5, 0(t5)
    sw t5, 0(t0)
    
    addi t4, t4, 1
    j copyLoop

exitLoop2:
    slli t0, s1, 2
    addi t0, t0, -1
    add t0, s2, t0

nonNullByte:
    lb t1, 0(t0)
    bnez t1, exitLoop3
    addi t0, t0, -1
    j nonNullByte

exitLoop3:
    add t1, zero, s2    # t0: last byte; t1: first byte

inversionLoop:
    ble t0, t1, exitLoop4
    lb t2, 0(t0)
    lb t3, 0(t1)
    sb t2, 0(t1)
    sb t3, 0(t0)
    addi t0, t0, -1
    addi t1, t1, 1
    j inversionLoop

exitLoop4:
    addi a7, zero, 4
    add a0, zero, s2
    ecall

    addi a7, zero, 10
    ecall



