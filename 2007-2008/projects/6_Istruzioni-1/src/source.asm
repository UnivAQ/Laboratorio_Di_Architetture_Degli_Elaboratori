.data
	##
	# Messages
	##
	messageInsertString:	.asciiz "Inserire una stringa binaria di massimo 32 bit: "
	messageErrorCharacter:	.asciiz "Hai inserito una stringa minore di 32 bit o più caratteri non validi ('0' | '1').\n"
	messageContinue:		.asciiz "Inserire 1 per continuare, 0 per uscire: "
	messageErrorInstruction:.asciiz "<l'istruzione richiesta non è fra quelle riconosciute dallo SliMips>."
	messageTheInstructionIs:.asciiz "La stringa immessa equivale all'istruzione: "

	##
	# Instructions names
	##
	instructionNoop:	.asciiz "noop"
	instructionJr:		.asciiz "jr"
	instructionMult:	.asciiz "mult"
	instructionDiv:		.asciiz	"div"
	instructionAdd:		.asciiz "add"
	instructionSub:		.asciiz "sub"
	instructionAnd:		.asciiz	"and"
	instructionOr:		.asciiz "or"
	instructionSlt:		.asciiz "slt"
	instructionJ:		.asciiz "j"
	instructionJal: 	.asciiz "jal"
	instructionBeq:		.asciiz "beq"
	instructionBne:		.asciiz "bne"
	instructionAddi:	.asciiz "addi"
	instructionSlti:	.asciiz "slti"
	instructionAndi:	.asciiz "andi"
	instructionLb:		.asciiz "lb"
	instructionLw:		.asciiz "lw"
	instructionSb:		.asciiz "sb"
	instructionSw:		.asciiz "sw"

	##
	# Registers names
	##
	registersSet:
		.asciiz "$0 "	#.asciiz "$0\0"	# "$0 " for SPIM
		.asciiz "$at"
		.asciiz "$v0"
		.asciiz "$v1"
		.asciiz "$a0"
		.asciiz "$a1"
		.asciiz "$a2"
		.asciiz "$a3"
		.asciiz "$t0"
		.asciiz "$t1"
		.asciiz "$t2"
		.asciiz "$t3"
		.asciiz "$t4"
		.asciiz "$t5"
		.asciiz "$t6"
		.asciiz "$t7"
		.asciiz "$s0"
		.asciiz "$s1"
		.asciiz "$s2"
		.asciiz "$s3"
		.asciiz "$s4"
		.asciiz "$s5"
		.asciiz "$s6"
		.asciiz "$s7"
		.asciiz "$t8"
		.asciiz "$t9"
		.asciiz "$k0"
		.asciiz "$k1"
		.asciiz "$gp"
		.asciiz "$sp"
		.asciiz "$fp"
		.asciiz "$ra"

	##
	# Instructions vector
	##
	instructionsSet:
		.word 0		# instructions noop, jr, mult, div, add, sub, and, or, slt
			.space 4
		.word 2		# instruction j
			.space 4
		.word 3		# instruction jal
			.space 4
		.word 4		# instruction beq
			.space 4
		.word 5		# instruction bne
			.space 4
		.word 8		# instruction addi
			.space 4
		.word 10	# instruction slti
			.space 4
		.word 12	# instruction andi
			.space 4
		.word 32	# instruction lb
			.space 4
		.word 35	# instruction lw
			.space 4
		.word 40	# instruction sb
			.space 4
		.word 43	# instruction sw
			.space 4
		.word 0		# vector termination

	##
	# Sub-instructions vector
	##
	instructionsZeroSet:
		.word 0		# instruction noop
			.space 4
		.word 8		# instruction jr
			.space 4
		.word 24	# instruction mult
			.space 4
		.word 26	# instruction div
			.space 4
		.word 32	# instruction add
			.space 4
		.word 34	# instruction sub
			.space 4
		.word 36	# instruction and
			.space 4
		.word 37	# instruction or
			.space 4
		.word 42	# instruction slt
			.space 4
		.word 0		# vector termination

	hexString:
		.ascii "0x"
		.asciiz ""	# string termination for the syscall

	binaryCode:
		.word 0

