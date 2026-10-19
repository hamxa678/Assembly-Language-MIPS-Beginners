# ============================================================================
#  Project: Unbeatable Tic-Tac-Toe in MIPS assembly
#  You are X and move first. The computer is O and uses recursive MINIMAX
#  to search the whole game tree, so the best you can do is draw.
#
#  Concepts used: arrays, loops, procedures, the stack, recursion, syscalls.
#  Tested with SPIM and written to run in MARS as well.
#
#  Board cells (index 0..8):   0 = empty, 1 = X (human), 2 = O (computer)
# ============================================================================
        .data
board:   .word 0,0,0,0,0,0,0,0,0
# the 8 winning lines (rows, columns, diagonals) as cell indices
lines:   .word 0,1,2,  3,4,5,  6,7,8,  0,3,6,  1,4,7,  2,5,8,  0,4,8,  2,4,6

title:   .asciiz "\n=== TIC-TAC-TOE vs MINIMAX ===\nYou are X, computer is O. Enter a cell number 1-9.\n"
sep:     .asciiz "---+---+---\n"
ask:     .asciiz "\nYour move (1-9): "
bad:     .asciiz "Invalid input, try again.\n"
taken:   .asciiz "That cell is taken, try again.\n"
cmove:   .asciiz "\nComputer plays: "
win_h:   .asciiz "\nYou win! (this should be impossible...)\n"
win_c:   .asciiz "\nComputer wins!\n"
draw:    .asciiz "\nIt's a draw!\n"
again:   .asciiz "Play again? (1 = yes, 0 = no): "
bye:     .asciiz "Thanks for playing!\n"
nl:      .asciiz "\n"

        .text
        .globl main
# ---------------------------------------------------------------- main ------
main:
        li   $v0, 4
        la   $a0, title
        syscall

new_game:
        jal  reset_board

game_loop:
        jal  print_board
        jal  human_move

        jal  check_winner
        li   $t0, 1
        beq  $v0, $t0, human_won
        jal  board_full
        bnez $v0, game_draw

        jal  computer_move

        jal  check_winner
        li   $t0, 2
        beq  $v0, $t0, computer_won
        jal  board_full
        bnez $v0, game_draw
        j    game_loop

human_won:
        jal  print_board
        la   $a0, win_h
        j    game_over
computer_won:
        jal  print_board
        la   $a0, win_c
        j    game_over
game_draw:
        jal  print_board
        la   $a0, draw
game_over:
        li   $v0, 4
        syscall
        li   $v0, 4
        la   $a0, again
        syscall
        li   $v0, 5
        syscall
        bnez $v0, new_game
        li   $v0, 4
        la   $a0, bye
        syscall
        li   $v0, 10
        syscall

# ------------------------------------------------------- reset_board -------
reset_board:
        la   $t0, board
        li   $t1, 0
rb_loop:
        li   $t2, 9
        beq  $t1, $t2, rb_done
        sw   $zero, 0($t0)
        addi $t0, $t0, 4
        addi $t1, $t1, 1
        j    rb_loop
rb_done:
        jr   $ra

# ------------------------------------------------------- print_board -------
# Prints the board; empty cells show their number so you know what to type.
print_board:
        li   $v0, 11
        li   $a0, 10
        syscall                       # blank line
        li   $t0, 0                   # t0 = cell index
pb_loop:
        li   $t1, 9
        beq  $t0, $t1, pb_done
        li   $v0, 11
        li   $a0, 32                  # ' '
        syscall
        sll  $t1, $t0, 2
        la   $t2, board
        add  $t1, $t1, $t2
        lw   $t2, 0($t1)              # t2 = board[i]
        li   $a0, 88                  # 'X'
        li   $t3, 1
        beq  $t2, $t3, pb_print
        li   $a0, 79                  # 'O'
        li   $t3, 2
        beq  $t2, $t3, pb_print
        addi $a0, $t0, 49             # empty: '1' + i
