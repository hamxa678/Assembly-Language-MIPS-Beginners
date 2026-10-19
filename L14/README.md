# L14 - Procedures and the Stack

**Goal:** write procedures that call other procedures without losing data.

## Key ideas
- `jal` stores the return address in `$ra`. A procedure that calls another one **must save `$ra`**, otherwise it is overwritten.
- The stack grows downward: `addi $sp, $sp, -N` allocates, `addi $sp, $sp, N` frees.
- Convention:
  - `$a0-$a3` arguments, `$v0-$v1` results
  - `$t0-$t9` temporaries: the callee may destroy them
  - `$s0-$s7` saved: if you use them, save and restore them
- A leaf procedure (calls nothing) needs no frame.

## Files
- `stack_and_procedures.asm` - `sum_of_squares` calling `square` twice.

## Exercises
1. Write `max3(a, b, c)` using a helper `max2(a, b)`.
2. Write `power(base, exp)` with a loop and a stack frame.
3. Print `$sp` before and after a call to prove the frame is freed.
