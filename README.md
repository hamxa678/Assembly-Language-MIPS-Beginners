# Assembly Language (MIPS) for Beginners

A hands-on, lesson-by-lesson course that teaches the basics of assembly language using the **MIPS32** instruction set. Every lesson is a small, runnable program with comments, so you can read it, run it, change it, and see what happens.

The course starts from the very first instruction and finishes with a complete project: a Tic-Tac-Toe game with an unbeatable AI, written entirely in assembly.

## Who is this for?

- Students taking a computer architecture or assembly language course
- Programmers who know a high-level language (C, Java, Python) and want to see what happens underneath
- Anyone curious about how a CPU really executes code

No prior assembly experience is needed.

## What you need

One of these free MIPS simulators:

| Simulator | Notes |
|---|---|
| [MARS](http://courses.missouristate.edu/KenVollmar/MARS/) | Java-based, with a friendly GUI. Recommended for beginners. |
| [SPIM / QtSpim](https://spimsimulator.sourceforge.net/) | Lightweight, also works from the command line. |

### Running a program

**MARS**
1. Open the `.asm` file (File > Open).
2. Assemble (F3).
3. Run (F5). Input and output appear in the Run I/O pane at the bottom.

**SPIM (command line)**
```bash
spim -file path/to/program.asm
```

## Course outline

| Lesson | Topic |
|---|---|
| L1 - L11 | Fundamentals: registers, instructions, data movement, arithmetic, branching, loops, syscalls, integer multiplication, and more. *(see each folder)* |
| L12 | Arrays: sum, maximum, bubble sort |
| L13 | Strings: length, reverse, palindrome check |
| L14 | Procedures and the stack |
| L15 | Recursion: factorial, Fibonacci, GCD |
| L16 | Floating point (coprocessor 1) |
| L17 | Bit manipulation: shifts, masks, popcount |
| L18 | Dynamic memory and linked lists |
| **Project** | **Unbeatable Tic-Tac-Toe with minimax** |

Each lesson folder contains the source code, and from L12 onward a `README.md` with key ideas and practice exercises.

## The final project: Unbeatable Tic-Tac-Toe

You play X against a computer that searches every possible game with the **minimax** algorithm. The best you can do is draw.

It brings together arrays, procedures, the stack, and recursion. See [`Project-TicTacToe/`](Project-TicTacToe) for details and extra challenges.

## Repository structure

```
Assembly-Language-MIPS-Beginners/
├── L1 ... L11/           Fundamentals
├── L12/                  Arrays
├── L13/                  Strings
├── L14/                  Procedures and the stack
├── L15/                  Recursion
├── L16/                  Floating point
├── L17/                  Bit manipulation
├── L18/                  Dynamic memory and linked lists
├── Project-TicTacToe/    Final project
└── README.md
```

## MIPS quick reference

### Registers

| Register | Name | Purpose |
|---|---|---|
| `$zero` | `$0` | Always 0 |
| `$v0 - $v1` | `$2 - $3` | Return values and syscall number |
| `$a0 - $a3` | `$4 - $7` | Procedure arguments |
| `$t0 - $t9` | | Temporaries (callee may overwrite) |
| `$s0 - $s7` | | Saved registers (save and restore if used) |
| `$sp` | `$29` | Stack pointer |
| `$ra` | `$31` | Return address |
| `$f0 - $f31` | | Floating-point registers |

### Common syscalls

Put the number in `$v0`, arguments in `$a0` or `$f12`, then run `syscall`.

| `$v0` | Service | Argument / result |
|---|---|---|
| 1 | Print integer | `$a0` = value |
| 2 | Print float | `$f12` = value |
| 4 | Print string | `$a0` = address |
| 5 | Read integer | result in `$v0` |
| 6 | Read float | result in `$f0` |
| 8 | Read string | `$a0` = buffer, `$a1` = max length |
| 9 | Allocate heap memory | `$a0` = bytes, address in `$v0` |
| 10 | Exit | |
| 11 | Print character | `$a0` = character |

### Common instruction patterns

```asm
li   $t0, 5            # load immediate
la   $a0, label        # load address
lw   $t1, 0($t0)       # load word
sw   $t1, 4($t0)       # store word
add  $t2, $t0, $t1     # t2 = t0 + t1
beq  $t0, $t1, target  # branch if equal
j    target            # unconditional jump
jal  proc              # call procedure (saves return address in $ra)
jr   $ra               # return
```

## How to get the most out of this course

1. **Read the code first**, then predict the output before running it.
2. **Run it step by step.** MARS lets you single-step and watch registers change; this is the best way to learn.
3. **Break it on purpose.** Change a value, remove a line, and see what happens.
4. **Do the exercises** at the end of each lesson README.
5. **Comment your own code.** Assembly is easy to write and hard to read later.

## Contributing

Found a bug or have an idea for a new lesson? Open an issue or send a pull request. Please keep new lessons small, well commented, and tested in MARS or SPIM.

## Author

Created by [@hamxa678](https://github.com/hamxa678).

If this repository helped you, consider giving it a star.
