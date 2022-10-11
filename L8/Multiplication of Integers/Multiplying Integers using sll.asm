# sll stand for Shift Left Logic, it is used to shift all toward left side.
# i.e. 
# 100100 = 36
# Now lets shift all bits toward left by one bit.
# 1001000 = 36 * 2^(number bits shifted) = 36 * 2^(1) = 36 * 2 = 72
# is such way we will use sll to multiply a number by 2^(n) factor where n is the no of bit shifted
# if you want to multiply a number by 2 just shift all bits toward left by one bit only.
# if you want to multiply a number by 4 just shift all bits toward left by two bit only i.e. 2^(2)= 4. 

.data
    num1: .word 7  # Defining two integer values in RAM.
    
.text
    # multiplying integer value and then Printing the resulltant integer value on the screen.
    lw $t0, num1($zero)		# $t0 = num1 = 7
  
    sll $t1,$t0, 2   		# this means we are shifting bits toward left by 2 bit, so we are goin to multiply 7 stored in $t0 by 2^(2) i.e. 7*4 = 28 and store the resultant value in $t1

    # Printing the resultant value
    li $v0, 1
    add $a0, $zero, $t1		# you can also use "move $a0, $t1" instead of "add $a0, $zero, $t1"
    syscall
    
    Multiplying Integers using sll.
    Assembly language code for Multiplying Integers using sll.
