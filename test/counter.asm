
# -- Loading addresses --
addi $1, $0, 0x400		# hex
addi $2, $0, 0x408		# btnC


# loading `1 millisecond' constant
addi $3, $0, 0x186
sll $3, $3, 8
addi $3, $3, 0xA0


# counter
addi $4, $0, 0

Loop:

addi $4, $4, 1
srl $5, $4, 16
sw $5, 0($1)

j Loop