pb_print:
        li   $v0, 11
        syscall
        li   $a0, 32
        syscall
        li   $t3, 3
        rem  $t4, $t0, $t3
        li   $t3, 2
        beq  $t4, $t3, pb_eol
        li   $a0, 124                 # '|'
        syscall
        j    pb_next
pb_eol:
        li   $a0, 10
        syscall
        li   $t3, 8
        beq  $t0, $t3, pb_next        # no separator after last row
        li   $v0, 4
        la   $a0, sep
        syscall
pb_next:
        addi $t0, $t0, 1
        j    pb_loop
pb_done:
        jr   $ra

# ------------------------------------------------------ human_move ---------
human_move:
hm_ask:
        li   $v0, 4
        la   $a0, ask
        syscall
        li   $v0, 5
        syscall                       # v0 = typed integer
        blt  $v0, 1, hm_bad
        bgt  $v0, 9, hm_bad
        addi $t0, $v0, -1             # cell index 0..8
        sll  $t1, $t0, 2
        la   $t2, board
        add  $t1, $t1, $t2
        lw   $t3, 0($t1)
        bnez $t3, hm_taken
        li   $t4, 1
        sw   $t4, 0($t1)              # place X
        jr   $ra
hm_bad:
        li   $v0, 4
        la   $a0, bad
        syscall
        j    hm_ask
hm_taken:
        li   $v0, 4
        la   $a0, taken
        syscall
        j    hm_ask

# ---------------------------------------------------- check_winner ---------
# returns v0 = 0 (nobody), 1 (X has three in a row), 2 (O has three in a row)
check_winner:
        la   $t0, lines
        li   $t1, 0                   # line counter
        la   $t9, board
cw_loop:
        li   $t2, 8
        beq  $t1, $t2, cw_none
        lw   $t3, 0($t0)              # three cell indices of this line
        lw   $t4, 4($t0)
        lw   $t5, 8($t0)
        sll  $t3, $t3, 2
        add  $t3, $t3, $t9
        lw   $t3, 0($t3)              # value of cell a
        sll  $t4, $t4, 2
        add  $t4, $t4, $t9
        lw   $t4, 0($t4)              # value of cell b
        sll  $t5, $t5, 2
        add  $t5, $t5, $t9
        lw   $t5, 0($t5)              # value of cell c
        beqz $t3, cw_next             # empty -> not a winning line
        bne  $t3, $t4, cw_next
        bne  $t3, $t5, cw_next
        move $v0, $t3                 # all three equal and non-empty
        jr   $ra
cw_next:
        addi $t0, $t0, 12
        addi $t1, $t1, 1
        j    cw_loop
cw_none:
        li   $v0, 0
        jr   $ra

# ----------------------------------------------------- board_full ----------
# returns v0 = 1 if no empty cell is left, else 0
board_full:
        la   $t0, board
        li   $t1, 0
bf_loop:
        li   $t2, 9
        beq  $t1, $t2, bf_yes
        lw   $t3, 0($t0)
        beqz $t3, bf_no
        addi $t0, $t0, 4
        addi $t1, $t1, 1
        j    bf_loop
bf_yes: li   $v0, 1
        jr   $ra
bf_no:  li   $v0, 0
        jr   $ra

# ---------------------------------------------------- computer_move --------
# Tries every empty cell, scores each with minimax, plays the best one.
computer_move:
        addi $sp, $sp, -16
        sw   $ra, 12($sp)
        sw   $s0, 8($sp)              # s0 = cell being tried
        sw   $s1, 4($sp)              # s1 = best score so far
        sw   $s2, 0($sp)              # s2 = best cell so far
        li   $s0, 0
        li   $s1, -100
        li   $s2, -1
