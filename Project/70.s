#70.s
#Juan Garcia
#cs224 Final Project - Wtr 2014
#This code displays the nth row of pascal's triangle
#usage: spim -f 70.s n k

#Week 4, 70% - read n,k from cmdline; convert to ints; swap if n < k

.data

newline: .asciiz "\n"
usage_stmt: .asciiz "\nUsage: spim -f 70.s <int> <int>\n"
onespace: .asciiz " "

.text
.globl read
.globl main
.ent main

main:

    jal read

.end main

read:

    #grab command line stuff - a0 is arg count and a1 points to list of args
    move $s0, $a0
    move $s1, $a1

    #zero out these registers just to be safe
    move $s2, $zero
    move $s3, $zero
    move $s4, $zero

    #parse the first number
    lw $a0, 4($s1)
    jal atoi
    move $s2, $v0

    #parse the second number
    lw $a0, 8($s1)
    jal atoi
    move $s3, $v0

    #load a0 and a1 with two integers
    move $a0, $s2
    move $a1, $s3

    move $t0, $a0
    move $t1, $a1

    j swap_n_and_k

swap_n_and_k:

    slt $t3, $t0, $t1       #t1 = (i < size) ? 1 : 0;
    beq $t3, $zero, Exit    #Exit if i >= size
    move $t5, $t0
    move $t0, $t1
    move $t1, $t5

    jal print

print:

    #move the result from t0 to v0 to print it
    move $a0, $t0

    li $v0, 1
    syscall

    la $a0, onespace
    li $v0, 4
    syscall

    move $a0, $t1

    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10
    syscall

Exit:

    move $a0, $t0

    li $v0, 1
    syscall

    la $a0, onespace
    li $v0, 4
    syscall

    move $a0, $t1

    li $v0, 1
    syscall

    la $a0, newline          #Display a newline
    li $v0, 4
    syscall

    li $v0, 10              #Exit
    syscall

#----------ATOI FUNCTION
atoi:

    move $v0, $zero

    #detect sign
    li $t0, 1
    lbu $t1, 0($a0)
    bne $t1, 45, digit
    li $t0, -1
    addu $a0, $a0, 1

digit:

    #read character
    lbu $t1, 0($a0)

    #finish when non-digit encountered
    bltu $t1, 48, finish
    bgtu $t1, 57, finish

    #translate character into digit
    subu $t1, $t1, 48

    #multiplu the accumulator by ten
    li $t2, 10
    mult $v0, $t2
    mflo $v0

    #add digit to the accumulator
    add $v0, $v0, $t1

    #next character
    addu $a0, $a0, 1
    b digit

finish:

    mult $v0, $t0
    mflo $v0
    jr $ra
#-----------------------
