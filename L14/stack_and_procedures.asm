# L14 - Procedures and the stack
# sum_of_squares(a, b) calls square() twice. Because it makes a call, it must
# save $ra on the stack (jal overwrites it). It also uses $s0/$s1 to keep values
# alive across a call, so it saves/restores them too.
        .data
msg:    .asciiz "3^2 + 4^2 = "
nl:     .asciiz "\n"

        .text
        .globl main
main:
        li   $a0, 3
        li   $a1, 4
        jal  sum_of_squares
        move $s7, $v0
        li   $v0, 4
        la   $a0, msg
        syscall
        li   $v0, 1
        move $a0, $s7
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall
        li   $v0, 10
        syscall

square:                          # leaf procedure: needs no stack frame
        mul  $v0, $a0, $a0
        jr   $ra

sum_of_squares:
        addi $sp, $sp, -12       # allocate frame
        sw   $ra, 8($sp)
        sw   $s0, 4($sp)
        sw   $s1, 0($sp)

        move $s1, $a1            # save b across the first call
        jal  square              # a0 is already a
        move $s0, $v0            # s0 = a^2
        move $a0, $s1
        jal  square              # b^2
        add  $v0, $s0, $v0

        lw   $s1, 0($sp)
        lw   $s0, 4($sp)
        lw   $ra, 8($sp)
        addi $sp, $sp, 12        # free frame
        jr   $ra