.text
## <Main>
	##
	# Bootstrap stage
	##
	main:
		la $a0, instructionsSet 

		la $a1, _instructionZero
		jal setInstructionHandler
		la $a1, _instructionJ
		jal setInstructionHandler
		la $a1, _instructionJal
		jal setInstructionHandler
		la $a1, _instructionBeq
		jal setInstructionHandler
		la $a1, _instructionBne
		jal setInstructionHandler
		la $a1, _instructionAddi
		jal setInstructionHandler
		la $a1, _instructionSlti
		jal setInstructionHandler
		la $a1, _instructionAndi
		jal setInstructionHandler
		la $a1, _instructionLb
		jal setInstructionHandler
		la $a1, _instructionLw
		jal setInstructionHandler
		la $a1, _instructionSb
		jal setInstructionHandler
		la $a1, _instructionSw
		jal setInstructionHandler

	##
	# User interaction stage
	##
	main_start:
		# Prints the insertion message
		##
		la $a0, messageInsertString
		jal print_string
		##

		# Reads a string of 32 bit from the console
		##
		li $v0, 8
		addi $sp, $sp, -36
		move $a0, $sp		# stack address used for the input buffer
		li $a1, 33			# max string length (32 byte + 1 byte (term char))
		syscall
		##

		# Normalizes the string
		##
		move $a0, $sp		# string address
		jal checkString
		##

		# Saves the string address in a reserved space
		##
		la $t0, binaryCode
		sw $sp, 0($t0)
		##

		# Prints the instruction header
		##
		la $a0, messageTheInstructionIs
		jal print_string
		##

		# Dispatchs the work
		##
		move $a0, $sp		# binary string address
		li $a1, 6			# operation code length
		la $a2, instructionsSet	# instructions vector address
		jal dispatchWork
		##

	##
	# Exit stage
	##
	main_exit:
		# Terminate the execution
		##
		li $v0, 10
		syscall
		##
## </Main>

## <print_string>
	##
	# Prints a string
  	#
	# @param pointer $a0	String address
	# @return void
	##
	print_string:
		li $v0, 4
		syscall
		jr $ra
## </print_string>

## <print_integer>
	##
	# Prints an integer
  	#
	# @param integer $a0	Integer value
	# @return void
	##
	print_integer:
		li $v0, 1
		syscall
		jr $ra
## </print_integer>

## <pow>
	##
	# C-like "int pow(base, power)" function
  	#
	# @param integer $a0	Base
	# @param integer $a1	Power
	# @return integer $v0	Powered base
	##
	pow:
		li $t0, 0			# counter
		li $v0, 1

	_pow_cycle:
		# if (counter == power) _pow_cycle_end
		##
		beq $t0, $a1, _pow_cycle_end
		##
		addi $t0, $t0, 1	# ++counter
		mul $v0, $v0, $a0	# result*base
		j _pow_cycle

	_pow_cycle_end:
		jr $ra
## </pow>

## <setInstructionHandler>
	##
	# Sets an handler for the instruction
  	#
	# @param pointer $a0	Instructions set address
	# @param pointer $a1	Instruction handler address
	# @return void
	##
	setInstructionHandler:
		# 0($a0) is the operation code
		# 4($a0) is the the instruction handler address
		sw $a1, 4($a0)
		addi $a0, $a0, 8	# the next instruction
		jr $ra
## </setInstructionHandler>

## <checkString>
	##
	# Checks the string content
	#
	# @param pointer $a0	String address
	# @return void
	##
	checkString:
		add $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp) 		# $s0 is used as a counter

	_checkString_cycle:
		beq $s0, 32, _checkString_cycle_end
		jal checkString_byte
		addi $a0, $a0, 1 	# ++charPointer
		addi $s0, $s0, 1 	# ++counter
		j _checkString_cycle

	_checkString_cycle_end:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		addi $sp, $sp, 8
		jr $ra

	##
	# Checks the byte content
  	#
	# @param pointer $a0	Character address
	# @return void
	##
	checkString_byte:
		lb $t0, 0($a0)

    	# if ($t0 < 0 || $t0 > 1) _checkString_byte_error
		##
		blt $t0, 48, _checkString_byte_error
		slti $t1, $t0, 50
		beq $t1, $0, _checkString_byte_error
		##

		# $t0 from hex to dec
		##
		addi $t0, $t0, -48 	# this code should be placed here to avoid the overflow
		##

		sb $t0, 0($a0)
		jr $ra

	##
  	# Prints the wrong character message
  	#
	# @param void
	# @return void
	##
	_checkString_byte_error:
		la $a0, messageErrorCharacter
		jal print_string

	##
	# Have we continue or exit?
	##
	_checkString_byte_error_continue:
		la $a0, messageContinue
		jal print_string

		# Read a number from the console
		##
		li $v0, 5
		syscall
		##

		# Check the number: '0' to exit, '1' to insert a new string
		##
		#addi $a0, $a0, -48
		beq $v0, 0, main_exit
		beq $v0, 1, main_start
		##

		j _checkString_byte_error_continue
