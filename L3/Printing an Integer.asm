.data
    myInt: .word 23  # Defining word or integer in RAM having a value 23
    
.text
    # Printing an integer on the screen
    li $v0, 1               #Storing instant value 1 in $v0 means that computer is going to print a integer.   
    lw $a0, myInt           #Storing value of myCharacter in $a0, means that the string/char value computer is about to print is myCharacter value
    syscall
    
    Printing an Integer
    Assembly Language code for printing an integer
