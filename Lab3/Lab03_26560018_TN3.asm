# Name: Lê Viết Anh Hào        Student ID: 26560018
# Purpose: LAB 03, Experiment 3 - gradebook library: sum_array, count_pass (pass mark M = 87), show
#
# Register plan: $a0 = array address, $a1 = number of elements, $a2 = mark,
#                $v0 = result, $t0 = i, $t1..$t4 = temporaries

.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
msgA:   .asciiz "Class A total: "
msgB:   .asciiz "Class B total: "
msgPA:  .asciiz "Class A passed: "
msgPB:  .asciiz "Class B passed: "
nl:     .asciiz "\n"

.text
.globl main
main:
    la   $a0, classA            # argument 1: address of classA[0]
    addi $a1, $zero, 10         # argument 2: number of scores
    jal  sum_array              # $v0 = total of class A
    la   $a0, msgA
    add  $a1, $v0, $zero
    jal  show
    la   $a0, classB
    addi $a1, $zero, 8
    jal  sum_array              # $v0 = total of class B
    la   $a0, msgB
    add  $a1, $v0, $zero
    jal  show

    la   $a0, classA            # passes of class A
    addi $a1, $zero, 10
    addi $a2, $zero, 87         # mark M = 55 + 4 * D = 55 + 4 * 8 = 87
    jal  count_pass
    la   $a0, msgPA
    add  $a1, $v0, $zero
    jal  show
    la   $a0, classB            # passes of class B
    addi $a1, $zero, 8
    addi $a2, $zero, 87         # mark M = 87
    jal  count_pass
    la   $a0, msgPB
    add  $a1, $v0, $zero
    jal  show
    li   $v0, 10
    syscall

# sum_array(addr = $a0, n = $a1): returns the sum of n words in $v0
sum_array:
    addi $v0, $zero, 0          # sum = 0
    addi $t0, $zero, 0          # i = 0
sum_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, sum_end
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = address of element i
    lw   $t3, 0($t2)
    add  $v0, $v0, $t3          # sum = sum + element i
    addi $t0, $t0, 1            # i = i + 1
    j    sum_loop
sum_end:
    jr   $ra

# count_pass(addr = $a0, n = $a1, mark = $a2): returns in $v0 the count of words >= mark
count_pass:
    addi $v0, $zero, 0          # count = 0
    addi $t0, $zero, 0          # i = 0
cp_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, cp_end    # leave the loop when i >= n
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = address of element i
    lw   $t3, 0($t2)            # $t3 = element i
    slt  $t4, $t3, $a2          # $t4 = 1 if element < mark
    bne  $t4, $zero, cp_next   # element < mark: do not count
    addi $v0, $v0, 1            # count = count + 1
cp_next:
    addi $t0, $t0, 1            # i = i + 1
    j    cp_loop
cp_end:
    jr   $ra

# show(msg = $a0, value = $a1): prints msg, value and a new line; returns nothing
show:
    li   $v0, 4                 # $a0 already holds the address of msg
    syscall
    li   $v0, 1
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    jr   $ra
