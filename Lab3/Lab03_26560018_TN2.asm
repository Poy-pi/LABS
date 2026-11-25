# Name: Lê Viết Anh Hào        Student ID: 26560018
# Purpose: LAB 03, Experiment 2 - arguments and results: max2(a, b) and clamp(x, lo, hi)
#
# Register plan: $a0-$a2 = arguments, $v0 = result, $s1 = second max2 result,
#                $t0, $t1 = temporaries inside the procedures

.data
nl: .asciiz "\n"

.text
.globl main
main:
    # ---- Part A: max2 (Listing 2) ----
    addi $a0, $zero, 15         # a = 15
    addi $a1, $zero, 42         # b = 42
    jal  max2                   # $v0 = max2(15, 42)
    add  $a0, $v0, $zero        # copy the result first,
    li   $v0, 1                 # then print it
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    addi $a0, $zero, -7         # a = -7
    addi $a1, $zero, -3         # b = -3
    jal  max2                   # $v0 = max2(-7, -3)
    add  $s1, $v0, $zero        # keep the result in $s1

    # ---- Part B: clamp (Listing 3), x is typed on the keyboard ----
    li   $v0, 5                 # read an integer x into $v0
    syscall
    add  $a0, $v0, $zero        # argument 1: x
    addi $a1, $zero, 0          # argument 2: lo = 0
    addi $a2, $zero, 100        # argument 3: hi = 100
    jal  clamp
    add  $a0, $v0, $zero        # print the result
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10
    syscall

# max2(a = $a0, b = $a1): returns the larger one in $v0
max2:
    add  $v0, $a0, $zero        # result = a
    slt  $t0, $a0, $a1          # $t0 = 1 if a < b
    beq  $t0, $zero, max2_end   # a >= b: keep a
    add  $v0, $a1, $zero        # otherwise result = b
max2_end:
    jr   $ra

# clamp(x = $a0, lo = $a1, hi = $a2): returns x limited to [lo, hi] in $v0
clamp:
    slt  $t0, $a0, $a1          # $t0 = 1 if x < lo
    bne  $t0, $zero, clamp_lo
    slt  $t1, $a2, $a0          # $t1 = 1 if hi < x
    bne  $t1, $zero, clamp_hi
    add  $v0, $a0, $zero        # otherwise the result is x
    j    clamp_end
clamp_lo:
    add  $v0, $a1, $zero        # x < lo: the result is lo
    j    clamp_end
clamp_hi:
    add  $v0, $a2, $zero        # hi < x: the result is hi
clamp_end:
    jr   $ra
