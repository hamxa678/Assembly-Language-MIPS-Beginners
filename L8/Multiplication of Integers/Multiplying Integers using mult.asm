.data
    num1: .word 7000  # Defining two integer values in RAM.
    num2: .word 30
    
.text
    # multiplying two integer values and then Printing the resulltant integer value on the screen.
    lw $t0, num1($zero)		# $t0 = num1 = 7000
    lw $t1, num2($zero)		# $t1 = num2 = 30
  
    mult $t0, $t1		# $t2 = $t0 * $t1	i.e. $t2 = 7000*30 = 210000
    mflo $t2

    # Printing the resultant value
    li $v0, 1
    add $a0, $zero, $t2		# you can also use "move $a0, $t2" instead of "add $a0, $zero, $t2"
    syscall