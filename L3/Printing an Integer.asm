.data
    myInt: .word 23  # Defining word or integer in RAM having a value 23
    
.text
    # Printing an integer on the screen
    li $v0, 1
    lw $a0, myInt
    syscall