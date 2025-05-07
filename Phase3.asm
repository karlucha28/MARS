.data 

menu: .asciiz " Choose item (1-Water:$1, 2-Snack:$2, 3-Sandwich:$3, 4-Meal:$5, -1 to exit): "

prompt: .asciiz "Enter your money: "

not_enough: .asciiz "Not enough balance."

leftover: .asciiz "Remaining balance: "


.text

.globl main


main:

	li $v0, 4
	
	la $a0, prompt
	
	syscall
	
	
	li $v0, 5
	
	syscall
	
	move $s0, $v0  # balance in $s0
	
	
vending_loop:
	
	li $v0, 4
	
	la $a0, menu
	
	syscall
	
	
	li $v0, 5
	
	syscall
	
	move $t0, $v0,   # option 
	
	
	li $t1, -1
	
	beq $t0, $t1, exit_machine 
	
	
	li $t2, 1
	
	beq $t0, $t2, water
	
	li $t2, 2
	
	beq $t0, $t2, snack
	
	li $t2, 3
	
	beq $t0, $t2, sandwich
	
	li $t2, 4
	
	beq $t0, $t2, meal
	
	j vending_loop
	
	
water:

	li $t3, 1
	
	j check_price
	
snack:

	li $t3, 2
	
	j check_price
	
sandwich:

	li $t3, 2
	
	j check_price
	
meal:
	
	li $t3, 5
	
	j check_price
	
check_price: 

	blt $s0, $t3, print_error
	
	sub $s0, $s0, $t3
	
	j vending_loop
	
print_error:

	li $v0, 4
	
	la $a0, not_enough
	
	syscall
	
	j vending_loop
	
exit_machine:

	li $v0, 4
	
	la $a0, leftover
	
	syscall
	
	
	li $v0, 1
	
	move $a0, $s0
	
	syscall 
	
	li $v0, 10
	
	syscall