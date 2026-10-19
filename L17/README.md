# L17 - Bit Manipulation

**Goal:** work directly on individual bits.

## Key ideas
| Operation | Instruction | Use |
|---|---|---|
| shift left n | `sll` | multiply by 2^n |
| shift right n | `srl` / `sra` | divide by 2^n (logical / arithmetic) |
| AND | `and`, `andi` | mask: keep chosen bits (`x & 1` = odd?) |
| OR | `or`, `ori` | set bits |
| XOR | `xor`, `xori` | flip bits |

- `x & (x-1)` clears the lowest set bit: counting how often you can do it gives the popcount, and the result is 0 only for powers of two.

## Files
- `bit_manipulation.asm` - binary print, popcount, power-of-two test, shift tricks.

## Exercises
1. Set, clear and toggle bit k of a number.
2. Swap two variables with three XORs.
3. Reverse the bits of a byte.
