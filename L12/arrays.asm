# L12 - Arrays: sum, maximum, and bubble sort
        .data
arr:    .word 42, 7, 19, 3, 88, 25, 61, 14
n:      .word 8
msg_sum:  .asciiz "Sum     = "
msg_max:  .asciiz "Maximum = "
msg_sort: .asciiz "Sorted  : "
space:    .asciiz " "
nl:       .asciiz "\n"

        .text
        .globl main
main:
        # ---- sum and max in a single pass ----
        la   $t0, arr            # t0 = pointer to current element
        lw   $t1, n              # t1 = number of elements
        li   $t2, 0              # t2 = sum
        lw   $t3, 0($t0)         # t3 = max (start with first element)
        li   $t4, 0              # t4 = i
sum_loop:
        beq  $t4, $t1, sum_done
        lw   $t5, 0($t0)         # t5 = arr[i]
        add  $t2, $t2, $t5
        ble  $t5, $t3, not_bigger
        move $t3, $t5
not_bigger:
        addi $t0, $t0, 4         # next word = +4 bytes
        addi $t4, $t4, 1
        j    sum_loop
sum_done:
        li   $v0, 4
        la   $a0, msg_sum
        syscall
        li   $v0, 1
        move $a0, $t2
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall
        li   $v0, 4
        la   $a0, msg_max
        syscall
        li   $v0, 1
        move $a0, $t3
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        # ---- bubble sort ----
        lw   $s0, n
        addi $s1, $s0, -1        # s1 = n-1 (number of passes)
outer:
        blez $s1, sorted
        la   $t0, arr
        li   $t1, 0              # j = 0
inner:
        beq  $t1, $s1, inner_done
        lw   $t2, 0($t0)         # arr[j]
        lw   $t3, 4($t0)         # arr[j+1]
        ble  $t2, $t3, no_swap
        sw   $t3, 0($t0)         # swap
        sw   $t2, 4($t0)
no_swap:
        addi $t0, $t0, 4
        addi $t1, $t1, 1
        j    inner
inner_done:
        addi $s1, $s1, -1
        j    outer
sorted:
        li   $v0, 4
        la   $a0, msg_sort
        syscall
        la   $t0, arr
        lw   $t1, n
        li   $t4, 0
print_loop:
        beq  $t4, $t1, end
        li   $v0, 1
        lw   $a0, 0($t0)
        syscall
        li   $v0, 4
        la   $a0, space
        syscall
        addi $t0, $t0, 4
        addi $t4, $t4, 1
        j    print_loop
end:
        li   $v0, 4
        la   $a0, nl
        syscall
        li   $v0, 10
        syscall
