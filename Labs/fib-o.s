#Juan Garcia
#CMPS 224 / Professor Cruz
#October 14, 2014

#Lab 5: Code Optimization

.text
     .globl main
     .ent main                 # entry point of main
main:
  # check if a command line argument was passed
  move  $s0, $a0
  move  $s1, $a1          # s1 holds base address of cmdline arg array
  li    $t0, 1
  ble   $a0, $t0, noarg

  # we have an argument so check for validity
  lw    $a0, 4($s1)          # load address to argument into $a0
  lbu   $t0, 0($a0)          # load first byte in string into $t0
  bgt   $t0, 57, exit_on_error  # exit if arg is > 9
  blt   $t0, 48, exit_on_error  # exit if arg is < 0

  jal   atoi              # convert the arg to an int
  move  $a0, $v0          # arg is now in $a0
  b     aok

noarg:
  li    $a0, 8             # force-feed arg into $a0 if we made it here

aok:
  li    $v0, 1            # syscall print_int
  syscall                 # print the argument
  jal   fib               # call fibonacci function - result is in $v0
  move  $t0, $v0          # save fib result in $t0

  la    $a0, LC          # load output string in $a0
  li    $v0, 4            # syscall print_string
  syscall

  move  $a0, $t0          # move fib result back to $a0
  li    $v0, 1            # syscall print_int
  syscall

  la    $a0, newline      # load output string in $a0
  li    $v0, 4            # syscall print_string
  syscall

  li    $v0, 10           # 10 is the exit syscall
  syscall                 # do syscall

exit_on_error:
  la    $a0, errmsg       # load output string in $a0
  li    $v0, 4            # syscall print_string
  syscall
  li    $v0, 10           # 10 is the exit syscall
  syscall                 # do syscall

.end main


.rdata
LC:
  .asciiz " Fibonacci number is "
errmsg:
  .asciiz "Invalid argument passed.\n"
newline:
  .asciiz  "\n"

.text                  # create another text segment

.ent fib               # entry point for the fib function
fib1:
    li $t6, 1
    bgt $a0, $t6, nonleaf
    move $v0, $a0
    jr $ra
nonleaf:
    subu $sp, $sp, 32

fib:
     subu  $sp, $sp, 32             # minimum frame size is 32
     sw    $ra, 28($sp)             # preserve return address
     sw    $s0, 20($sp)             # preserve $s0
     sw    $s1, 16($sp)             # preserve $s1
     sw    $s2, 12($sp)             # preserve $s2

     move  $s0, $a0                 # grab n from caller

     blt   $s0, 2, fib_base_case    # if n < 2 we hit a stopping condition

     sub   $a0, $s0, 1              # call fib (n - 1)
     jal   fib
     move  $s1, $v0                 # hold return value of fib(n-1) in s1

     sub   $a0, $s0, 2              # call fib (n - 2)
     jal   fib
     move  $s2, $v0                 # hold return value of fib(n-2) in s2

     add   $v0, $s1, $s2            # $v0 = fib(n-1) + fib(n-2)
     b     fib_return

fib_base_case:
     move  $v0, $s0                   # return 1 if n = 1; return 0 if n = 0

fib_return:
     lw    $ra, 28($sp)
     lw    $s0, 20($sp)
     lw    $s1, 16($sp)
     lw    $s2, 12($sp)
     addu  $sp, $sp, 32
     jr    $ra

#  atoi function
atoi:
    move $v0, $zero
    # detect sign
    li $t0, 1
    lbu $t1, 0($a0)
    bne $t1, 45, digit
    li $t0, -1
    addu $a0, $a0, 1

digit:
    # read character
    lbu $t1, 0($a0)

    # finish when non-digit encountered
    bltu $t1, 48, finish
    bgtu $t1, 57, finish

    # translate character into digit
    subu $t1, $t1, 48

    # multiply the accumulator by ten
    li $t2, 10
    mult $v0, $t2
    mflo $v0

    # add digit to the accumulator
    add $v0, $v0, $t1

    # next character
    addu $a0, $a0, 1
    b digit

finish:
    mult $v0, $t0
    mflo $v0
    jr $ra
# end of atoi
