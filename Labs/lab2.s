# Juan Garcia
# CMPS 224 / Professor Cruz
# September 23, 2014

# filename: main.s
# purpose:  test output facilities in print.s and input facilities in read.s

#  spim> re "main.s"
#  spim> re "printf.s"
#  spim> re "read.s"
#  spim> run
#  spim> exit

.text
.globl  read
.ent  main

main:

  # prompt user for last name
  la $a0,format1
  jal printf

  la $a0, lname_buf
  li $v0, 8
  syscall
  li $v0, 4
  syscall

  # prompt user for first name
  la $a0,format2
  jal printf

  la $a0, fname_buf
  li $v0, 8
  syscall
  li $v0, 4
  syscall

  # prompt user for 3-digit ID
  la $a0,format3
  jal printf

  li $v0, 5
  syscall
  move $a0, $v0
  li $v0, 1
  syscall

  li $v0,10       # 10 is exit system call
  syscall

.end  main

.data

fname_buf: .space 32
lname_buf: .space 32

format1:
  .asciiz "Enter you last name: "        # asciiz adds trailing null byte to string
format2:
  .asciiz "Enter you first name: "
format3:
  .asciiz "Enter a 3-digit ID: "
