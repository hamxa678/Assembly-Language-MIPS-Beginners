.data
    myFloat: .float 23.32  # Defining float in RAM having a value 23
    
.text
    # Printing a float value on the screen
    li $v0, 2
    lwc1 $f12, myFloat
    syscall