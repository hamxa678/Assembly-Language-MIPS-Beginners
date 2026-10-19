# L16 - Floating Point

**Goal:** use the floating-point coprocessor (CP1).

## Key ideas
- 32 float registers `$f0-$f31`; single precision uses `.s` instructions (`add.s`, `mul.s`, `div.s`).
- Load/store: `lwc1`, `swc1` or the pseudo `l.s`, `s.s`.
- Move between worlds with `mtc1` / `mfc1`; convert with `cvt.s.w` (int to float) and `cvt.w.s` (float to int).
- Compare with `c.lt.s`, `c.eq.s`, `c.le.s`, then branch with `bc1t` / `bc1f`.
- Syscalls: 2 prints the float in `$f12`, 6 reads a float into `$f0`.

## Files
- `floating_point.asm` - average of floats and circle area with a comparison.

## Exercises
1. Read a radius with syscall 6 and print the circumference.
2. Convert Celsius to Fahrenheit.
3. Find the largest of four floats.
