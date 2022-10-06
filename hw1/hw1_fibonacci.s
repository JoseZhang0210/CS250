.globl __start

.rodata
  msg1: .string "Please enter a number: "
  msg2: .string "The "
  msg3: .string " fibonnaci number is: "
  ###add three string msg
  msg4: .string "Number of instructions being executed: "
  msg5: .string "The average number of instrusctions executed per fibonacci number: "##
  msg6: .string "\nThe slope of fibonacci number between the given two integers: "##

.text

__start:
  li t0, 0
  li t1, 1
  # prints msg1
  li a0, 4
  la a1, msg1
  ecall
  # reads an int and moves it to register t3
  li a0, 5
  ecall
  mv t3, a0
  mv t6, t3 ###store t6 <- t3
  # prints a newline
  li a0, 11
  li a1, '\n'
  ecall
  # prints msg2
  li a0, 4
  la a1, msg2
  ecall
  # prints the int value in t3
  li a0, 1
  mv a1, t3
  ecall
  # fibonnaci program
fib:
  beq t3, zero, finish
  add t2, t1, t0
  mv t0, t1
  mv t1, t2
  addi t3, t3, -1
  j fib
finish:
  # prints msg3
  li a0, 4
  la a1, msg3
  ecall
  # prints the result in t0
  li a0, 1
  mv a1, t0
  ecall
  jal ra, newline ###jump newline
  li t1, 6 ###t1=6
  mul t5, t6, t1 ###t5=t6*6
  addi t5, t5, 26 ###instructions=t5+26
  ### prints msg4
  li a0, 4
  la a1, msg4
  ecall
  ### prints the result in t5
  li a0, 1
  mv a1, t5
  ecall
  jal ra, newline ###get a newline
  beq s6, zero, storek ###first time jump to storek
  sub t6, t6, s6
  sub t5, t5, s5
  sub t0, t0, s4
  div t5, t5, t6
  div t0, t0, t6
  ### prints msg5
  li a0, 4
  la a1, msg5
  ecall
  ### prints the result in t5
  li a0, 1
  mv a1, t5
  ecall
  jal ra, newline ###get a newline
  ### prints msg6
  li a0, 4
  la a1, msg5
  ecall
  ### prints the result in t0
  li a0, 1
  mv a1, t0
  ecall
  # ends the program with status code 0
  li a0, 10
  ecall
newline:###prints a newline
  li a0, 11
  li a1, '\n'
  ecall
  jalr x0, 0(x1)###back to caller
storek:###store k=s6 <- t6, Ek=s5 <- t5, Fk=s4 <- t0 
  mv s6, t6
  mv s5, t5
  mv s4, t0
  j __start###starts second time