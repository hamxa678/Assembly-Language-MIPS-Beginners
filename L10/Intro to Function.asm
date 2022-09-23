.data
    message: .asciiz "Hi, my name is Hamza."  # Defining two integer values in RAM.
    
.text
    main:
    	jal displayMessage
    	
    #Telling the assembler that the program is done.
    li $v0, 10
    syscall
    
    displayMessage:
    	li $v0, 4
    	la $a0, message
    	syscall
    	
    	jr $ra