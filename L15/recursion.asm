# L15 - Recursion: factorial, Fibonacci, GCD
        .data
m_fact: .asciiz "10! = "
m_fib:  .asciiz "fib(15) = "
m_gcd:  .asciiz "gcd(84, 36) = "
nl:     .asciiz "\n"

        .text
        .globl main
main:
        li   $a0, 10
        jal  factorial
        move $s0, $v0
        la   $a0, m_fact
        jal  print_str
        move $a0, $s0
        jal  print_int

        li   $a0, 15
        jal  fib
        move $s0, $v0
        la   $a0, m_fib
        jal  print_str
        move $a0, $s0
        jal  print_int

        li   $a0, 84
        li   $a1, 36
        jal  gcd
        move $s0, $v0
        la   $a0, m_gcd
        jal  print_str
        move $a0, $s0
        jal  print_int

        li   $v0, 10
        syscall

print_str:
        li   $v0, 4
        syscall
        jr   $ra
print_int:                       # prints int then newline
        li   $v0, 1
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall
        jr   $ra

# factorial(n): n <= 1 -> 1, else n * factorial(n-1)
factorial:
        addi $sp, $sp, -8
        sw   $ra, 4($sp)
        sw   $a0, 0($sp)
        li   $t0, 1
        bgt  $a0, $t0, fact_rec
        li   $v0, 1              # base case
        j    fact_ret
fact_rec:
        addi $a0, $a0, -1
        jal  factorial
        lw   $a0, 0($sp)         # restore n
        mul  $v0, $a0, $v0
fact_ret:
        lw   $ra, 4($sp)
        addi $sp, $sp, 8
        jr   $ra

# fib(n): n < 2 -> n, else fib(n-1) + fib(n-2)
fib:
        addi $sp, $sp, -12
        sw   $ra, 8($sp)
        sw   $a0, 4($sp)
        sw   $s0, 0($sp)
        li   $t0, 2
        blt  $a0, $t0, fib_base
        addi $a0, $a0, -1
        jal  fib
        move $s0, $v0            # s0 = fib(n-1)
        lw   $a0, 4($sp)
        addi $a0, $a0, -2
        jal  fib
        add  $v0, $v0, $s0
        j    fib_ret
fib_base:
        move $v0, $a0
fib_ret:
        lw   $s0, 0($sp)
        lw   $a0, 4($sp)
        lw   $ra, 8($sp)
        addi $sp, $sp, 12
        jr   $ra

# gcd(a, b): Euclid. b == 0 -> a, else gcd(b, a mod b)
gcd:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)
        beqz $a1, gcd_base
        rem  $t0, $a0, $a1
        move $a0, $a1
        move $a1, $t0
        jal  gcd
        j    gcd_ret
gcd_base:
        move $v0, $a0
gcd_ret:
        lw   $ra, 0($sp)
        addi $sp, $sp, 4
        jr   $ra
