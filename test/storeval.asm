
# -- Loading addresses --
addi $1, $0, 0x400			# hex
addi $2, $0, 0x408			# btnC
addi $3, $0, 0x404			# switch


addi $4, $0, 1 				# storing constant 1

# -- Inifinite loop --
Loop:

lw $5, 0($2)				# loading button value
beq $4, $5, Store			# jump to store function if button is pressed

j Loop


# -- Storing value of switch to hex display --
Store:

lw $6, 0($3)
sw $6, 0($1)

j Loop