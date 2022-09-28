.data
    myCharacter: .byte 'H'  # Defining char in RAM having a value 'H'
    
.text
    # Printing a char value on the screen
    li $v0, 4
    la $a0, myCharacter
    syscall
    Printing a Character
    Assembly Language code for printing a Character
