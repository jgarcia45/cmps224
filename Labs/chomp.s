#Juan Garcia
#CMPS 224 / Professor Cruz
#October 28, 2014

#Lab 7: Removal of Whitespace

.data

buffer: .space 50
mystring: .asciiz "Enter a word followed by whitespace[Tab]: "
newline: .asciiz "\n"
period: .asciiz "."

.text
.globl main
.globl swap

main:

    li $v0, 4
    la $a0, mystring
    syscall

    la $a0, buffer
    li $v0, 8
    syscall

    move $t0, $a0

find_end:

    lbu $t1, 0($t0)
    beqz $t1, done

    addu $t0, $t0, 1

    b find_end

done:

    subu $t0, $t0, 1

swap:

    beq $t0, $zero, exit
    sub $t0, $t0, 1

    sb $t2, 0($t0)

exit:

    li $v0, 4
    syscall

    li $v0, 4
    la $a0, period
    syscall

    la $a0, newline
    syscall

    li $v0, 10
    syscall
