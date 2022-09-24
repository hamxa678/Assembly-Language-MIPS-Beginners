
.data
    # No defination in RAM.
    
.text
    #the main funtion from where the exact execution of program starts.
    main:
        
        #Argument being passed to fuction must be stored in $a1, $a2 and $a3 register
        addi $a1, $zero, 50		    #Adding immediate value 50 and 0 in $zero and storing the resulant in register $a1.
        addi $a2, $zero, 100		# ---------------------100----------same---------------------------------------$a2.
    
    jal addNumber                	# Transfering Control to line number where the funtion is define .i.e. here line no will be 12
      
    #Telling the assembler that the program is done. it is important coz the assembler will continue the execution of code coming ahead, i.e. it will run the fuction again and again.
    li $v0, 10
    syscall
    
    addNumber:                    	# Function Defination
    
    	add $v1, $a1, $a2		# adding number stored in $a1 and $a2 and storing the resultant value $v0
    
        #printing a resultant value
    	li $v0, 1
    	addi $a0, $v1, 0
    	syscall
    	
        # $ra register contain the address of the line exactly after the line from where the funtion is being called.
        # jr $ra will jump return to the line after the line from where the function is being called. i.e. line no 14
    	jr $ra
    	
#Function Arguments and Return Values
