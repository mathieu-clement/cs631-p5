.func main
main:
    mov sp, #124
    add sp, sp // sp = 248, which is 256 - 8 (double word aligned)

    sub sp, #4
    mov r0, #1
    str r0, [sp]

    sub sp, #4
    mov r0, #2
    str r0, [sp]

    sub sp, #4
    mov r0, #3
    str r0, [sp]

    sub sp, #4
    mov r0, #4
    str r0, [sp]

    sub sp, #4
    mov r0, #5
    str r0, [sp]

    sub sp, #4
    mov r0, #6
    str r0, [sp]

    sub sp, #4
    mov r0, #7
    str r0, [sp]

    sub sp, #4
    mov r0, #8
    str r0, [sp]

    sub sp, #4
    mov r0, #9
    str r0, [sp]

    mov r0, sp
    mov r1, #9

    bl sum_array

    mov r4, #0
    sub r4, #1
    b halt 

halt:
    b halt
    

.endfunc

.func sum_array

# int sum_array(int *array, int n)
sum_array:
    # r0 : pointer to array (address is incremented directly to access elements) 
    # r1 : size of array => int
    # r2 : sum => int
    # r3 : i (for loop index) => int
    # r4 : value of array[r0]
    mov r2, $0 // sum = 0
    mov r3, $0 // i = 0

    cmp r1, $0 // n == 0
    beq end

loop:
    ldr r4, [r0]
    add r0, $4
    add r2, r4 // sum += array[i]
    add r3, $1
    cmp r3, r1 // i < n
    bne loop

end:
    mov r0, r2
    bx lr

.endfunc
