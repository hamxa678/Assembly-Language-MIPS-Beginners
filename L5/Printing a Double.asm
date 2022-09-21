.data
    myDouble: .double 23.3201  # Defining double in RAM having a value 23.3201
    zeroDouble: .double 0.0
    
.text
    # Printing a double value on the screen
    ldc1 $f2, myDouble
    ldc1 $f0, zeroDouble
    
    li $v0, 3
    add.d $f12,$f2, $f0
    syscall