.data
    myMessage: .asciiz "Hello World! \n"  # Defining a string in RAM
    
.text
    # Printing a string on the screen
    li $v0, 4
    la $a0, myMessage
    syscall