## </checkString>

## <convertUBinFromStringToDec>
	##
	# Converts from an unsigned binary to a decimal
  	#
	# @param pointer $a0	Binary string address
	# @param integer $a1	String length
	# @return integer $v0	Decimal value
	##
	convertUBinFromStringToDec:
		add $sp, $sp, -20
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2,12($sp)
		sw $s3,16($sp)
		add $s0, $a0, $0	# binary string address, from the most significant bit
		add $s1, $a1, $0	# string length used as a counter
		add $s2, $0,  $0	# return value
		li $a0, 2			# pow(base, ...)

	_convertUBinFromStringToDec_cycle:
		# From most to less significant bit
		##
		addi $s1, $s1, -1	# --counter
		##

		# if (counter < 0) _convertUBinFromStringToDec_cycle_end
		##
		bltz $s1, _convertUBinFromStringToDec_cycle_end
		##

		lb $s3, 0($s0)		# $s3 = '0' | '1'

		# if (bit == 0) _convertUBinFromStringToDec_cycle_next
		##
		beq $s3, $0, _convertUBinFromStringToDec_cycle_next
		##

		# Calculate the power
		##
		add $a1, $s1, $0	# pow(..., power)
		jal pow 			# $v0 = pow(base, power)
		##

		mul $t1, $s3, $v0	# $t1 = d*(b^n) = $s3*$v0
		add $s2, $s2, $t1	# summation

	_convertUBinFromStringToDec_cycle_next:
		addi $s0, $s0, 1 	# ++charPointer
		j _convertUBinFromStringToDec_cycle

	_convertUBinFromStringToDec_cycle_end:
		add $v0, $s2, $0
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2,12($sp)
		lw $s3,16($sp)
		add $sp, $sp, 20
		jr $ra
## </convertUBinFromStringToDec>

## <convertBinFromStringToDec>
	##
	# Converts from a signed binary to a decimal
  	#
	# @param pointer $a0	Binary string address, from the most significant bit
	# @param integer $a1	String length
	# @return integer $v0	Decimal value
	##
	convertBinFromStringToDec:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp)		# sign value (-1 | +1)

		li $s0, 1			# default sign is positive
		addi $a1, $a1, -1	# real string length (0...n-1 of n) (used by _convertBinFromStringToDec_unsigned)
		move $t0, $a0		# the most significant bit
		add $t1, $a0, $a1	# the less significant bit
		addi $a0, $a0, 1	# string address without the sign (used by _convertBinFromStringToDec_unsigned)
		li $t2, 0			# reset the register (used as counter by _convertBinFromStringToDec_addOne)

		# If the most significant bit is equal to zero we have in our hands an unsigned number
		##
		lb $t3, 0($t0)
		beq $t3, $0, _convertBinFromStringToDec_unsigned
		##
		li $s0, -1			# we are handling a negative number

	_convertBinFromStringToDec_complement:
		addi $t0, $t0, 1	# ++stringAddress

		lb $t3, 0($t0)
		xori $t3, $t3, 0x1	# character switch: 48 to 49 and viceversa (complementation)
		sb $t3, 0($t0)

		# if (currentAddress != stringBaseAddress) _convertBinFromStringToDec_complement
		##
		bne $t0, $t1, _convertBinFromStringToDec_complement
		##

	_convertBinFromStringToDec_addOne:
		lb $t3, 0($t0)
		xori $t3, $t3, 0x1	# increment of one
		sb $t3, 0($t0)

		addi $t2, $t2, 1
		# if (counter == realStringLength) _convertBinFromStringToDec_unsigned
		##
		beq $t2, $a1, _convertBinFromStringToDec_unsigned
		##
		addi $t0, $t0, -1
		# if (bitConverted != 0) _convertBinFromStringToDec_addOne
		##
		beq $t3, $0, _convertBinFromStringToDec_addOne
		##

	_convertBinFromStringToDec_unsigned:
		jal convertUBinFromStringToDec
		mul $v0, $v0, $s0	# adapts the returned number to the work done previously
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		addi $sp, $sp, 8
		jr $ra
## </convertBinFromStringToDec>

