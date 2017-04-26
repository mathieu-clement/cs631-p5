.func main
main:
    mov sp, #124
    add sp, sp // sp = 248, which is 256 - 8 (double word aligned)

    mov r0, #10
    bl fib_rec
    b halt

halt:
    b halt
.endfunc

.func fib_rec

# int fib_rec (int n)
fib_rec:
    /* This code manipulates sp directly. */
    # r0 : n => int
    cmp r0, #0      /* if n == 0 */
    moveq pc, lr
    cmp r0, #1      /* if n == 1 */
    moveq pc, lr

    # r1 : copy of n
    mov r1, r0
    # Preserve r1
    sub sp, #16     /* Allocate space on stack for r1, taking care of alignment */
    str r1, [sp]
    add r8, sp, #8
    str lr, [r8]

    sub r0, #1      /* n - 1 */
    bl fib_rec      /* fib_rec(n-1) */

    # r2 : result of fib_rec(n-1)
    mov r2, r0
    # Restore n from stack */
    ldr r1, [sp]
    # Preserve r2
    add r8, sp, #4
    str r2, [r8]    /* Store r2 */

    sub r0, r1, #2  /* n - 2 */
    bl fib_rec      /* fib_rec(n-2) */

    # r0 holds   result of fib_rec(n-2)
    # Bring back result of fib_rec(n-1), in sp+4 to r1
    add r8, sp, #4
    ldr r1, [r8]
    add r8, #4
    ldr lr, [r8]

    # Return sp to original position
    add sp, #16

    # Set return value
    add r0, r1
    mov pc, lr


