# L12 - Arrays

**Goal:** store a list of numbers in memory and walk through it.

## Key ideas
- `.word 1, 2, 3` reserves consecutive 4-byte words; the label is the address of the first one.
- Element `i` lives at `base + 4*i`. Either keep a pointer and add 4 each step, or use `sll $t, $i, 2` to scale the index.
- `lw` / `sw` read and write one word; `lb` / `sb` do the same for one byte.
- Nested loops (bubble sort) are just two counters and two labels.

## Files
- `arrays.asm` - sum, maximum and bubble sort of an 8-element array.

## Exercises
1. Print the average (integer division) of the array.
2. Count how many elements are even.
3. Reverse the array in place.
4. Change bubble sort to sort in descending order.
