# L18 - Dynamic memory (sbrk) and a linked list
# A node is 8 bytes:  [0] value (word)   [4] next pointer (word, 0 = null)
# We push nodes at the head, so the list prints in reverse insertion order.
        .data
m_list:  .asciiz "List: "
arrow:   .asciiz " -> "
m_null:  .asciiz "null\n"
m_sum:   .asciiz "Sum of list: "
nl:      .asciiz "\n"

        .text
        .globl main
main:
        li   $s0, 0              # s0 = head (null)
        li   $s1, 1              # s1 = next value to insert
build:
        bgt  $s1, 5, built
        move $a0, $s0
        move $a1, $s1
        jal  push_front
        move $s0, $v0            # new head
        addi $s1, $s1, 1
        j    build
built:
        li   $v0, 4
        la   $a0, m_list
        syscall
        move $a0, $s0
        jal  print_list

        li   $v0, 4
        la   $a0, m_sum
        syscall
        move $a0, $s0
        jal  sum_list
        move $a0, $v0
        li   $v0, 1
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall
        li   $v0, 10
        syscall

# push_front(a0=head, a1=value) -> v0 = new head
push_front:
        move $t0, $a0
        li   $v0, 9              # sbrk: allocate bytes on the heap
        li   $a0, 8
        syscall                  # v0 = address of new node
        sw   $a1, 0($v0)
        sw   $t0, 4($v0)
        jr   $ra

print_list:
        move $t0, $a0
pl_loop:
        beqz $t0, pl_end
        li   $v0, 1
        lw   $a0, 0($t0)
        syscall
        li   $v0, 4
        la   $a0, arrow
        syscall
        lw   $t0, 4($t0)
        j    pl_loop
pl_end:
        li   $v0, 4
        la   $a0, m_null
        syscall
        jr   $ra

sum_list:
        li   $v0, 0
sm_loop:
        beqz $a0, sm_end
        lw   $t1, 0($a0)
        add  $v0, $v0, $t1
        lw   $a0, 4($a0)
        j    sm_loop
sm_end:
        jr   $ra
