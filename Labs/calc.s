#Juan Garcia
#CMPS 224 / Professor Cruz
#October 21, 2014

#Lab 6, Parsing Command Line Arguments

.data

iprompt: .asciiz "Enter an integer: \n"
newline: .asciiz "\n"
Even: .asciiz "EVEN"
Odd: .asciiz "ODD"

.text
.globl read
.globl main
.ent  main

main:

    jal read

.end  main

read:

    move $s0, $a0
    move $s1, $a1

    lw $a0, 4($s1)
    jal atoi
    move $s3, $v0

    lw $t5, 8($s1)
    lb $t5, ($t5)

    lw $a0, 12($s1)
    jal atoi
    move $s4, $v0

    beq $t5, 43, addition
    beq $t5, 45, subtraction
    beq $t5, 42, multiplication

addition:
    add $s5, $s3, $s4

    li $s7, 2
    div $s5, $s7
    mfhi $s7

    beq $s7, $zero, print_even_value

    jal print_odd_value

subtraction:
    sub $s5, $s3, $s4

    li $s7, 2
    div $s5, $s7
    mfhi $s7

    beq $s7, $zero, print_even_value

    jal print_odd_value

multiplication:
    mul $s5, $s3, $s4

    li $s7, 2
    div $s5, $s7
    mfhi $s7

    beq $s7, $zero, print_even_value

    jal print_odd_value

print_even_value:
    move $a0, $s5
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, Even
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10
    syscall

print_odd_value:
    move $a0, $s5
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, Odd
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10
    syscall

#-----------ATOI FUNCTION
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
#------------------------
