.data
    # Prices in dollars as float
    prices:     .float 1.50, 2.25, 4.99, 10.00
    balance:    .float 0.0
    menu:       .asciiz "\n1. Water ($1.50)\n2. Snacks ($2.25)\n3. Sandwiches ($4.99)\n4. Meals ($10.00)\nEnter item (-1 to quit): "
    prompt:     .asciiz "Enter money: "
    notbalance:      .asciiz "Not enough balance!\n"
    final:     .asciiz "Final balance: $"
    newline:    .asciiz "\n"

.text
.globl main

main:
    # Print prompt for money
    li $v0, 4
    la $a0, prompt
    syscall

    # Read money inserted
    li $v0, 6         
    syscall
    la $t0, balance
    s.s $f0, 0($t0)    # store $f0 (float) into balance

vending_loop:
    # Print menu
    li $v0, 4
    la $a0, menu
    syscall

    # Read selection
    li $v0, 5
    syscall
    move $a0, $v0      # $a0 = option

    # Check for exit
    li $t2, -1
    beq $a0, $t2, finish

    # Check valid option (1-4)
    blt $a0, 1, vending_loop
    bgt $a0, 4, vending_loop

    # Call vend_item function
    la $a1, prices         
    la $a2, balance         
    jal vend_item
    j vending_loop

finish:
    # Print final balance
    li $v0, 4
    la $a0, final
    syscall

    # Load balance (float) and print
    la $t0, balance
    l.s $f12, 0($t0)      # $f12 = final balance
    li $v0, 2             # print float
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall

vend_item:
    # Get price
    addi $t0, $a0, -1
    sll $t0, $t0, 2
    add $t1, $a1, $t0
    l.s $f2, 0($t1)         

    # Load current balance
    l.s $f4, 0($a2)          

    # If enough balance, subtract price
    c.lt.s $f4, $f2          # if balance < price
    bc1t not_enough_balance

    sub.s $f4, $f4, $f2      # balance -= price
    s.s $f4, 0($a2)          # store new balance
    jr $ra

not_enough_balance:
    # Print not enough balance message
    li $v0, 4
    la $a0, notbalance
    syscall
    jr $ra
