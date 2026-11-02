# Name: Le Viet Anh Hao
# Student ID: 26560018
# Purpose: Lab 01, Experiment 3 - read meter readings and print the usage.
# Registers: $s0-$s3 readings, $t0-$t2 usage of months 1-3, $t3 total

.data
prompt1: .asciiz "Enter previous reading (kWh): "
prompt2: .asciiz "Enter current reading (kWh): "
label:   .asciiz "Usage (kWh): "
newline: .asciiz "\n"
prompt:  .asciiz "Enter reading (kWh): "
m1:      .asciiz "Month 1: "
m2:      .asciiz "Month 2: "
m3:      .asciiz "Month 3: "
tot:     .asciiz "Total:   "
nl:      .asciiz "\n"

.text
.globl main
main:
    li   $v0, 4
    la   $a0, prompt1
    syscall
    li   $v0, 5
    syscall
    add  $s0, $v0, $zero

    li   $v0, 4
    la   $a0, prompt2
    syscall
    li   $v0, 5
    syscall
    add  $s1, $v0, $zero

    sub  $t0, $s1, $s0

    li   $v0, 4
    la   $a0, label
    syscall
    li   $v0, 1
    add  $a0, $t0, $zero
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall

    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    add  $s0, $v0, $zero

    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    add  $s1, $v0, $zero

    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    add  $s2, $v0, $zero

    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    add  $s3, $v0, $zero

    sub  $t0, $s1, $s0
    sub  $t1, $s2, $s1
    sub  $t2, $s3, $s2
    add  $t3, $t0, $t1
    add  $t3, $t3, $t2

    li   $v0, 4
    la   $a0, m1
    syscall
    li   $v0, 1
    add  $a0, $t0, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 4
    la   $a0, m2
    syscall
    li   $v0, 1
    add  $a0, $t1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 4
    la   $a0, m3
    syscall
    li   $v0, 1
    add  $a0, $t2, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 4
    la   $a0, tot
    syscall
    li   $v0, 1
    add  $a0, $t3, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
