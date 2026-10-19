# L15 - Recursion

**Goal:** make a procedure call itself safely.

## Key ideas
- Every recursive procedure needs a **base case** and a **recursive case**.
- Each call gets its own stack frame holding `$ra` and anything needed after the call returns (here `$a0`, `$s0`).
- `fib` shows a two-call recursion: save the first result in `$s0` before making the second call.
- `gcd` is tail-recursive (nothing to do after the call) but we keep the frame for clarity.

## Files
- `recursion.asm` - factorial, Fibonacci, Euclid's GCD.

## Exercises
1. Recursive sum of 1..n.
2. Recursive `power(b, e)`.
3. Print a number in binary recursively.
4. Towers of Hanoi: print each move for n = 3.
