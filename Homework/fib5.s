#Juan Garcia
#CMPS 224 / Professor Cruz
#October 3, 2014

#Homework 4 / Problem 5

.data

newline:
    .asciiz "\n"
msg:
    .asciiz "Welcome! Enter the limit: "

.text
.globl main

main:
    #--------------------fib function begins
    addi $sp, $sp, -32
    sw $ra, 20($sp)
    sw $fp, 16($sp)
    addi $fp, $sp, 28

    #jal fib
    #move $t0, $v0

    la $a0, msg
    jal printf

    jal fib

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
