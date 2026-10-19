# L13 - Strings: length, reverse in place, palindrome test
        .data
buf:     .space 64
prompt:  .asciiz "Enter a word: "
m_len:   .asciiz "Length   : "
m_rev:   .asciiz "Reversed : "
m_yes:   .asciiz "Palindrome: yes\n"
m_no:    .asciiz "Palindrome: no\n"
nl:      .asciiz "\n"

        .text
        .globl main
main:
        li   $v0, 4
        la   $a0, prompt
        syscall
        li   $v0, 8              # read_string
        la   $a0, buf
        li   $a1, 64
        syscall

        la   $a0, buf
        jal  strip_newline       # remove trailing '\n'

        la   $a0, buf
        jal  strlen
        move $s0, $v0            # s0 = length

        li   $v0, 4
        la   $a0, m_len
        syscall
        li   $v0, 1
        move $a0, $s0
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        # palindrome test BEFORE reversing
        la   $a0, buf
        move $a1, $s0
        jal  is_palindrome
        move $s1, $v0

        la   $a0, buf
        move $a1, $s0
        jal  reverse
        li   $v0, 4
        la   $a0, m_rev
        syscall
        li   $v0, 4
        la   $a0, buf
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall

        li   $v0, 4
        beqz $s1, say_no
        la   $a0, m_yes
        j    say
say_no: la   $a0, m_no
say:    syscall
        li   $v0, 10
        syscall

# strlen(a0=str) -> v0 = length
strlen:
        li   $v0, 0
sl_loop:
        add  $t0, $a0, $v0
        lb   $t1, 0($t0)
        beqz $t1, sl_done
        addi $v0, $v0, 1
        j    sl_loop
sl_done:
        jr   $ra

# strip_newline(a0=str): replaces first '\n' with '\0'
strip_newline:
sn_loop:
        lb   $t0, 0($a0)
        beqz $t0, sn_done
        li   $t1, 10
        beq  $t0, $t1, sn_cut
        addi $a0, $a0, 1
        j    sn_loop
sn_cut: sb   $zero, 0($a0)
sn_done:
        jr   $ra

# reverse(a0=str, a1=len): in place
reverse:
        li   $t0, 0              # left index
        addi $t1, $a1, -1        # right index
rv_loop:
        bge  $t0, $t1, rv_done
        add  $t2, $a0, $t0
        add  $t3, $a0, $t1
        lb   $t4, 0($t2)
        lb   $t5, 0($t3)
        sb   $t5, 0($t2)
        sb   $t4, 0($t3)
        addi $t0, $t0, 1
        addi $t1, $t1, -1
        j    rv_loop
rv_done:
        jr   $ra

# is_palindrome(a0=str, a1=len) -> v0 = 1/0
is_palindrome:
        li   $t0, 0
        addi $t1, $a1, -1
ip_loop:
        bge  $t0, $t1, ip_yes
        add  $t2, $a0, $t0
        add  $t3, $a0, $t1
        lb   $t4, 0($t2)
        lb   $t5, 0($t3)
        bne  $t4, $t5, ip_no
        addi $t0, $t0, 1
        addi $t1, $t1, -1
        j    ip_loop
ip_yes: li   $v0, 1
        jr   $ra
ip_no:  li   $v0, 0
        jr   $ra
