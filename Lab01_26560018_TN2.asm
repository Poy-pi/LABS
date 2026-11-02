# Name: Le Viet Anh Hao
# Student ID: 26560018
# Purpose: Lab 01, Experiment 2 - energy used over three months and translating statements.
# Registers: $s0-$s3 readings, $t0-$t2 usage, $t3 total (Part A)
#            $s0=y, $s1=z, $s2=w, $t0=x1, $t1=x2, $t2=x3, $t3=x4, $t5=temporary (Part B)

.text
.globl main
main:
    # Part A: energy used over three months
    addi $s0, $zero, 1200
    addi $s1, $zero, 1350
    addi $s2, $zero, 1475
    addi $s3, $zero, 1640

    sub  $t0, $s1, $s0
    sub  $t1, $s2, $s1
    sub  $t2, $s3, $s2
    add  $t3, $t0, $t1
    add  $t3, $t3, $t2

    # Part B: translating statements
    addi $s0, $zero, 8
    addi $s1, $zero, 5
    addi $s2, $zero, 3

    add  $t0, $s0, $s1
    add  $t0, $t0, $s2

    add  $t1, $s0, $s1
    addi $t5, $s2, 5
    sub  $t1, $t1, $t5

    add  $t2, $s0, $zero

    sub  $t3, $s1, $s0

    li   $v0, 10
    syscall
