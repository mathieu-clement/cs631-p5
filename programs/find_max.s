.func main
main:
    mov sp, #124
    add sp, sp // sp = 248, which is 256 - 8 (double word aligned)

    sub sp, #4
    mov r0, #9
    str r0, [sp]

    sub sp, #4
    mov r0, #56
    str r0, [sp]

    sub sp, #4
    mov r0, #7
    str r0, [sp]

    sub sp, #4
    mov r0, #6
    str r0, [sp]

    sub sp, #4
    mov r0, #5
    str r0, [sp]

    sub sp, #4
    mov r0, #4
    str r0, [sp]

    sub sp, #4
    mov r0, #3
    str r0, [sp]

    sub sp, #4
    mov r0, #2
    str r0, [sp]

    sub sp, #4
    mov r0, #1
    str r0, [sp]

    mov r0, sp
    mov r1, #9

    bl find_max

    b halt

halt:
    b halt

.endfunc

.func find_max

# int find_max(int *array, int n)
find_max:
    # r0 : pointer to array 
    # r1 : size of array => int
    # r2 : max => int
    # r3 : i (for loop index) => int
    # r4 : value of array[r0]
    sub sp, sp, #8
    str r4, [sp] /* Preserve r4 */
    ldr r4, [r0] /* array[i] = array[0] */
    mov r2, r4  /* max = array[0] */
    mov r3, #0
    cmp r1, #1          /* if n == 1 */
    beq end             /*      goto end */

loop:
    cmp r3, r1          /* if i == n */
    beq end             /*      goto end */
    cmp r4, r2          /* if array[i] > max */
    movge r2, r4        /*      max = array[i] */
    add r3, r3, #1      /* i++ */
    cmp r3, r1          /* if i == n */
    beq end             /*      goto end */
    mov r5, r0
    mov r6, r3
    add r6, r6 /* r6 << 1 */
    add r6, r6 /* r6 << 1 */
    add r5, r6
    ldr r4, [r5]
    b loop

end:
    ldr r4, [sp]        /* Restore r4 */
    add sp, sp, #8
    mov r0, r2          /* return max */
    mov pc, lr

