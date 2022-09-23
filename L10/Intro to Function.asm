.data
    message: .asciiz "Hi, my name is Hamza."  # Defining two String message "Hi, my name is Hamza." in RAM.
    
.text
    main:
    	jal displayMessage                    # Transfering Control to line number where the funtion is define .i.e. here line no will be 12
    
    
    #Telling the assembler that the program is done.
    li $v0, 10
    syscall
    
    displayMessage:                           # Function Defination
    
        #printing a message
    	li $v0, 4
    	la $a0, message
    	syscall
    	
        # $ra register contain the address of the line exactly after the line from where the funtion is being called.
        # jr $ra will jump return to the line after the line from where the function is being called. i.e. line no 7
    	jr $ra
        Intro to Function
        Assembly Language code for Function printing String message.
