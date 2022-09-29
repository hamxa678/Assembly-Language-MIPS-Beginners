.data
    myCharacter: .byte 'H'  # Defining char in RAM having a value 'H'
    
.text
    # Printing a char value on the screen
    li $v0, 4                   #Storing instant value 4 in $v0 means that computer is going to print a string/char.
    la $a0, myCharacter         #Storing value of myCharacter in $a0, means that the string/char value that computer is about to print is myCharacter value
    syscall                     #System call tell the assembler to perform the above required task. i.e. printing a String/char
    
    
    