cm_loop:
        li   $t0, 9
        beq  $s0, $t0, cm_play
        sll  $t1, $s0, 2
        la   $t2, board
        add  $t1, $t1, $t2
        lw   $t3, 0($t1)
        bnez $t3, cm_next
        li   $t4, 2
        sw   $t4, 0($t1)              # try O here
        li   $a0, 1                   # next to move: X
        li   $a1, 1                   # depth
        jal  minimax
        sll  $t1, $s0, 2              # recompute address (jal clobbered temps)
        la   $t2, board
        add  $t1, $t1, $t2
        sw   $zero, 0($t1)            # undo
        ble  $v0, $s1, cm_next
        move $s1, $v0                 # new best
        move $s2, $s0
cm_next:
        addi $s0, $s0, 1
        j    cm_loop
cm_play:
        sll  $t1, $s2, 2
        la   $t2, board
        add  $t1, $t1, $t2
        li   $t4, 2
        sw   $t4, 0($t1)              # make the chosen move
        li   $v0, 4
        la   $a0, cmove
        syscall
        li   $v0, 1
        addi $a0, $s2, 1
        syscall
        li   $v0, 4
        la   $a0, nl
        syscall
        lw   $s2, 0($sp)
        lw   $s1, 4($sp)
        lw   $s0, 8($sp)
        lw   $ra, 12($sp)
        addi $sp, $sp, 16
        jr   $ra

# -------------------------------------------------------- minimax ----------
# minimax(a0 = player to move (1=X, 2=O), a1 = depth) -> v0 = score for O
#   O wins:  10 - depth   (faster wins score higher)
#   X wins:  depth - 10   (slower losses score higher)
#   draw:    0
# O picks the move with the MAXIMUM score, X (assumed perfect) the MINIMUM.
minimax:
        addi $sp, $sp, -20
        sw   $ra, 16($sp)
        sw   $s0, 12($sp)             # s0 = cell index
        sw   $s1, 8($sp)              # s1 = best score at this node
        sw   $s2, 4($sp)              # s2 = player to move
        sw   $s3, 0($sp)              # s3 = depth
        move $s2, $a0
        move $s3, $a1

        jal  check_winner             # --- base cases ---
        li   $t0, 2
        bne  $v0, $t0, mm_not_o
        li   $t1, 10
        sub  $v0, $t1, $s3
        j    mm_ret
mm_not_o:
        li   $t0, 1
        bne  $v0, $t0, mm_not_x
        addi $v0, $s3, -10
        j    mm_ret
mm_not_x:
        jal  board_full
        beqz $v0, mm_search
        li   $v0, 0
        j    mm_ret

mm_search:                            # --- recursive case ---
        li   $t0, 2
        beq  $s2, $t0, mm_is_max
        li   $s1, 100                 # X minimises
        j    mm_start
mm_is_max:
        li   $s1, -100                # O maximises
mm_start:
        li   $s0, 0
mm_loop:
        li   $t0, 9
        beq  $s0, $t0, mm_done
        sll  $t1, $s0, 2
        la   $t2, board
        add  $t1, $t1, $t2
        lw   $t3, 0($t1)
        bnez $t3, mm_next
        sw   $s2, 0($t1)              # make the move
        li   $t4, 3
        sub  $a0, $t4, $s2            # switch player (3 - p)
        addi $a1, $s3, 1
        jal  minimax
        sll  $t1, $s0, 2
        la   $t2, board
        add  $t1, $t1, $t2
        sw   $zero, 0($t1)            # undo the move
        li   $t0, 2
        beq  $s2, $t0, mm_upd_max
        bge  $v0, $s1, mm_next        # minimiser keeps smaller score
        move $s1, $v0
        j    mm_next
mm_upd_max:
        ble  $v0, $s1, mm_next        # maximiser keeps larger score
        move $s1, $v0
mm_next:
        addi $s0, $s0, 1
        j    mm_loop
mm_done:
        move $v0, $s1
mm_ret:
        lw   $s3, 0($sp)
        lw   $s2, 4($sp)
        lw   $s1, 8($sp)
        lw   $s0, 12($sp)
        lw   $ra, 16($sp)
        addi $sp, $sp, 20
        jr   $ra
