.data
    num1: .word 7  # 
    num2: .word 3
    
.text
    # multiplying two integer values and then Printing the resulltant integer value on the screen.
    lw $t0, num1($zero)		# $t0 = num1 = 7
    lw $t1, num2($zero)		# $t1 = num2 = 3
  
    mul $t2, $t0, $t1		# $t2 = $t0 * $t1	i.e. $t2 = 7*3 = 21
    
    # Printing the resultant value
    li $v0, 1
    add $a0, $zero, $t2		# you can also use "move $a0, $t2" instead of "add $a0, $zero, $t2"
    syscall
    #Multiplying Integers using mul
    #Assembly Language code for multiplying Integers using mul.
