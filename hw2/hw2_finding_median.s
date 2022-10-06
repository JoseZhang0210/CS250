.globl __start
.rodata
  msg1:.string"Input the number of test case: "
  msg2:.string"Input the number of integers in a test case: "
  msg3:.string"Start to read data from the keyboard:\n"
  msg4:.string"Start sorting:\n"
  msg5:.string"The sorted list is:\n"
  msg6:.string"The median(s) is(are)"
  msg7:.string" "
.data
  ary:.zero 4000
    
.text
__start:
la t3,ary###load address t3 <- arr
###prints msg1
li a0, 4
la a1, msg1
ecall
li a0, 5###input [the number of test case] to a0
ecall
mv s2, a0###s2 = the number of test case

med:###handle each case
beq s2,zero,finish#loop [the number of test case] times
###prints msg2
li a0, 4
la a1, msg2
ecall
li a0, 5###input [the number of integers in a test case] to a0 
ecall
mv s3, a0###s3 = the number of integers in a test case
###prints msg3
li a0, 4
la a1, msg3
ecall
###save input number to ary(t3)
li t0,0
Loop:###loop [the number of integers in a test case] times
beq t0,s3,Exit
li a0, 5###read data from the keyboard 
ecall
mv t2, a0###put the data in t2
slli t1,t0,2###shift left logical then put it in t1
add t1,t1,t3
sw t2,0(t1)

addi t0,t0,1
beq zero,zero,Loop
Exit:###starts bubblesort
li t0,0
li t1,0

li t5,0
for1tst:###the outer for-loop
bge t5,s3,Seeodd
mv t6,t5
addi t6,t6,1

for2tst:###the inner for-loop
bge t6,s3,exit3

slli t1,t5,2
add t1,t1,t3
lw s7,0(t1)
slli s9,t6,2
add s9,s9,t3
lw s10,0(s9)

bge s10,s7,ex###swap function
sw s10,0(t1)
sw s7,0(s9)

ex:
addi t6,t6,1
j for2tst
exit3:
addi t5,t5,1
j for1tst

Seeodd:###check the data is odd or even then store the result in t6
li t5,2
div t4,s3,t5
mul t4,t4,t5
beq t4,s3,IsEven
li t6,1
j Findmed
IsEven:
li t6,2
j Findmed

Findmed:###according to t6, process output
beq t6,t5,CoutEven
div s5,s3,t5###output median(odd data)
li a0, 4
la a1, msg6
ecall
li a0, 4
la a1, msg7
ecall
slli s6,s5,2
add s6,s6,t3
lw s7,0(s6)
li a0, 1
mv a1, s7
ecall
j Continue

CoutEven:###output medians(even data)
div s5,s3,t5
li a0, 4
la a1, msg6
ecall
li a0, 4
la a1, msg7
ecall
li s8,0
addi s8,s5,-1

slli s6,s5,2
add s6,s6,t3
lw s7,0(s6)
slli s9,s8,2
add s9,s9,t3
lw s10,0(s9)

li a0, 1
mv a1, s10
ecall

li a0, 4
la a1, msg7
ecall

li a0, 1
mv a1, s7
ecall
j Continue
Continue:###handle next case
addi s2,s2,-1
li a0, 11
li a1, '\n'
ecall
j med

finish:
li a0,10
ecall
