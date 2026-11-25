# Name: Lê Viết Anh Hào        Student ID: 26560018
# Purpose: LAB 03, Experiment 4 - sum3 keeps $s0 unchanged by saving it on the stack (Fix B)
#
# Register plan: $s0 = class number (must survive the call), $s1 = the sum,
#                $a0-$a2 = the three marks, $v0 = result of sum3

.text
.globl main
main:
    addi $s0, $zero, 2          # $s0 = class number, still needed later
    addi $a0, $zero, 8          # three marks of one student
    addi $a1, $zero, 7
    addi $a2, $zero, 9
    jal  sum3                   # $v0 = 8 + 7 + 9
    add  $s1, $v0, $zero        # $s1 = the sum
    add  $a0, $s0, $zero        # print the class number
    li   $v0, 1
    syscall
    li   $v0, 11                # print a space (ASCII 32)
    addi $a0, $zero, 32
    syscall
    add  $a0, $s1, $zero        # print the sum
    li   $v0, 1
    syscall
    li   $v0, 10
    syscall

# sum3(a = $a0, b = $a1, c = $a2): returns a + b + c in $v0; $s0 is saved and restored
sum3:
    addi $sp, $sp, -4           # make room for one word on the stack
    sw   $s0, 0($sp)            # save $s0 at 0($sp)
    add  $s0, $a0, $a1
    add  $v0, $s0, $a2
    lw   $s0, 0($sp)            # restore $s0 from 0($sp)
    addi $sp, $sp, 4            # give the room back
    jr   $ra
