# Name: Lê Viết Anh Hào        Student ID: 26560018
# Purpose: LAB 03, Experiment 1 - one procedure called from two places (sep) and a second procedure (stars)
#
# Register plan: $v0 / $a0 = syscall service / argument, $ra = return address (set by jal)

.data
title:    .asciiz "SCORE REPORT\n"
endMsg:   .asciiz "END\n"
line:     .asciiz "----------\n"
starLine: .asciiz "**********\n"

.text
.globl main
main:
    jal  stars              # first line of stars
    li   $v0, 4
    la   $a0, title
    syscall
    jal  sep                # call (1)
    li   $v0, 4
    la   $a0, endMsg
    syscall
    jal  stars              # last line of stars
    li   $v0, 10
    syscall

# sep(): prints a separator line; returns nothing
sep:
    li   $v0, 4
    la   $a0, line
    syscall
    jr   $ra                # return to the caller

# stars(): prints a line of stars; returns nothing
stars:
    li   $v0, 4
    la   $a0, starLine
    syscall
    jr   $ra                # return to the caller
