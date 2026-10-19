# L17 - Bit manipulation: shifts, masks, popcount, power-of-two, binary print
        .data
m_val:   .asciiz "Value        : "
m_bin:   .asciiz "Binary       : "
m_pop:   .asciiz "Set bits     : "
m_pow:   .asciiz "Power of two : "
m_yes:   .asciiz "yes\n"
m_no:    .asciiz "no\n"
m_x4:    .asciiz "x * 8 via shift: "
m_par:   .asciiz "Low bit (odd=1): "
nl:      .asciiz "\n"

        .text
        .globl main
main:
        li   $s0, 200            # try 64 for a power of two
        li   $v0, 4
        la   $a0, m_val
        syscall
        li   $v0, 1
        move $a0, $s0
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        li   $v0, 4
        la   $a0, m_bin
        syscall
        move $a0, $s0
        jal  print_binary8

        # popcount: x &= x-1 clears the lowest set bit each time
        move $t0, $s0
        li   $t1, 0
pc_loop:
        beqz $t0, pc_done
        addi $t2, $t0, -1
        and  $t0, $t0, $t2
        addi $t1, $t1, 1
        j    pc_loop
pc_done:
        li   $v0, 4
        la   $a0, m_pop
        syscall
        li   $v0, 1
        move $a0, $t1
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        # power of two <=> x != 0 and (x & (x-1)) == 0
        li   $v0, 4
        la   $a0, m_pow
        syscall
        beqz $s0, p2_no
        addi $t2, $s0, -1
        and  $t2, $s0, $t2
        bnez $t2, p2_no
        la   $a0, m_yes
        j    p2_say
p2_no:  la   $a0, m_no
p2_say: li   $v0, 4
        syscall

        # shift tricks
        li   $v0, 4
        la   $a0, m_x4
        syscall
        sll  $a0, $s0, 3         # x * 2^3
        li   $v0, 1
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        li   $v0, 4
        la   $a0, m_par
        syscall
        andi $a0, $s0, 1         # mask: keep only bit 0
        li   $v0, 1
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        li   $v0, 10
        syscall

# print_binary8(a0): prints the low 8 bits, MSB first, then newline
print_binary8:
        move $t0, $a0
        li   $t1, 7
pb_loop:
        bltz $t1, pb_done
        srlv $t2, $t0, $t1
        andi $t2, $t2, 1
        li   $v0, 1
        move $a0, $t2
        syscall
        addi $t1, $t1, -1
        j    pb_loop
pb_done:
        li   $v0, 4
        la   $a0, nl
        syscall
        jr   $ra
