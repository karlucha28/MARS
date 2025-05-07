#declare Array + sum
.data 

A: .word 1,2,3,4,5

sum: .word 0

newline: .asciiz "\n"
	
sum_text: .asciiz "The sum is: "


#Load base address

.text

main:

	la $s0, A
	
	li $s1,0  # index i
	
	li $s2, 5 # loop limit

# Loop over 5 elements 

loop:
	bge $s1, $s2, done
	
	
	mul $t1, $s1, 4  #get address on ith element in the array
	
	add $t1, $t1, $s0
	
	lw $t2, 0($t1)
	
	addi $t2, $t2, 3
	
	sw $t2, 0($t1)
	
	
	lw $t3, sum
	
	addi $t3, $t3, 3
	
	sw $t3, sum
	
	
	addi $s1, $s1, 1
	
	j loop
	
	
done: 


#  Load base address again 

	la $s0, A
	
	li $s1, 0   # index i
	
	
print_loop:
	
	bge $s1, 5, print_sum
	
	mul $t1, $s1, 4
	
	add $t1, $t1, $s0
	
	lw $a0, 0($t1)
	
	li $v0, 1     #print int 
	
	syscall
	
	
	# print newline
	
	li $v0, 4
	
	la $a0, newline 
	
	syscall
	
	
	addi $s1, $s1, 1
	
	j print_loop 
	
	
print_sum:
	
	li $v0, 4
	
	la $a0, sum_text
	
	syscall
	
	
	lw $a0, sum
	
	li $v0, 1
	
	syscall
	
	li $v0, 10
	
	syscall 
	
		
	