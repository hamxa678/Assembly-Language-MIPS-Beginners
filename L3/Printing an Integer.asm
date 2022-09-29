.data
    myInt: .word 23  # Defining word or integer in RAM having a value 23
    
.text
    # Printing an integer on the screen
    li $v0, 1               #Storing instant value 1 in $v0 means that computer is going to print a integer.   
    lw $a0, myInt           #Storing value of myInt in $a0, means that the integer value that computer is about to print is myInt value
    syscall                 #System call tell the assembler to perform the above required task. i.e. printing an integer
    
    
    
