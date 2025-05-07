# we also need a sum variable

.data
	arr:    .word 1, 2, 3, 4, 5         #  array with 5 integers
	sum:    .word 0                     #  variable to hold the sum
	msg:    .asciiz "The sum value is: "

.text
.globl main

main:
	# get address of array and sum
	la $a0, arr                         #  $a0 = address of arr
	la $a1, sum                         #  $a1 = address of sum
	jal summation_3                     #  call function to update array and sum

	# print message
	li $v0, 4
	la $a0, msg                         #  print message string
	syscall

	# print final sum
	lw $a0, sum                         #  load sum into $a0
	li $v0, 1
	syscall

	# print newline
	li $v0, 11
	li $a0, 10                          #  ASCII newline
	syscall

	# exit
	li $v0, 10
	syscall

# Q1 — summation_3 function
# Adds 3 to each element in A, and adds 3 to sum each time
summation_3:
	li $t0, 0                           #  i = 0

loop_start:
	slti $t1, $t0, 5                    #  if i < 5
	beq $t1, $zero, end_loop            #  exit loop if false

	# A[i] = A[i] + 3
	mul $t2, $t0, 4                     #  offset = i * 4
	add $t3, $a0, $t2                   #  address of A[i]
	lw $t4, 0($t3)                      #  load word A[i]
	addi $t4, $t4, 3                    #  A[i] + 3
	sw $t4, 0($t3)                      #  store back into A[i]

	# sum = sum + 3
	lw $t5, 0($a1)                      #  load sum
	addi $t5, $t5, 3                    #  sum += 3
	sw $t5, 0($a1)                      #  store back sum

	addi $t0, $t0, 1                    #  i++
	j loop_start

end_loop:
	jr $ra                              #  return to main