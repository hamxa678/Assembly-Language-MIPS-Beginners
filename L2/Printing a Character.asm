.data
    myCharacter: .byte 'H'  # Defining char in RAM having a value 'H'
    
.text
    # Printing a char value on the screen
    li $v0, 4                   #Storing instant value 4 in $v0 means that computer is going to print a string
    la $a0, myCharacter
    syscall
    Printing a Character
    Assembly Language code for printing a Character
