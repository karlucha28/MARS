
#declair array
.data 

A: .word 6, 34, -7, 3, 0, -20, 6, -2, 10

B: .word 3, -1, 2, -9, -1, 4, 6, 11, 4

sum: .word 0

newline: .asciiz "\n"

sum_text: .asciiz "Array elements sum = "


#Loop 1 -Add arrays

.text

main: 
	la $s0, A
	
	la $s1, B
	
	li $t0, 0 #index i
	
loop1:
	
	bge $t0, 9, loop2prep # check if the index is less or equal 9 
	
	#get the addreses of needed elements in the itteration
	mul $t1, $t0, 4
	
	add $t2, $s0, $t1
	
	add $t3, $s1, $t1
	
	#load the values
	lw $t4, 0($t2)
	
	lw $t5, 0($t3)
	# A[i] = A[i] + B[i]
	add $t4, $t4, $t5
	#save the value to the first array A
	sw $t4, 0($t2)
	
	#increase i 
	addi $t0, $t0, 1
	
	j loop1
	
#set the index to 0 for the next loop	
loop2prep:

	li $t0, 0
	
loop_sum:

	bge $t0, 9, print_loop
	
	mul $t1, $t0, 4
	
	add $t2, $s0, $t1
	
	add $t3, $s1, $t1
	
	lw $t4, 0($t2)
	
	lw $t5, 0($t3)
	
	lw $t6, sum
	#sum = A[i] + B[i] + 1
	add $t6, $t6, $t4
	
	add $t6, $t6, $t5
	
	addi $t6, $t6, 1
	
	sw $t6, sum
	
	
	addi $t0, $t0, 1
	
	j loop_sum
	
	
print_loop:
	
	li $t0, 0
	
print_arr:

	bge $t0, 9, print_sum
	
	mul $t1, $t0, 4
	
	add $t2, $t1, $s0
	
	lw $a0, 0($t2)
	
	li $v0, 1
	
	syscall
	
	
	li $v0, 4
	
	la $a0, newline
	
	syscall
	
	
	
	addi $t0, $t0, 1
	
	j print_arr
	
print_sum:
	
	li $v0, 4
	
	la $a0, sum_text
	
	syscall
	
	
	lw $a0, sum
	
	li $v0, 1
	
	syscall
	
	