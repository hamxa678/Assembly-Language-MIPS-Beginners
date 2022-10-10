.data
    num1: .word 7000  # Defining two integer values in RAM. num1=7000
    num2: .word 30    # num2 = 30
    
.text
    # multiplying two integer values and then Printing the resulltant integer value on the screen.
    lw $t0, num1($zero)		# $t0 = num1 = 7000.......loading word/integer 7000 in temprary variable in $t0.
    lw $t1, num2($zero)		# $t1 = num2 = 30.......loading word/integer 30 in temprary variable in $t1.
  
    mult $t0, $t1		# $t2 = $t0 * $t1	i.e. $t2 = 7000*30 = 210000
    mflo $t2            #mflo stand for move from lo, it is reposible for moving the resultant value stored in lo register to the temp register $t2

    # Printing the resultant value
    li $v0, 1               #explained in previous lecture/coding
    add $a0, $zero, $t2		# you can also use "move $a0, $t2" instead of "add $a0, $zero, $t2"
    syscall
