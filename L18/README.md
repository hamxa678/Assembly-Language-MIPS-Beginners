# L18 - Dynamic Memory and Linked Lists

**Goal:** allocate memory at run time and build a data structure with pointers.

## Key ideas
- Syscall 9 (`sbrk`) takes the byte count in `$a0` and returns the address of fresh heap memory in `$v0`.
- A node is just two words: `[0]` value, `[4]` pointer to the next node (0 means null).
- Traversal: `while (p != 0) { use p->value; p = p->next; }`.
- Pushing at the head is O(1): new node's `next` = old head; head = new node.

## Files
- `linked_list.asm` - build 1..5, print the list, sum it.

## Exercises
1. Append at the tail instead of the head.
2. Write `length(list)`.
3. Reverse the list in place by re-pointing `next`.
4. Delete the first node containing a given value.