## <getRegisterString>
	##
	# Returns the pointer to the instruction string
  	#
	# @param integer $a0	Registry index
	# @return pointer $v0	Registry string address
	##
	getRegisterString:
		la $v0, registersSet
		li $t0, 4
		mul $t0, $a0, $t0
		add $v0, $v0, $t0
		jr $ra
## </getRegisterString>

## <getInstructionHandler>
	##
	# Checks if the operation code is recognized
	# and returns the instruction handler
  	#
	# @param pointer $a0	Instructions set address
	# @param integer $a1	Operation code
	# @return pointer $v0	Instruction handler address
	##
	getInstructionHandler:
		lw $t0, 0($a0)		# load the operation code
		bne $t0, $a1, _getInstructionHandler_next
		lw $v0, 4($a0)		# returns to the main the instruction handler address
		jr $ra

	_getInstructionHandler_next:
		# if (requested code ($a1) < current code ($t0)) _getInstructionHandler_error
		# means that there is no possibility to have $a1 in future iterations
		# because instructionsSet is ordered in crescent order
		blt $a1, $t0, _getInstructionHandler_error
		addi $a0, $a0, 8	# the next instruction
		j getInstructionHandler

	_getInstructionHandler_error:
		la $a0, messageErrorInstruction
		jal print_string
		j main_exit
## </getInstructionHandler>

## <dispatchWork>
	##
	# Dispatch the work to the instruction handler
  	#
	# @param pointer $a0	Binary string address
	# @param integer $a1	Operation code length
	# @param pointer $a2	Instruction handler address
	# @return void
	##
	dispatchWork:
		addi $sp, $sp, -16
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2,12($sp)

		move $s0, $a0		# binary string address
		move $s1, $a1		# operation code length
		move $s2, $a2		# instructions vector address

		# Convert the operation code string to a decimal (ex. from '010010' to 18)
		##
		#move $a0, $s0		# binary string address
		#move $a1, $s1		# operation code length
		jal convertUBinFromStringToDec
		##

		# Checks if the requested operation code is recognized by the SliMips
		# and returns the instruction handler
		##
		move $a0, $s2		# instructions vector address
		move $a1, $v0		# requested operation code
		jal getInstructionHandler
		##

		# Dispatch the work
		##
		jalr $v0
		##

		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2,12($sp)
		addi $sp, $sp, 16
		jr $ra
## </dispatchWork>

## <InstructionsHandlers>
	##
	# This procedure handles the '000000' operation code
	##
	_instructionZero:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		la $a0, instructionsZeroSet
 
		la $a1, _instructionNoop
		jal setInstructionHandler
		la $a1, _instructionJr
		jal setInstructionHandler
		la $a1, _instructionMult
		jal setInstructionHandler
		la $a1, _instructionDiv
		jal setInstructionHandler
		la $a1, _instructionAdd
		jal setInstructionHandler
		la $a1, _instructionSub
		jal setInstructionHandler
		la $a1, _instructionAnd
		jal setInstructionHandler
		la $a1, _instructionOr
		jal setInstructionHandler
		la $a1, _instructionSlt
		jal setInstructionHandler

		la $a0, binaryCode
		lw $a0, 0($a0)
		addi $a0, $a0, 26
		li $a1, 6
		la $a2, instructionsZeroSet	# instructions vector address
		jal dispatchWork

		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionJ_abstract:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal print_string
		jal print_space
		jal print_immediate_hex
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionJ:
		la $a0, instructionJ
		j _instructionJ_abstract

	_instructionJal:
		la $a0, instructionJal
		j _instructionJ_abstract

	_instructionB_abstract:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal print_string
		jal print_space
		jal print_register_one
		jal print_separator
		jal print_register_two
		jal print_separator
		jal print_immediate
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionBeq:
		la $a0, instructionBeq
		j _instructionB_abstract

	_instructionBne:
		la $a0, instructionBne
		j _instructionB_abstract

	_instructionI_abstract:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal print_string
		jal print_space
		jal print_register_two
		jal print_separator
		jal print_register_one
		jal print_separator
		jal print_immediate
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionAddi:
		la $a0, instructionAddi
		j _instructionI_abstract

	_instructionSlti:
		la $a0, instructionSlti
		j _instructionI_abstract

	_instructionAndi:
		la $a0, instructionAndi
		j _instructionI_abstract

	_instructionRri_abstract:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal print_string
		jal print_space
		jal print_register_two
		jal print_separator
		jal print_immediate
		# Prints the '(' character
		##
		li $a0, 40
		li $v0, 11
		syscall
		##
		jal print_register_one
		# Prints the ')' character
		##
		li $a0, 41
		li $v0, 11
		syscall
		##
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionLb:
		la $a0, instructionLb
		j _instructionRri_abstract

	_instructionLw:
		la $a0, instructionLw
		j _instructionRri_abstract

	_instructionSb:
		la $a0, instructionSb
		j _instructionRri_abstract

	_instructionSw:
		la $a0, instructionSw
		j _instructionRri_abstract

	_instructionNoop:
		la $a0, instructionNoop
		jal print_string
		j main_exit

	_instructionJr:
		la $a0, instructionJr
		jal print_string
		jal print_space
		jal print_register_one
		j main_exit

	_instructionRr_abstract:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal print_string
		jal print_space
		jal print_register_one
		jal print_separator
		jal print_register_two
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionMult:
		la $a0, instructionMult
		j _instructionRr_abstract

	_instructionDiv:
		la $a0, instructionDiv
		j _instructionRr_abstract

	_instructionRrr_abstract:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal print_string
		jal print_space
		jal print_register_three
		jal print_separator
		jal print_register_one
		jal print_separator
		jal print_register_two
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_instructionAdd:
		la $a0, instructionAdd
		j _instructionRrr_abstract

	_instructionSub:
		la $a0, instructionSub
		j _instructionRrr_abstract

	_instructionAnd:
		la $a0, instructionAnd
		j _instructionRrr_abstract

	_instructionOr:
		la $a0, instructionOr
		j _instructionRrr_abstract

	_instructionSlt:
		la $a0, instructionSlt
		j _instructionRrr_abstract
