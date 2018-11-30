#Juan Garcia
#CMPS 224 / Professor Cruz
#October 3, 2014

#Homework 3 / Problem 7

.data

newline:
    .asciiz "\n"
usage_stmt:
    .asciiz "\nUsage: spim -f fib.s <int> \n"
msg:
    .asciiz "The n-th Fibonacci number is "

.text
.globl main

main:
    move $s0, $a0
    move $s1, $a1

    move $s2, $zero
    move $s3, $zero
    move $s4, $zero

    li $t0, 3
    blt $a0, $t0, exit_on_error

    lw $a0, 4($s1)
    jal atoi
    move $s2, $v0

    lw $a0, 8($s1)
    jal atoi
    move $s3, $v0

    move $a0, $s2
    move $a1, $s3

    #--------------------fib function begins
    addi $sp, $sp, -32
    sw $ra, 20($sp)
    sw $fp, 16($sp)
    addi $fp, $sp, 28

    jal fib
    move $t0, $v0

    la $a0, msg
    jal printf

    move $a0, $t0
    li $v0,1
    syscall

    li $a0, 10
    li $v0, 11
    syscall

    lw $ra, 20($sp)
    lw $fp, 16($sp)
    addi $sp, $sp, 32

    li $v0, 10
    syscall

.end main

#--------------------Fibonacci Function
fib:
    addi $sp, $sp, -32
    sw $ra, 20($sp)
    sw $fp, 16($sp)
    addi $fp, $sp, 28
    sw $a0, 0($fp)

    lw $v0, 0($fp)

    move $v0, $zero
    beq $s0, $zero, L1

    addi $v0, $zero, 1
    beq $s0, $t0, L1

    jal L2

L2:
    lw $v1, 0($fp)
    addi $v0, $v1, -1
    move $a0, $v0
    jal fib

    sw $v0, 4($sp)

    lw $v1, 0($fp)
    addi $v0, $v1, -2
    move $a1, $v1
    jal fib

    sw $v1, 4($sp)

    lw $v0, 4($sp)
    lw $v1, 4($sp)

    addu $v0, $v0, $v1

L1:
    lw $ra, 20($sp)
    lw $fp, 16($sp)
    addi $sp, $sp, 32
    jr $ra

.end fib

#--------------------Atoi Function
exit_on_error:
    li $v0, 4
    la $a0, usage_stmt
    syscall
    li $v0, 10
    syscall

atoi:
    move $v0, $zero

    li $t0, 1
    lbu $t1, 0($a0)
    bne $t1, 45, digit
    li $t0, -1
    addu $a0, $a0, 1

digit:
    lbu $t1, 0($a0)

    bltu $t1, 48, finish
    bgtu $t1, 57, finish

    subu $t1, $t1, 48

    li $t2, 10
    mult $v0, $t2
    mflo $v0

    add $v0, $v0, $t1

    addu $a0, $a0, 1
    b digit

finish:
    mult $v0, $t0
    mflo $v0
    jr $ra
