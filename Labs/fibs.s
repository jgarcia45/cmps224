#Juan Garcia
#CMPS 224 / Professor Cruz
#September 30, 2014

#Lab03: Recursive Fibonacci

  .text
  .globl main    # Start execution at main

  .ent main    # Begin the definition of main
main:

  addi  $sp, $sp, -32  # Stack frame is 32 bytes long
  sw  $ra, 20($sp)     # Save return address
  sw  $fp, 16($sp)     # Save old frame pointer
  addi  $fp, $sp, 28   # point to first word in bottom of frame

  li  $a0, 7    # Put argument (7) in $a0
  jal  fib     # Call fibonacci
  move $t0, $v0 # move result to t0

  # display stuff now
  la $a0, msg   # address of msg
  jal printf

  move $a0, $t0  # Move fact result to $a0 to display it
  li   $v0, 1    # syscall 1=print int
  syscall

  li  $a0, 10    # ascii LF char
  li  $v0, 11    # syscall 1=print char
  syscall

  lw  $ra, 20($sp)  # Restore return address
  lw  $fp, 16($sp)  # Restore frame pointer
  addi  $sp, $sp, 32  # Pop stack frame

  li  $v0, 10    # 10 is the code for exiting
  syscall      # Execute the exit

  .end main

  .rdata
msg:
  .asciiz "The 7th Fibonacci number is "

  .text      # Another segment of instructions

  .ent fib    # Begin the definition of the fibonacci
fib:

  addi $sp, $sp, -32  # Stack frame is 32 bytes long
  sw   $ra, 20($sp)   # Save return address
  sw   $fp, 16($sp)   # Save frame pointer
  addi $fp, $sp, 28   # Set up frame pointer
  sw   $a0, 0($fp)    # Save argument (n)

  lw    $v0, 0($fp)   # Load n

  move $v0, $zero     # Set return value to 0
  beq  $s0, $zero, L1        # If n = 0, branch to exit and return 0

  addi $v0, $zero, 1    # Set return value to 1
  beq  $s0, $t0, L1     # If n = 1, branch to exit and return 1

  jal L2            # Jump to code to return

L2:
  lw    $v1, 0($fp)   # Load n
  addi  $v0, $v1, -1  # Compute n - 1
  move  $a0, $v0      # Move value to $a0
  jal   fib           # recursive call to fib

  sw $v0, 4($sp)      # store the result of jal fib

  lw  $v1, 0($fp)     # Load n
  addi $v0, $v1, -2   # Compute n - 2
  move $a1, $v1
  jal   fib

  sw $v1, 4($sp)

  lw $v0, 4($sp)
  lw $v1, 4($sp)

  addu $v0, $v0, $v1  # (n-1) + (n-2)

L1:
  lw   $ra, 20($sp)    # Restore $ra
  lw   $fp, 16($sp)    # Restore frame pointer
  addi $sp, $sp, 32    # Pop stack frame
  jr   $ra             # Return to caller

  .end fib
