.data
    myDouble: .double 23.3201   # Defining double in RAM having a value 23.3201
    zeroDouble: .double 0.0     # Defining double in RAM having a value 0.0
    
.text
    # Printing a double value on the screen
    ldc1 $f2, myDouble          #Storing value of myDouble in $f2 of co processor which is 12.3201.    
    ldc1 $f0, zeroDouble        #Storing value of myDouble in $f0 of co processor which is 0.0.
    
    li $v0, 3                   #Storing instant value 3 in $v0 means that computer is going to print a double.
    add.d $f12,$f2, $f0         #adding a decimal numbers stored in $f2 and $f0 using add.d, and storing the resultant value in $f12 mean we are telling the computer that the double value you were about to print is in $f12.
    syscall                     #System call tell the assembler to perform the above required task. i.e. printing an double
