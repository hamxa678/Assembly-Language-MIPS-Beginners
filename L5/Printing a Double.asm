.data
    myDouble: .double 23.3201   # Defining double in RAM having a value 23.3201
    zeroDouble: .double 0.0     # Defining double in RAM having a value 0.0
    
.text
    # Printing a double value on the screen
    ldc1 $f2, myDouble          
    ldc1 $f0, zeroDouble
    
    li $v0, 3                   #Storing instant value 3 in $v0 means that computer is going to print a double.
    add.d $f12,$f2, $f0         #adding a decimal numbers stored in $f2 and $f0 using add.d, and storing the resultant value in $f12 mean we are telling the computer that the double value you were about to print is in $f12.
    syscall
    
    Printing a Double
    Assembly Language code for Printing a Double.
