.data
A:          .word 6, 34, -7, 3, 0, -20, 6, -2, 10
B:          .word 3, -1, 2, -9, -1, 4, 6, 11, 4
sum:        .word 0
msg:        .asciiz " Array elements sum = "
space:      .asciiz " "
new_line:   .asciiz "\n"

.text
.globl main

main:

# ---- initialize registers ----
	la $s0, A            #  address of A
	la $s1, B            #  address of B
	la $t2, sum          #  address of sum
	la $a0, msg          #  a0 holds the address of the message string

# --- loop 1: A[i] = A[i] + B[i] ---
loop_start:
	li $t0, 0            #  i = 0

loop_condition:
	slti $t1, $t0, 9     #  if i < 9
	beq $t1, $zero, print_loop   #  exit loop if i >= 9

	sll $t4, $t0, 2      #  offset = i * 4
	add $t5, $s0, $t4    #  $t5 = &A[i]
	add $t6, $s1, $t4    #  $t6 = &B[i]

	lw $t7, 0($t5)       #  load A[i]
	lw $t8, 0($t6)       #  load B[i]
	add $t9, $t7, $t8    #  A[i] + B[i]
	sw $t9, 0($t5)       #  store result back into A[i]

	addi $t0, $t0, 1     #  i++
	j loop_condition     #  repeat

# --- loop 2: print A[i] with space or newline ---
	li $t3, 0            #  i = 0

print_loop:
	slti $t1, $t3, 9
	beq $t1, $zero, sum_loop     #  if i >= 9, go to sum loop

	sll $t4, $t3, 2
	add $t5, $s0, $t4
	lw $a0, 0($t5)

	li $v0, 1
	syscall

	addi $t3, $t3, 1     #  i++

	li $t6, 9
	beq $t3, $t6, print_newline  #  if this was last element, print newline

	li $v0, 4
	la $a0, space        #  print space
	syscall

	j print_loop

print_newline:
	li $v0, 4
	la $a0, new_line     #  print newline
	syscall
	j sum_loop

# --- loop 3: sum A[i] into total ---
sum_loop:
	li $t0, 0            #  i = 0
	li $t1, 0            #  total = 0

sum_loop_condition:
	slti $t3, $t0, 9
	beq $t3, $zero, print_sum

	sll $t4, $t0, 2
	add $t5, $s0, $t4
	add $t6, $s1, $t4

	lw $t7, 0($t5)
	lw $t8, 0($t6)

	add $t9, $t7, $t8
	add $t1, $t1, $t9
	addi $t1, $t1, 1

	addi $t0, $t0, 1
	j sum_loop_condition

print_sum:
	sw $t1, 0($t2)       #  store final sum in memory

	li $v0, 4
	la $a0, new_line     #  line break before sum
	syscall

	la $a0, msg          #  print "Array elements sum = "
	syscall

	li $v0, 1
	move $a0, $t1        #  print the actual sum
	syscall

	li $v0, 4
	la $a0, space        #  spacing (optional)
	syscall

loop_end:
	li $v0, 10
	syscall
