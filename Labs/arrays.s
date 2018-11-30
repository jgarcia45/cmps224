#Juan Garcia
#CMPS 244 / Professor Cruz
#October 7, 2014

#Lab 4: Arrays, Loops, 2-way Branching
#Part 1: Loops

.data
array:
      .space 30
space:
      .asciiz " "
newline:
      .asciiz "\n"
.text
.globl main

main:
    #la $s1, array
    #addi $t0, $zero, 0
    #li $s0, 30

loop1:
    la $s1, array
    addi $t0, $zero, 0
    li $s0, 30

    beq $t0, $s0, exit1
    sll $t2, $t0, 1
    addi $t2, $t2, -1
    sw $t2, ($s1)

    j print_loop1

    addi $t0, $t0, 1
    addi $s1, $s1, 4
    j loop1

print_loop1:
    li $v0, 1
    lw $a0, ($t0)
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, 4
    addi $t1, 1
    ble $t1, $t5, print_loop1

    li $v0, 4
    la $a0, newline
    syscall

exit1:
    li $v0, 10
    li $a0, 0
    syscall

loop2:
    addi $t0, $zero, 0
    la $s1, array
    li $s7, 3
    li $s6, 7

    beq $t0, $s0, exit2
    lw $a0, ($s1)

    div $a0, $s7
    mfhi $a0
    beqz $a0, print_loop2

    div $a1, $s6
    mfhi $a1
    beqz $a1, print_loop2

    addi $t0, $t0, 1
    addi $s1, $s1, 4

    j print_loop2

print_loop2:
    li $v0, 1
    lw $a0, ($t0)
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, 4
    addi $t1, 1
    ble $t1, $t5, print_loop2

    li $v0, 4
    la $a0, newline
    syscall

    j loop2

exit2:
    li $v0, 10
    li $a0, 0
    syscall
