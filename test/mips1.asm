addi $1, $0, 0x400		# pushing hex address into register 1
addi $2, $0, 0x404		# pushing switch address into register 2
Loop:
lw $3, 0($2)			# loading switch value
sw $3, 0($1)			# writing switch value to hex segments
j Loop
