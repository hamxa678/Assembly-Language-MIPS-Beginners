# L13 - Strings

**Goal:** treat text as an array of bytes ending in `0` (null terminator).

## Key ideas
- `.asciiz "hi"` stores `'h','i',0`. `.space 64` reserves an empty buffer.
- Syscall 8 reads a line, **including the newline**, so we strip it first.
- Walk a string with `lb` until the byte is 0 (`strlen`).
- Two-index technique (left and right moving inward) solves both reversing and palindrome checking.
- Procedures take arguments in `$a0-$a3` and return in `$v0`; `jal` calls, `jr $ra` returns.

## Files
- `strings.asm` - `strlen`, `strip_newline`, `reverse`, `is_palindrome`.

## Exercises
1. Count the vowels in a string.
2. Convert a string to upper case (subtract 32 from `'a'..'z'`).
3. Make the palindrome check ignore upper/lower case.
4. Write `strcmp` that compares two strings.
