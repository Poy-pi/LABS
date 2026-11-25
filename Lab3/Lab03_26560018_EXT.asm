# Name: Lê Viết Anh Hào        Student ID: 26560018
# Purpose: LAB 03, Extension - min_max(addr, n) returns the smallest in $v0 and the largest in $v1
#
# Register plan: $a0 = array address, $a1 = n, $v0 = min, $v1 = max,
#                $t0 = i, $t1..$t4 = temporaries, $s0..$s3 = results kept in main

.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
mAmin:  .asciiz "Class A smallest: "
mAmax:  .asciiz "Class A largest: "
mBmin:  .asciiz "Class B smallest: "
mBmax:  .asciiz "Class B largest: "
nl:     .asciiz "\n"

.text
.globl main
main:
    la   $a0, classA
    addi $a1, $zero, 10
    jal  min_max
    add  $s0, $v0, $zero        # copy both results right away
    add  $s1, $v1, $zero
    la   $a0, classB
    addi $a1, $zero, 8
    jal  min_max
    add  $s2, $v0, $zero
    add  $s3, $v1, $zero

    la   $a0, mAmin
    add  $a1, $s0, $zero
    jal  show
    la   $a0, mAmax
    add  $a1, $s1, $zero
    jal  show
    la   $a0, mBmin
    add  $a1, $s2, $zero
    jal  show
    la   $a0, mBmax
    add  $a1, $s3, $zero
    jal  show
    li   $v0, 10
    syscall

# min_max(addr = $a0, n = $a1): returns the smallest element in $v0 and the largest in $v1
min_max:
    lw   $v0, 0($a0)            # min = first element
    add  $v1, $v0, $zero        # max = first element
    addi $t0, $zero, 1          # i = 1
mm_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, mm_end
    sll  $t2, $t0, 2
    add  $t2, $t2, $a0
    lw   $t3, 0($t2)            # $t3 = element i
    slt  $t4, $t3, $v0          # element < min ?
    beq  $t4, $zero, mm_notmin
    add  $v0, $t3, $zero        # new min
mm_notmin:
    slt  $t4, $v1, $t3          # max < element ?
    beq  $t4, $zero, mm_next
    add  $v1, $t3, $zero        # new max
mm_next:
    addi $t0, $t0, 1
    j    mm_loop
mm_end:
    jr   $ra

# show(msg = $a0, value = $a1): prints msg, value and a new line; returns nothing
show:
    li   $v0, 4
    syscall
    li   $v0, 1
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    jr   $ra
