.data
    message: .asciiz "Hi, my name is Hamza."  # Defining two String message "Hi, my name is Hamza." in RAM.
    
.text
    main:
    	jal displayMessage                    # Transfering Control to line number where the funtion is define .i.e. here line no will be 12
    	
    #Telling the assembler that the program is done.
    li $v0, 10
    syscall
    
    displayMessage:                           
    	li $v0, 4
    	la $a0, message
    	syscall
    	
    	jr $ra
        Intro to Function
        Assembly Language code for Function printing String message.
