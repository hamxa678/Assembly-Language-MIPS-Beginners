# Project - Unbeatable Tic-Tac-Toe

Play X against a computer that uses **minimax** to search every possible game. You can draw, but you cannot win.

## Run it
- **MARS:** open `tictactoe.asm`, Assemble (F3), Run (F5), and type moves in the Run I/O pane.
- **SPIM:** `spim -file tictactoe.asm`

Type a number 1-9 to place your X (the numbers are shown on empty cells).

## How it works
| Procedure | Purpose | Lecture |
|---|---|---|
| `print_board` | loops over the 9-word board array | L12 |
| `check_winner` | tests 8 winning lines stored in a table | L12 |
| `human_move` | input validation loop | L13/L14 |
| `computer_move` | tries each empty cell, keeps the best score | L14 |
| `minimax` | recursion with make/undo of each move | L15 |

**Scoring:** O wins = `10 - depth`, X wins = `depth - 10`, draw = 0. Using depth makes the AI prefer quick wins and slow losses.

## Challenges
1. Let the computer move first (it should then still never lose).
2. Add a score counter across rounds.
3. Add alpha-beta pruning to speed up the first move.
4. Add an "easy mode" where the computer picks a random empty cell.
5. Extend to a 4x4 board (watch the search time!).