## </InstructionsHandlers>

# Output facilities
## <print_*>
	##
	# Prints the space character
	##
	print_space:
		li $a0, 32
		li $v0, 11
		syscall
		jr $ra

	##
	# Prints the registers separator (', ')
	##
	print_separator:
		li $a0, 44
		li $v0, 11
		syscall
		li $a0, 32
		li $v0, 11
		syscall
		jr $ra

	print_immediate:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		la $a0, binaryCode
		lw $a0, 0($a0)
		addi $a0, $a0, 16
		li $a1, 16
		jal convertBinFromStringToDec
		move $a0, $v0
		li $v0, 1
		syscall
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	##
	# Code taken from the Professor Henry Muccini's site
	##
	print_immediate_hex:
		addi $sp, $sp, -4
		sw $ra, 0($sp)

		la $a0, binaryCode
		lw $a0, 0($a0)
		addi $a0, $a0, 6

		li $a1, 26
		jal convertUBinFromStringToDec
		move $t2, $v0

		li $t0,8            # number of hex digits to print
		la $t3, hexString	# load the address of the string
		addi $t3, $t3, 2	# move pointer to not overwrite "0x"

	_convertFromDecToHex_loop:
		rol $t2, $t2, 4		# begin with leftmost digit
		and $t1, $t2, 0xf	# mask one digit
		ble $t1, 9, _convertFromDecToHex_generateAsciiFromHex	# check if between 0 and 9
		add $t1, $t1, 7     # there are 7 chars between '9' and 'A'

	_convertFromDecToHex_generateAsciiFromHex:
		addi $t1, $t1, 48	# ASCII '0' is 48
		sb $t1, 0($t3)		# save hex value in string
		addi $t3, $t3, 1	# advance the pointer
		addi $t0, $t0, -1	# decrement the counter
		bnez $t0, _convertFromDecToHex_loop

		sb $0, 0($t3)		# insert the string terminator

		la $t3, hexString	# print the Hex value
		move $a0, $t3
		li $v0, 4
		syscall

		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	_print_register:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal convertUBinFromStringToDec
		move $a0, $v0
		jal getRegisterString
		move $a0, $v0
		jal print_string
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	print_register_one:
		la $a0, binaryCode
		lw $a0, 0($a0)
		addi $a0, $a0, 6
		li $a1, 5
		j _print_register

	print_register_two:
		la $a0, binaryCode
		lw $a0, 0($a0)
		addi $a0, $a0, 11
		li $a1, 5
		j _print_register

	print_register_three:
		la $a0, binaryCode
		lw $a0, 0($a0)
		addi $a0, $a0, 16
		li $a1, 5
		j _print_register
## </print_*>

