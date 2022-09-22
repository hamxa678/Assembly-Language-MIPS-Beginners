
.data
    num1: .word 14  # Defining two integer values in RAM.
    num2: .word 7
    
.text
    # Dividing two integer values and then Printing the resulltant integer value on the screen.
    lw $t0, num1($zero)		# $t0 = num1 = 14
    lw $t1, num2($zero)		# $t0 = num2 = 7
  
    div $t2,$t0,$t1   		# $t2 = 14 / 7 = 2
    
    # Printing the resultant value
    li $v0, 1
    add $a0, $zero, $t2		# you can also use "move $a0, $t2" instead of "add $a0, $zero, $t2"
    syscall