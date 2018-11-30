#Juan Garcia
#CMPS 224 / Professor Cruz
#October 7, 2014

#Lab 4: Arrays, Loops, 2-way Branching
#Part 2: Doubly-Nested Loops

.data

doors:
    .space 10

display_x:
    .asciiz "x"
newline:
    .asciiz "\n"

.text
.globl  close_doors
.globl  main
.ent main

main:
    li $t1, 7
    la $t2, doors
    jal close_doors

    li $t4, 1
    li $t0, 1

outer_loop:
    move $t1, $t0
    la $t2, doors
    add $t2, $t2, $t0
    addi $t2, $t2, -1

inner_loop:
    lb $t3, ($t2)

sign_extend:
    sub $t3, $t4, $t3
    sb $t3, ($t2)
    add $t1, $t1, $t0

    add $t2, $t2, $t0
    ble $t1, 1, inner_loop

    addi $t0, $t0, 1
    ble $t1, 0, outer_loop

    la $t0, doors
    li $t1, 1

display_loop:
    li $v0, 4
    la $a0, display_x
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1
    addi $t1, $t1, 1
    bne $t1, 7, display_loop

    li $v0, 10
    syscall
.end main

.ent close_doors

close_doors:
    sb $0, ($t2)
    add $t2, $t2, 1
    sub $t1, $t1, 1
    bnez $t1, close_doors
    jr $ra
.end close_doors
