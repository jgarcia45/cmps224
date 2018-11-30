#Juan Garcia
#CMPS 224 / Professor Cruz
#October 3, 2014

#Homework 4 / Problem 4

.data

newline:
    .asciiz "\n"
msg:
    .asciiz "Welcome! Enter the limit: "
fibarray:
    .space 80

.text
.globl main

main:
    la $a0, msg
    jal printf

    li $v0, 5
    syscall

    move $a0, $v0

    jal fib

.end main

#--------------------Fibonacci Function
fib:
    subu $sp, $sp, 32
    sw $ra, 28($sp)
    sw $fp, 24($sp)
    sw $s0, 20($sp)
    sw $s1, 16($sp)
    sw $s2, 12($sp)
    addu $fp, $sp, 32

    move $s0, $a0

    blt $s0, 2, fib_base_case

    sub $a0, $s0, 1
    jal fib
    move $s2, $v0

    add $v0, $s1, $s2
    b fib_return

fib_base_case:
    move $v0, $s0

fib_return:
    lw $ra, 28($sp)
    lw $fp, 24($sp)
    lw $s0, 20($sp)
    lw $s1, 16($sp)
    lw $s2, 12($sp)
    addu $sp, $sp, 32
    jr $ra
