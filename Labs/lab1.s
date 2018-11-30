# Juan Garcia
# CMPS 224 / Albert Cruz
# Lab 1 "sum.s"
# September 16, 2014

     .data                    # data segments begins here

str1:   .asciiz "The sum of "

str2:   .asciiz " and "

str3:   .asciiz " is "

     .text                     # code segment begins here

main:
     la $a0, str1
     li $v0, 4                # 4 is syscall to print a string
     syscall

     li $t0, 6
     move $a0, $t0
     li $v0, 1
     syscall

     la $a0, str2
     li $v0, 4                # 4 is syscall to print a string
     syscall

     li $t1, 5
     move $a0, $t1
     li $v0, 1
     syscall

     la $a0, str3
     li $v0, 4                # 4 is syscall to print a string
     syscall

     addu $t2, $t0, $t1       # add values in src1 and src2 registers
     move $a0, $t2
     li $v0, 1
     syscall

     li $v0, 10                # 10 is system call to exit
     syscall                  # execute the call
