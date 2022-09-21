.data
    num1: .word 7  # Defining two integer values in RAM.
    num2: .word 3
    
.text
    # Adding two integer values and then Printing the resulltant integer value on the screen.
    lw $t0, num1($zero)		# $t0 = num1 = 7
    lw $t1, num2($zero)		# $t1 = num2 = 3
  
    add $t2, $t0, $t1		# $t2 = $t0 + $t1	i.e. $t2 = 7+3 = 10
    
    # Printing the resultant value
    li $v0, 1
    add $a0, $zero, $t2
    syscall