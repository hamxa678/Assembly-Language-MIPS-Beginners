# L16 - Floating point (coprocessor 1): average of floats and circle area
        .data
vals:    .float 2.5, 3.75, 9.0, 1.25
count:   .word 4
pi:      .float 3.14159265
radius:  .float 5.0
m_avg:   .asciiz "Average = "
m_area:  .asciiz "Area of circle (r=5) = "
m_cmp:   .asciiz "Area is larger than 75\n"
limit:   .float 75.0
nl:      .asciiz "\n"

        .text
        .globl main
main:
        la    $t0, vals
        lw    $t1, count
        li    $t2, 0
        mtc1  $zero, $f2          # f2 = 0.0 (running sum)
avg_loop:
        beq   $t2, $t1, avg_done
        lwc1  $f4, 0($t0)
        add.s $f2, $f2, $f4
        addi  $t0, $t0, 4
        addi  $t2, $t2, 1
        j     avg_loop
avg_done:
        mtc1  $t1, $f6
        cvt.s.w $f6, $f6          # convert int count -> float
        div.s $f12, $f2, $f6      # f12 is the print_float argument register
        li    $v0, 4
        la    $a0, m_avg
        syscall
        li    $v0, 2              # print_float
        syscall
        li    $v0, 4
        la    $a0, nl
        syscall

        l.s   $f0, pi
        l.s   $f2, radius
        mul.s $f4, $f2, $f2
        mul.s $f12, $f4, $f0      # area = pi * r * r
        li    $v0, 4
        la    $a0, m_area
        syscall
        li    $v0, 2
        syscall
        li    $v0, 4
        la    $a0, nl
        syscall

        l.s   $f6, limit
        c.lt.s $f6, $f12          # sets the coprocessor-1 condition flag
        bc1f  done                # branch if flag is false
        li    $v0, 4
        la    $a0, m_cmp
        syscall
done:
        li    $v0, 10
        syscall
