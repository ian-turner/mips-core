# ------------------------------------------
# Interacting with IO using memory-mapped IO
#
# Switch value should appear on hex segments
# and btn values should appear on LEDs
# ------------------------------------------

# -- Loading addresses --
addi $1, $0, 0x400		# hex
addi $2, $0, 0x404		# switch
addi $3, $0, 0x408		# btnC
addi $4, $0, 0x40C		# btnU
addi $5, $0, 0x410		# btnL
addi $6, $0, 0x414		# btnR
addi $7, $0, 0x418		# btnD
addi $8, $0, 0x41C		# led

# -- Inifinitely looping --
Loop:

lw $16, 0($2)			# loading switch value
sw $16, 0($1)			# writing switch value to hex segments

lw $16, 0($3)			# loading btnC value
sll $16, $16, 1			# shift left to make room for next led
lw $17, 0($4)			# btnU
add $16, $16, $17
sll $16, $16, 1			
lw $17, 0($5)			# btnL
add $16, $16, $17
sll $16, $16, 1			
lw $17, 0($6)			# btnR
add $16, $16, $17
sll $16, $16, 1			
lw $17, 0($7)			# btnD
add $16, $16, $17

sw $16, 0($8)			# writing button values to leds

j Loop
