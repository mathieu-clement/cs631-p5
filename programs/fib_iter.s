.func main
main:
    mov sp, #124
    add sp, sp // sp = 248, which is 256 - 8 (double word aligned)

    mov r0, #10

    bl fib_iter

    b halt

halt:
    b halt

.endfunc

.func fib_iter

# int fib_iter (int n)
fib_iter:
    # r0 : n => int

    # Handle special case of n == 0
    cmp r0, #0
    bxeq lr

    # Handle special case of n == 1
    cmp r0, #1
    bxeq lr

    # Create an array of n + 1 elements on the stack
    add r1,  r0, #1     /* r1 = n + 1 */
    mov r2, r1
    add r2, r2
    add r2, r2
    sub sp, r2

    # array[0] = 0
    mov r2, #0
    str r2, [sp]

    # array[1] = 1
    mov r2, #1
    mov r8, sp
    add r8, #4
    str r2, [r8]

    # array[2] = 2
    mov r2, #1
    add r8, #4
    str r2, [r8]

    # array[3 ... n] = array[i-1] + array[i-2]

    # r3 : i => int
    mov r3, #2 /* starts at 1, will be incremented to 2 immediately */

    # r2 : i-1 or i-2
    # r4 : array[i-1] 
    # r5 : array[i-2]

loop:
    add r3, #1 /* ++i */
    cmp r3, r1 /* loop end condition */
    beq end

    # array[i-1]
    sub r2, r3, #1
    # ldr r4, [sp, r2, LSL #2]
    mov r8, r2
    add r8, r8
    add r8, r8
    add r8, sp
    ldr r4, [r8]

    # array[i-2]
    sub r2, r3, #2
    # ldr r5, [sp, r2, LSL #2]
    mov r8, r2
    add r8, r8
    add r8, r8
    add r8, sp
    ldr r5, [r8]

    # array[i-1] + array[i-2]
    add r4, r5
    # LSL
    mov r8, r3
    add r8, r8
    add r8, r8
    add r8, sp
    str r4, [r8]

    b loop

end:
    # return array[n]
    add r0, r0
    add r0, r0
    add r1, r0, sp
    ldr r0, [r1]

    # restore stack
    add r1, r1
    add r1, r1
    add sp, r1
    bx lr
