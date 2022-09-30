.data
    myFloat: .float 23.32  # Defining float in RAM having a value 23
    
.text
    # Printing a float value on the screen
    li $v0, 2               #Storing instant value 2 in $v0 means that computer is going to print a float.
    lwc1 $f12, myFloat      #Storing value of myFloat in $f12 of co processor, means that the float value that computer is about to print is myFloat value
    syscall
    
    Printing a Float
    Assembly Language code for printing a Float.
