#100.s
#Juan Garcia
#cs224 Final Project - Fall 2014
#This code displays the nth row of pascal's triangle
#usage: spim -f 100.s n k

#Week 10, 100% - write a recursive function to compute C(n,k)

.data

newline: .asciiz "\n"
usage_stmt: .asciiz "\nUsage: spim -f 100.s <int> <int>\n"
onespace: .asciiz " "
errmsg: .asciiz "Invalid argument passed.\n"

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

    #check if a command line argument was passed
    li $t0, 1
    ble $a0, $t0, noarg

    #check if less than three arguments are given
    li $t0, 3
    blt $a0, $t0, noarg

    #we have an argument so check for validity
    lw $a0, 4($s1)
    lbu $t0, 0($a0)
    bgt $t0, 57, exit_on_error
    blt $t0, 48, exit_on_error

    #we have an argument so check for validity
    lw $a1, 8($s1)
    lbu $t1, 0($a1)
    bgt $t1, 57, exit_on_error
    blt $t1, 48, exit_on_error

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

noarg:

    li $t0, 6       #force-feed arg into $t0 if we made it here
    li $t1, 4       #force-feed arg into $t1 if we made it here

    j Exit

swap_n_and_k:

    slt $t3, $t0, $t1       #t1 = (i < size) ? 1 : 0;
    beq $t3, $zero, Exit    #Exit if i >= size
    move $t5, $t0
    move $t0, $t1
    move $t1, $t5

    jal Exit

.ent factorial      #Begin the definition of the fact function
factorial:

    li $v0, 1
    j factorial_loop

factorial_loop:

    beqz $a0, exit_factorial_loop
    mul $v0, $v0, $a0
    addi $a0, $a0, -1
    j factorial_loop

exit_factorial_loop:

    jr $ra

.end factorial

.ent Cnk            #Begin the definition of the Cnk funcion
Cnk:

    addi $sp, $sp, -32      #Stack frame is 32 bytes long
    sw $ra, 0($sp)          #Save return address
    sw $fp, 4($sp)          #Save frame pointer
    addi $fp, $sp, 28       #Set up frame pointer

    sw $a0, 8($sp)      #Save argument (n)
    sw $a1, 12($sp)     #Save argument (k)

    beqz $a1, Cnk1      #if k == 0, return 1
    beq $a1, $a0, Cnk1  #if k == n, return 1
    beq $a1, 1, Cnk1    #if k == 1, return n

Cnk2:

    addi $a0, $a0, -1    #(n-1)
    jal Cnk
    sw $v0, 28($sp)      #Save argument (n-1)

    lw $a1, 12($sp)      #Load k
    addi $a1, $a1, -1    #k - 1
    jal Cnk
    sw $v1, 24($sp)      #Save argument (k-1)

    lw $v0, 28($sp)      #Load (n-1)
    lw $v1, 24($sp)      #Load (k-1)
    add $v0, $v0, $v1

    lw $ra, 0($sp)
    lw $fp, 4($sp)
    addi $sp, $sp, 32

    jr $ra

Cnk1:   #Returns 1

    li $v0, 1               #Return 1

    lw $ra, 0($sp)          #Restore $ra
    lw $fp, 4($sp)          #Restore frame pointer
    addi $sp, $sp, 32       #Pop stack frame

    jr $ra      #Return to caller

Cnkn:   #Return n

    lw $ra, 0($sp)
    lw $fp, 4($sp)
    addi $sp, $sp, 32

    jr $ra

.end Cnk

.ent displayRow     #Begin the definition of the displayRow
displayRow:

    li $a1, 0       #Load k = 0
    j displayRow_loop

displayRow_loop:

    blt $a0, $a1, exit_displayRow_loop

    addi $sp, $sp, -32      #Stack frame is 32 bytes long
    sw $ra, 0($sp)          #Save return address
    sw $fp, 4($sp)          #Save frame pointer
    addi $fp, $sp, 28       #Set up frame pointer

    sw $a0, 8($sp)          #Save argument (n)
    #sw $a1, 12($sp)

    jal Cnk

    #sw $v0, 28($sp)

    move $a0, $v0
    li $v0, 1
    syscall

    la $a0, onespace
    li $v0, 4
    syscall

    lw $a0, 8($sp)
    #lw $a1, 12($sp)
    lw $ra, 0($sp)          #Restore $ra
    lw $fp, 4($sp)          #Restore frame pointer
    addi $sp, $sp, 32       #Pop stack frame

    addi $a1, $a1, 1        #Increment k
    j displayRow_loop

exit_displayRow_loop:

    jr $ra      #Return to caller

.end displayRow

.ent pascals_triangle
pascals_triangle:

    li $a2, 0
    j pascals_triangle_loop

pascals_triangle_loop:

    blt $a0, $a2, exit_pascals_triangle_loop

    addi $sp, $sp, -32
    sw $ra, 0($sp)
    sw $fp, 4($sp)
    addi $fp, $sp, 28

    sw $a0, 8($sp)

    move $a0, $a2
    jal displayRow

    la $a0, newline
    li $v0, 4
    syscall

    lw $a0, 8($sp)

    lw $ra, 0($sp)
    lw $fp, 4($sp)
    addi $sp, $sp, 32

    addi $a2, $a2, 1
    j pascals_triangle_loop

exit_pascals_triangle_loop:

    jr $ra

.end pascals_triangle

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

    j Print_Factorial

Print_Factorial:

    move $a0, $t0
    jal factorial

    move $a0, $v0
    li $v0, 1
    syscall

    la $a0, onespace
    li $v0, 4
    syscall

    move $a0, $t1
    jal factorial

    move $a0, $v0
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    j print_Cnk

print_Cnk:

    move $a0, $t0
    move $a1, $t1
    jal Cnk

    move $a0, $v0
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    j print_displayRow

print_displayRow:

    move $a0, $t0
    move $a1, $t1
    jal displayRow

    la $a0, newline
    li $v0, 4
    syscall

    j print_pascals_triangle

print_pascals_triangle:

    move $a0, $t0
    move $a2, $t1
    jal pascals_triangle

    li $v0, 10              #Exit
    syscall

exit_on_error:

    la $a0, errmsg
    li $v0, 4
    syscall

    li $v0, 10
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
