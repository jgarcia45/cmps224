#Juan Garcia
#CMPS 224 / Professor Cruz
#October 17, 2014

#Homework 5 / Problem A.6

.data

Message: .asciiz "Enter a Value: "
NewLine: .asciiz "\n"
Summation: .asciiz "The Summation of the Numbers is "

.text
.globl main
.ent main

main:
    li $a0, 0

Ask_User:
    la $a0, Message
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $t0, $v0

    add $t1, $t1, $t0
    bne $t0, $zero, Ask_User

    jal Print_And_Exit

Print_And_Exit:
    la $a0, Summation
    li $v0, 4
    syscall

    move $a0, $t1

    li $v0, 1
    syscall

    la $a0, NewLine
    li $v0, 4
    syscall

    li $v0, 10
    syscall
