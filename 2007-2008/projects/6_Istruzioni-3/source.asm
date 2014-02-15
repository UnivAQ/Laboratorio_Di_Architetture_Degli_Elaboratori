#################
# Segmento dati #
#################
.data

input: 
		.asciiz "Inserire un codice binario m ---> "
strlenerr: 
		.asciiz "\n!!! ERRORE !!! Codice binario non lungo 32 bit quindi non conforme al MIPS !!!\n"
strfunzerr:
		.asciiz "\n!!! ERRORE !!! Istruzione di tipo formato R ma con valore funzione errata !!!\n"
strshamterr:
		.asciiz "\n!!! ERRORE !!! Istruzione con codice Shamt <> 0 !!!\n"
strregerr:
		.asciiz "\n!!! ERRORE !!! Istruzione con valore registro errato !!!\n"
strcarerr: 
		.asciiz "\n!!! ERRORE !!! Codice di tipo non binario (contiene caratteri diversi da 0 e 1) quindi non valido per il MIPS !!!\n"
stropcerr:
		.asciiz "\n!!! ERRORE !!! Istruzione con codice operativo non valido !!!\n"
newline:
		.asciiz "\n"
comma:
		.asciiz ","
pars:
		.asciiz "("
pard:
		.asciiz ")"
czero:
		.ascii "0"
cuno:
		.ascii "1"

registri:	.word r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25 ,r26, r27, r28,  r29, r30, r31
r0:		.asciiz "$zero"
r1:		.asciiz "$at"
r2:		.asciiz "$v0"
r3:		.asciiz "$v1"
r4:		.asciiz	"$a0"
r5:		.asciiz "$a1"
r6:		.asciiz "$a2"
r7:		.asciiz "$a3"
r8:		.asciiz "$t0"
r9:		.asciiz "$t1"
r10:		.asciiz "$t2"
r11:		.asciiz "$t3"
r12:		.asciiz "$t4"
r13:		.asciiz "$t5"
r14:		.asciiz "$t6"
r15:		.asciiz	"$t7"
r16:		.asciiz "$s0"
r17:		.asciiz "$s1"
r18:		.asciiz "$s2"
r19:		.asciiz "$s3"
r20:		.asciiz "$s4"
r21:		.asciiz "$s5"
r22:		.asciiz "$s6"
r23:		.asciiz "$s7"
r24:		.asciiz "$t8"
r25:		.asciiz "$t9"
r26:		.asciiz "$k0"
r27:		.asciiz "$k1"
r28:		.asciiz "$gp"
r29:		.asciiz "$sp"
r30:		.asciiz "$fp"
r31:		.asciiz "$ra"

opcode:		.word  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 43, 46, -1
switchother:	.word R0, I6, R0, R0, I1, I1, I2, I2, I3, I3, I3, I3, I4, I4, I4, I5, I1, I1, I2, I2, I3, I3, I3, I3, I4, I4, I3, I3, I3, I3, I3, I3
printother:	.word P2,OP1,OP0,OP0, P3, P3,OP2,OP2, P3, P3, P3, P3, P3, P3, P3,OP2, P3, P3,OP2,OP2,OP1,OP1,OP1,OP1,OP1,OP1,OP1,OP1,OP1,OP1,OP1,OP1

branch1:	.word  0,  1,  2,  3, 16, 17, 18, 19, -1
printbranch1:	.word r0, r1, r2, r3,r16,r17,r18,r19

functr:		.word  0,  2,  3,  4,  6,  7,  8,  9, 10, 11, 12, 13, 16, 17, 18, 19, 24, 25, 26, 27, 32, 33, 34, 35, 36, 37, 38, 39, 42, 43, -1
switchr:	.word R3, R3, R3, R2, R2, R2, R1, R1, R0, R0, R7, R7, R5, R6, R5, R6, R4, R4, R4, R4, R0, R0, R0, R0, R0, R0, R0, R0, R0, R0
printr:		.word P3, P3, P3, P2, P2, P2, P1, P1, P2, P2, RP, RP, P1, P1, P1, P1, P4, P4, P4, P4, P2, P2, P2, P2, P2, P2, P2, P2, P2, P2

formattype:	.word formator, formatoi, formatoj, formatoj, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi, formatoi

instructionsbranch1:	.word i_bltz, i_bgez, i_bltzl, i_bgezl, i_bltzal, i_bgezal, i_bltzall, i_bgezall
i_bltz:		.asciiz "bltz "				#
i_bgez:		.asciiz "bgez "				#
i_bltzl:	.asciiz "bltzl "			#
i_bgezl:	.asciiz "bgezl "			#
i_bltzal:	.asciiz "bltzal "			#
i_bgezal:	.asciiz "bgezal "			#
i_bltzall:	.asciiz "bltzall "			#
i_bgezall:	.asciiz "bgezall "			#

instructionsreg:.word i_sll, i_srl, i_sra, i_sllv, i_srlv, i_srav, i_jr, i_jalr, i_movz, i_movn, i_syscall, i_break, i_mfhi, i_mthi, i_mflo, i_mtlo, i_mult, i_multu, i_div, i_divu, i_add, i_addu, i_sub, i_subu, i_and, i_or, i_xor, i_nor, i_slt, i_sltu
i_sll:		.asciiz "sll "				#
i_srl:		.asciiz "srl "				#
i_sra:		.asciiz "sra "				#
i_sllv:		.asciiz "sllv "				#
i_srlv:		.asciiz "srlv "				#
i_srav:		.asciiz "srav "				#
i_jr:		.asciiz "jr "				#
i_jalr:		.asciiz	"jalr "				#
i_movz:		.asciiz "movz "				#
i_movn:		.asciiz "movn "				#
i_syscall:	.asciiz "syscall"			#
i_break:	.asciiz "break"				#
i_mfhi:		.asciiz "mfhi "				#
i_mthi:		.asciiz "mthi "				#
i_mflo:		.asciiz "mflo "				#
i_mtlo:		.asciiz "mtlo "				#
i_mult:		.asciiz "mult "				#
i_multu:	.asciiz "multu "			#
i_div:		.asciiz "div "				#
i_divu:		.asciiz "divu "				#
i_add:		.asciiz "add "				#
i_addu:		.asciiz "addu "				#
i_sub:		.asciiz "sub "				#
i_subu:		.asciiz "subu "				#
i_and:		.asciiz "and "				#
i_or:		.asciiz "or "				#
i_xor:		.asciiz "xor "				#
i_nor:		.asciiz "nor "				#
i_slt:		.asciiz "slt "				#
i_sltu:		.asciiz "sltu "				#

instructions:	.word i_0, i_1, i_j, i_jal, i_beq, i_bne, i_blez, i_bgtz, i_addi, i_addiu, i_slti, i_sltiu, i_andi, i_ori, i_xori, i_lui, i_beql, i_bnel, i_blezl, i_bgtzl, i_lb, i_lh, i_lwl, i_lw, i_lbu, i_lhu, i_lwr, i_sb, i_sh, i_swl, i_sw, i_swr 
i_0:		.asciiz ""				#
i_1:		.asciiz ""				#
i_j:		.asciiz "j "				#
i_jal:		.asciiz "jal "				#
i_beq:		.asciiz "beq "				#
i_bne:		.asciiz "bne "				#
i_blez:		.asciiz "blez "				#
i_bgtz:		.asciiz "bgtz "				#
i_addi:		.asciiz "addi "				#
i_addiu:	.asciiz "addiu "			#
i_slti:		.asciiz "slti "				#
i_sltiu:	.asciiz "sltiu "			#
i_andi:		.asciiz "andi "				#
i_ori:		.asciiz "ori "				#
i_xori:		.asciiz "xori "				#
i_lui:		.asciiz "lui "				#
i_beql:		.asciiz "beql "				#
i_bnel:		.asciiz "bnel "				#
i_blezl:	.asciiz "blezl "			#
i_bgtzl:	.asciiz "bgtzl "			#
i_lb:		.asciiz "lb "				#
i_lh:		.asciiz "lh "				#
i_lwl:		.asciiz "lwl "				#
i_lw:		.asciiz "lw "				#
i_lbu:		.asciiz "lbu "				#
i_lhu:		.asciiz "lhu "				#
i_lwr:		.asciiz "lwr "				#
i_sb:		.asciiz "sb "				#
i_sh:		.asciiz "sh "				#
i_swl:		.asciiz "swl "				#
i_sw:		.asciiz "sw "				#
i_swr:		.asciiz "swr "				#

str:
#			 01234567890123456789012345678901

#		.asciiz "                                " # corrisponde a 32 spazi con NULL finale
#		.asciiz "00000011100100111000111111000000" # corrisponde a sll $s1, $s3, 31 ERRATA rd presente	opcode = 0 e funct = 0
#		.asciiz "00000010010100111000100000101100" # corrisponde a FUNZIONE ERRATA 			opcode = 0 e funct = 44
#		.asciiz "00000010010100111000100001101010" # corrisponde a slt ma con Shamt ERRATO		opcode = 0 e funct = 42
#		.asciiz	"00000001001000111000000000001000" # corrisponde a jr $t1 ma con registro rt e quindi ERopcode = 0 e funct = 8
#		.asciiz "11111111111111111111111111111111" # non corrisponde a nessuna istruzione valida
#		.asciiz "111111111111111111111111111111111111" # troppo lunga
#		.asciiz "111111" # troppo corta


#  FORMATO R sll     	 00000000000tttttdddddhhhhh000000   sll d, t, h		con 0<=h<32	opcode = 0 e funct = 0
#  FORMATO R srl     	 00000000000tttttdddddhhhhh000010   srl d, t, h		con 0<=h<32 	opcode = 0 e funct = 2
#  FORMATO R sra     	 00000000000tttttdddddhhhhh000011   sra d, t, h		con 0<=h<32 	opcode = 0 e funct = 3

#  FORMATO R sllv     	 000000ssssstttttddddd00000000100   sllv d, t, s			opcode = 0 e funct = 4
#  FORMATO R srlv     	 000000ssssstttttddddd00000000110   srlv d, t, s			opcode = 0 e funct = 6
#  FORMATO R srav     	 000000ssssstttttddddd00000000111   srav d, t, s	 		opcode = 0 e funct = 7

#  FORMATO R jr		 000000sssss000000000000000001000   jr s				opcode = 0 e funct = 8
#  FORMATO R jalr	 000000sssss000000000000000001001   jalr s				opcode = 0 e funct = 9
#  FORMATO R jalr	 000000sssss00000ddddd00000001001   jalr s, d				opcode = 0 e funct = 9

#  FORMATO R syscall	 000000cccccccccccccccccccc001100   syscall				opcode = 0 e funct = 12
#  FORMATO R break	 000000cccccccccccccccccccc001101   break				opcode = 0 e funct = 13

#  FORMATO R mfhi	 0000000000000000ddddd00000010000   mfhi d				opcode = 0 e funct = 16
#  FORMATO R mflo	 0000000000000000ddddd00000010010   mflo d				opcode = 0 e funct = 18

#  FORMATO R mthi	 000000sssss000000000000000010001   mthi s				opcode = 0 e funct = 17
#  FORMATO R mtlo	 000000sssss000000000000000010011   mtlo s				opcode = 0 e funct = 19

#  FORMATO R mult	 000000sssssttttt0000000000011000   mult s, t				opcode = 0 e funct = 24
#  FORMATO R multu	 000000sssssttttt0000000000011001   multu s, t				opcode = 0 e funct = 25
#  FORMATO R div	 000000sssssttttt0000000000011010   div s, t				opcode = 0 e funct = 26
#  FORMATO R divu	 000000sssssttttt0000000000011011   divu s, t				opcode = 0 e funct = 27

#  FORMATO R movz	 000000ssssstttttddddd00000001010   movz d, s, t			opcode = 0 e funct = 10
#  FORMATO R movn	 000000ssssstttttddddd00000001011   movn d, s, t			opcode = 0 e funct = 11
#  FORMATO R add	 000000ssssstttttddddd00000100000   add d, s, t				opcode = 0 e funct = 32
#  FORMATO R addu	 000000ssssstttttddddd00000100001   addu d, s, t			opcode = 0 e funct = 33
#  FORMATO R sub	 000000ssssstttttddddd00000100010   sub d, s, t				opcode = 0 e funct = 34
#  FORMATO R subu	 000000ssssstttttddddd00000100011   subu d, s, t			opcode = 0 e funct = 35
#  FORMATO R and	 000000ssssstttttddddd00000100100   and d, s, t				opcode = 0 e funct = 36
#  FORMATO R or		 000000ssssstttttddddd00000100101   or d, s, t				opcode = 0 e funct = 37
#  FORMATO R xor	 000000ssssstttttddddd00000100110   xor d, s, t				opcode = 0 e funct = 38
#  FORMATO R nor	 000000ssssstttttddddd00000100111   nor d, s, t				opcode = 0 e funct = 39
#  FORMATO R slt	 000000ssssstttttddddd00000101010   slt d, s, t				opcode = 0 e funct = 42
#  FORMATO R sltu	 000000ssssstttttddddd00000101011   sltu d, s, t			opcode = 0 e funct = 43

#  FORMATO I bltz     	 000001sssss00000iiiiiiiiiiiiiiii   bltz s, offset			opcode = 1 e rt = 0
#  FORMATO I bgez     	 000001sssss00001iiiiiiiiiiiiiiii   bgez s, offset			opcode = 1 e rt = 1
#  FORMATO I bltzl    	 000001sssss00010iiiiiiiiiiiiiiii   bltzl s, offset			opcode = 1 e rt = 2
#  FORMATO I bgezl     	 000001sssss00011iiiiiiiiiiiiiiii   bgez s, offset			opcode = 1 e rt = 3
#  FORMATO I bltzal    	 000001sssss10000iiiiiiiiiiiiiiii   bltzal s, offset			opcode = 1 e rt = 16
#  FORMATO I bgezal    	 000001sssss10001iiiiiiiiiiiiiiii   bgezal s, offset			opcode = 1 e rt = 17
#  FORMATO I bltzall   	 000001sssss10010iiiiiiiiiiiiiiii   bltzall s, offset			opcode = 1 e rt = 18
#  FORMATO I bgezall   	 000001sssss10011iiiiiiiiiiiiiiii   bgezall s, offset			opcode = 1 e rt = 19

#  FORMATO J j		 000010---------address----------   j address x 4			opcode = 2
#  FORMATO J jal	 000011---------address----------   jal address x 4			opcode = 3

#  FORMATO I beq	 000100ssssstttttiiiiiiiiiiiiiiii   beq s, t, offset			opcode = 4
#  FORMATO I bne     	 000101ssssstttttiiiiiiiiiiiiiiii   bne s, t, offset			opcode = 5
#  FORMATO I beql	 010100ssssstttttiiiiiiiiiiiiiiii   beql s, t, offset			opcode = 20
#  FORMATO I bnel	 010101ssssstttttiiiiiiiiiiiiiiii   bnel s, t, offset			opcode = 21

#  FORMATO I blez     	 000110sssss00000iiiiiiiiiiiiiiii   blez s, offset			opcode = 6
#  FORMATO I bgtz	 000111sssss00000iiiiiiiiiiiiiiii   bgtz s, offset			opcode = 7
#  FORMATO I blezl	 010110sssss00000iiiiiiiiiiiiiiii   blezl s, offset			opcode = 22
#  FORMATO I bgtzl	 010111sssss00000iiiiiiiiiiiiiiii   bgtzl s, offset			opcode = 23

# FORMATO I addi         001000ssssstttttiiiiiiiiiiiiiiii   addi t, s, offset			opcode = 8
# FORMATO I addiu        001001ssssstttttiiiiiiiiiiiiiiii   addiu t, s, offset			opcode = 9
# FORMATO I slti	 001010ssssstttttiiiiiiiiiiiiiiii   slti t, s, offset			opcode = 10
# FORMATO I sltiu	 001011ssssstttttiiiiiiiiiiiiiiii   sltiu t, s, offset			opcode = 11
# FORMATO I andi	 001100ssssstttttiiiiiiiiiiiiiiii   andi t, s, offset			opcode = 12
# FORMATO I ori		 001101ssssstttttiiiiiiiiiiiiiiii   ori t, s, offset			opcode = 13
# FORMATO I xori	 001110ssssstttttiiiiiiiiiiiiiiii   xori t, s, offset			opcode = 14

# FORMATO I lui		 00111100000tttttiiiiiiiiiiiiiiii   lui t, offset			opcode = 15

# FORMATO I lb		 100000ssssstttttiiiiiiiiiiiiiiii   lb t, offset(s)			opcode = 32
# FORMATO I lh		 100001ssssstttttiiiiiiiiiiiiiiii   lh t, offset(s)			opcode = 33
# FORMATO I lwl		 100010ssssstttttiiiiiiiiiiiiiiii   lwl t, offset(s)			opcode = 34
# FORMATO I lw		 100011ssssstttttiiiiiiiiiiiiiiii   lw t, offset(s)			opcode = 35
# FORMATO I lbu		 100100ssssstttttiiiiiiiiiiiiiiii   lbu t, offset(s)			opcode = 36
# FORMATO I lhu		 100101ssssstttttiiiiiiiiiiiiiiii   lhu t, offset(s)			opcode = 37
# FORMATO I lwr		 100110ssssstttttiiiiiiiiiiiiiiii   lwr t, offset(s)			opcode = 38
# FORMATO I sb		 101000ssssstttttiiiiiiiiiiiiiiii   sb t, offset(s)			opcode = 40
# FORMATO I sh		 101001ssssstttttiiiiiiiiiiiiiiii   sh t, offset(s)			opcode = 41
# FORMATO I swl		 101010ssssstttttiiiiiiiiiiiiiiii   swl t, offset(s)			opcode = 42
# FORMATO I sw		 101011ssssstttttiiiiiiiiiiiiiiii   sw t, offset(s)			opcode = 43
# FORMATO I swr		 101110ssssstttttiiiiiiiiiiiiiiii   swr t, offset(s)			opcode = 46

#	.asciiz "00000000000000000000000000000000" # corrisponde a sll $zero, $zero, 0 			opcode = 0 e funct = 0
#	.asciiz "00000000000100111000111111000000" # corrisponde a sll $s1, $s3, 31 			opcode = 0 e funct = 0
#	.asciiz "00000000000100111000100000000010" # corrisponde a srl $s1, $s3, 0 			opcode = 0 e funct = 2
#	.asciiz "00000000000100111000100111000011" # corrisponde a sra $s1, $s3, 7 			opcode = 0 e funct = 3

#	.asciiz "00000010010100111000100000000100" # corrisponde a sllv $s1, $s3, $s2 			opcode = 0 e funct = 4
#	.asciiz "00000010010100111000100000000110" # corrisponde a srlv $s1, $s3, $s2 			opcode = 0 e funct = 6
#	.asciiz "00000010010100111000100000000111" # corrisponde a srav $s1, $s3, $s2 			opcode = 0 e funct = 7

#	.asciiz	"00000001001000000000000000001000" # corrisponde a jr $t1				opcode = 0 e funct = 8
#	.asciiz	"00000001010000000000000000001001" # corrisponde a jalr $t2				opcode = 0 e funct = 9
#	.asciiz	"00000001010000001111100000001001" # corrisponde a jalr $t2, $ra			opcode = 0 e funct = 9

#	.asciiz	"00000000000000000000000000001100" # corrisponde a syscall				opcode = 0 e funct = 12
#	.asciiz	"00000000000000000000000000001101" # corrisponde a break				opcode = 0 e funct = 13

#	.asciiz	"00000000000000000100100000010000" # corrisponde a mfhi $t1				opcode = 0 e funct = 16
#	.asciiz	"00000001001000000000000000010001" # corrisponde a mthi $t1				opcode = 0 e funct = 17
#	.asciiz	"00000000000000000101000000010010" # corrisponde a mflo $t2				opcode = 0 e funct = 18
#	.asciiz	"00000001010000000000000000010011" # corrisponde a mtlo $t2				opcode = 0 e funct = 19

#	.asciiz "00000010010100110000000000011000" # corrisponde a mult $s2, $s3 			opcode = 0 e funct = 24
#	.asciiz "00000010010100110000000000011001" # corrisponde a multu $s2, $s3 			opcode = 0 e funct = 25
#	.asciiz "00000010010100110000000000011010" # corrisponde a div $s2, $s3 			opcode = 0 e funct = 26
#	.asciiz "00000010010100110000000000011011" # corrisponde a divu $s2, $s3 			opcode = 0 e funct = 27

#	.asciiz "00000010010100111000100000001010" # corrisponde a movz $s1, $s2, $s3 			opcode = 0 e funct = 10
#	.asciiz "00000010010100111000100000001011" # corrisponde a movn $s1, $s2, $s3 			opcode = 0 e funct = 11
#	.asciiz "00000010010100111000100000100000" # corrisponde a add $s1, $s2, $s3 			opcode = 0 e funct = 32
#	.asciiz "00000010010100111000100000100001" # corrisponde a addu $s1, $s2, $s3 			opcode = 0 e funct = 33
#	.asciiz "00000010010100111000100000100010" # corrisponde a sub $s1, $s2, $s3 			opcode = 0 e funct = 34
#	.asciiz "00000010010100111000100000100011" # corrisponde a subu $s1, $s2, $s3 			opcode = 0 e funct = 35
#	.asciiz "00000010010100111000100000100100" # corrisponde a and $s1, $s2, $s3 			opcode = 0 e funct = 36
#	.asciiz "00000010010100111000100000100101" # corrisponde a or $s1, $s2, $s3 			opcode = 0 e funct = 37
#	.asciiz "00000010010100111000100000100110" # corrisponde a xor $s1, $s2, $s3 			opcode = 0 e funct = 38
#	.asciiz "00000010010100111000100000100111" # corrisponde a nor $s1, $s2, $s3 			opcode = 0 e funct = 39
#	.asciiz "00000010010100111000100000101010" # corrisponde a slt $s1, $s2, $s3			opcode = 0 e funct = 42
#	.asciiz "00000010010100111000100000101011" # corrisponde a sltu $s1, $s2, $s3			opcode = 0 e funct = 43

#	.asciiz "00000110011000000000000000011001" # corrisponde a bltz $s3, 100 in bin = 25 word	opcode = 1 e rt = 0
#	.asciiz "00000110010000001111111110011100" # corrisponde a bltz $s2, -400 in bin = -100 word	opcode = 1 e rt = 0
#	.asciiz "00000110011000010000000000011001" # corrisponde a bgez $s3, 100 in bin = 25 word	opcode = 1 e rt = 1
#	.asciiz "00000110010000011111111110011100" # corrisponde a bgez $s2, -400 in bin = -100 word	opcode = 1 e rt = 1
#	.asciiz "00000110011000100000000000011001" # corrisponde a bltzl $s3, 100 in bin = 25 word	opcode = 1 e rt = 2
#	.asciiz "00000110010000101111111110011100" # corrisponde a bltzl $s2, -400 in bin = -100 word	opcode = 1 e rt = 2
#	.asciiz "00000110011000110000000000011001" # corrisponde a bgezl $s3, 100 in bin = 25 word	opcode = 1 e rt = 3
#	.asciiz "00000110010000111111111110011100" # corrisponde a bgezl $s2, -400 in bin = -100 word	opcode = 1 e rt = 3
#	.asciiz "00000110011100000000000000011001" # corrisponde a bltzal $s3, 100 in bin = 25 word	opcode = 1 e rt = 16
#	.asciiz "00000110010100001111111110011100" # corrisponde a bltzal $s2, -400 in bin = -100 word	opcode = 1 e rt = 16
#	.asciiz "00000110011100010000000000011001" # corrisponde a bgezal $s3, 100 in bin = 25 word	opcode = 1 e rt = 17
#	.asciiz "00000110010100011111111110011100" # corrisponde a bgezal $s2, -400 in bin = -100 word	opcode = 1 e rt = 17
#	.asciiz "00000110011100100000000000011001" # corrisponde a bltzall $s3, 100 in bin = 25 word	opcode = 1 e rt = 18
#	.asciiz "00000110010100101111111110011100" # corrisponde a bltzall $s2, -400 in bin = -100 word	opcode = 1 e rt = 18
#	.asciiz "00000110011100110000000000011001" # corrisponde a bgezall $s3, 100 in bin = 25 word	opcode = 1 e rt = 19
#	.asciiz "00000110010100111111111110011100" # corrisponde a bgezall $s2, -400 in bin = -100 word	opcode = 1 e rt = 19

#	.asciiz "00001000000000000000100111000100" # corrisponde a j 10000  in bin = 2500 word		opcode = 2
#	.asciiz "00001100000000000000100111000100" # corrisponde a jal 10000 in bin = 2500 word		opcode = 3

#	.asciiz "00010010001100100000000000011001" # corrisponde a beq $s1, $s2, 100 in bin = 25 word	opcode = 4
#	.asciiz "00010010001100101111111110011100" # corrisponde a beq $s1, $s2, -400 in bin =-100 word	opcode = 4
#	.asciiz "00010110001100100000000000011001" # corrisponde a bne $s1, $s2, 100 in bin = 25 word   opcode = 5
#	.asciiz "00010110001100101111111110011100" # corrisponde a bne $s1, $s2, -400 in bin = 100 word	opcode = 5
#	.asciiz "01010010001100101111111110011100" # corrisponde a beql $s1, $s2, -400 in bin = 100 	opcode = 20
#	.asciiz "01010010001100101111111110011100" # corrisponde a beql $s1, $s2, -400 in bin = 100 	opcode = 20
#	.asciiz "01010110001100101111111110011100" # corrisponde a bnel $s1, $s2, -400 in bin = 100 	opcode = 21
#	.asciiz "01010110001100101111111110011100" # corrisponde a bnel $s1, $s2, -400 in bin = 100 	opcode = 21

#	.asciiz "00011010001000000000000000011001" # corrisponde a blez $s1, 100 in bin = 25 word	opcode = 6
#	.asciiz "00011010001000001111111110011100" # corrisponde a blez $s1, -400 in bin = 100 word     opcode = 6
#	.asciiz "00011110001000000000000000011001" # corrisponde a bgtz $s1, 100 in bin = 25 word	opcode = 7
#	.asciiz "00011110001000001111111110011100" # corrisponde a bgtz $s1, -400 in bin = 100 word     opcode = 7
#	.asciiz "01011010001000000000000000011001" # corrisponde a blezl $s1, 100 in bin = 25 word	opcode = 22
#	.asciiz "01011010001000001111111110011100" # corrisponde a blezl $s1, -400 in bin = 100 word    opcode = 22
#	.asciiz "01011110001000000000000000011001" # corrisponde a bgtzl $s1, 100 in bin = 25 word	opcode = 23
#	.asciiz "01011110001000001111111110011100" # corrisponde a bgtzl $s1, -400 in bin = 100 word    opcode = 23

#	.asciiz "00100010001100100000000001100100" # corrisponde a addi $s2, $s1, 100 in bin = 100 byte opcode = 8
#	.asciiz "00100010001100101111111110011100" # corrisponde a addi $s2, $s1, -100 in bin = 100 byteopcode = 8
#	.asciiz "00100110001100100000000001100100" # corrisponde a addiu $s2, $s1, 100 in bin = 100 byte opcode = 9
#	.asciiz "00100110001100101111111110011100" # corrisponde a addiu $s2, $s1, -100 in bin = 100 byteopcode = 9
#	.asciiz "00101010001100100000000000011001" # corrisponde a slti $s2, $s1, 25 in bin = 25 byte   opcode = 10
#	.asciiz "00101010001100101111111111100111" # corrisponde a slti $s2, $s1, -25 in bin = 25 byte  opcode = 10
#	.asciiz "00101110001100100000000000011001" # corrisponde a sltiu $s2, $s1, 25 in bin = 25 byte  opcode = 11
	.asciiz "00101110001100101111111110011100" # corrisponde a sltiu $s2, $s1, -100 in bin = -100   opcode = 11
#	.asciiz "00110010001100100000000000011001" # corrisponde a andi $s2, $s1, 25 in bin = 25 byte   opcode = 12
#	.asciiz "00110010001100101111111111111111" # corrisponde a andi $s2, $s1, 65535 in bin = 65535  opcode = 12
#	.asciiz "00110110001100100000000000011001" # corrisponde a ori $s2, $s1, 25 in bin = 25 byte	opcode = 13
#	.asciiz "00110110001100101111111111111111" # corrisponde a ori $s2, $s1, 65535 in bin = 65535	opcode = 13
#	.asciiz "00111010001100100000000000011001" # corrisponde a xori $s2, $s1, 25 in bin = 25 byte   opcode = 14
#	.asciiz "00111010001100101111111111111111" # corrisponde a xori $s2, $s1, 65535 in bin = 65535  opcode = 14
#	.asciiz "00111100000100100111111111111111" # corrisponde a lui $s2, 32767 in bin = 32767 byte	opcode = 15
#	.asciiz "00111100000100101000000000000000" # corrisponde a lui $s2, -32768 in bin = -32768 byte	opcode = 15

#	.asciiz "10000010010100010000000001100100" # corrisponde a lb $s2, 100($s1) in bin 100 byte	opcode = 32
#	.asciiz "10000010010100011111111110011100" # corrisponde a lb $s2, -100($s1) in bin -100 byte	opcode = 32
#	.asciiz "10000110010100010000000001100100" # corrisponde a lh $s2, 100($s1) in bin 100 byte	opcode = 33
#	.asciiz "10000110010100011111111110011100" # corrisponde a lh $s2, -100($s1) in bin -100 byte	opcode = 33
#	.asciiz "10001010010100010000000001100100" # corrisponde a lwl $s2, 100($s1) in bin 100 byte	opcode = 34
#	.asciiz "10001010010100011111111110011100" # corrisponde a lwl $s2, -100($s1) in bin -100 byte	opcode = 34
#	.asciiz "10001110010100010000000001100100" # corrisponde a lw $s2, 100($s1) in bin 100 byte	opcode = 35
#	.asciiz "10001110010100011111111110011100" # corrisponde a lw $s2, -100($s1) in bin -100 byte	opcode = 35
#	.asciiz "10010010010100010000000001100100" # corrisponde a lbu $s2, 100($s1) in bin 100 byte	opcode = 36
#	.asciiz "10010010010100011111111111111111" # corrisponde a lbu $s2, 65535($s1) in bin 65535	opcode = 36
#	.asciiz "10010110010100010000000001100100" # corrisponde a lhu $s2, 100($s1) in bin 100 byte	opcode = 37
#	.asciiz "10010110010100011111111111111111" # corrisponde a lhu $s2, 65535($s1) in bin 65535	opcode = 37
#	.asciiz "10011010010100010000000001100100" # corrisponde a lwr $s2, 100($s1) in bin 100 byte	opcode = 38
#	.asciiz "10011010010100011111111110011100" # corrisponde a lwr $s2, -100($s1) in bin -100 byte	opcode = 38
#	.asciiz "10100010010100010000000001100100" # corrisponde a sb $s2, 100($s1) in bin 100 byte	opcode = 40
#	.asciiz "10100010010100011111111110011100" # corrisponde a sb $s2, -100($s1) in bin -100 byte	opcode = 40
#	.asciiz "10100110010100010000000001100100" # corrisponde a sh $s2, 100($s1) in bin 100 byte	opcode = 41
#	.asciiz "10100110010100011111111110011100" # corrisponde a sh $s2, -100($s1) in bin -100 byte	opcode = 41
#	.asciiz "10101010010100010000000001100100" # corrisponde a swl $s2, 100($s1) in bin 100 byte	opcode = 42
#	.asciiz "10101010010100011111111110011100" # corrisponde a swl $s2, -100($s1) in bin -100 byte	opcode = 42
#	.asciiz "10101110010100010000000001100100" # corrisponde a sw $s2, 100($s1) in bin 100 byte	opcode = 43
#	.asciiz "10101110010100011111111110011100" # corrisponde a sw $s2, -100($s1) in bin -100 byte	opcode = 43
#	.asciiz "10111010010100010000000001100100" # corrisponde a swr $s2, 100($s1) in bin 100 byte	opcode = 46
#	.asciiz "10111010010100011111111110011100" # corrisponde a swr $s2, -100($s1) in bin -100 byte	opcode = 46

.text

.globl main

main:
						# $s0 conterra' l'indirizzo del carattere '0' e poi il valore relativo al formato di stampa
						# $s2 conterra' l'indirizzo di partenza della stringa str inserita dall'utente
						# $s3 conterra' l'indirizzo della stringa relativa al comando MIPS inserito
						# $s4 conterra' l'indirizzo della stringa corrispondente al registro rs
						# $s5 conterra' l'indirizzo della stringa corrispondente al registro rt
						# $s6 conterra' l'indirizzo della stringa corrispondente al registro rd/indirizzo 16-26 bit/valore immediato
						# $s7 conterra' l'indice relativo al vettore di opcode/funct corrispondente all'opcode/funct inserito

	la $s2, str				# salva l'indirizzo di partenza di memoria della stringa che verra' inserita dall'utente in $s8

#
# Stampa messaggio inserire codice binario
#
	li $v0, 4				# Seleziona codice di servizio per stampa stringa
	la $a0, input				# Carica in $a0 la stringa di inserimento codice binario
	syscall					# Stampa la stringa

#
# Legge una stringa in ingresso lunga 33 caratteri al max
#
	li $v0, 8				# Seleziona codice di servizio per inserimento stringa
	move $a0, $s2				# Copia in $a0 l'indirizzo della stringa
	li $a1, 33				# Seleziona il numero massimo di caratteri che e' possibile inserire
	syscall					# Legge stringa 

#
# Chiama la procedura che effettua il confronto dei caratteri inseriti con 0 e 1 ed in piu' calcola la lunghezza della stringa
# Restituisce -1 in $v1 se esiste un carattere diverso da 0 e 1 o se la lunghezza e' <> 32 (con la relativa stringa di errore)
# altrimenti restituisce 0 in $v1 ed in $v0 mette l'indirizzo della procedura da eseguire
# 
	jal checkstropcode			# Verifica che la stringa inserita sia lunga 32 bit composti da 0 e 1 soltanto

	slt $t0, $v1, $zero			# $t0 = 1 se $v1 < 0 (ovvero se checkstropcode restituisce -1)
	bne $t0, $zero, printstr		# se $t0 = 1 <> 0 quindi $v1 < 0 allora stampa la stringa restituita da checkstropcode

	jalr $v0				# se la stringa e' corretta esegue la procedura puntata dal registro $v0

#
# $v0 conterra' il puntatore alla stringa di errore o newline che verra' ritornata dalla procedura eseguita precedentemente
#
printstr:
	move $a0, $v0				# Copia in $a0 la stringa di errore o una newline
	li $v0, 4				# Copia in $v0 il valore di $v0 = 4 che indica che vogliamo stampare una stringa
	syscall					# Stampa la stringa

	li $v0, 10				# Termina esecuzione programma
	syscall


#############################################################################################
# Procedura che verifica la lunghezza della stringa, verifica la presenza di tutti 0 ed 1.  #
# Verifica inoltre che l'opcode sia presente tra quelli riconosciuti.			    #
# Se tutte le condizioni sono verificate seleziona il formato dell'istruzione e copia in $v0#
# l'indirizzo della procedura da eseguire per la decodifica dell'istruzione.		    #
# Se una delle condizioni non e' verificata restituisce -1 in $v1 e la stringa relativa al  #
# tipo di errore riscontrato in $v0 							    #
#############################################################################################
checkstropcode:
	addi $sp, $sp, -4			# Crea spazio nello stack per salvare un registro word = 4 byte
	sw $ra, 0($sp)				# Salva il registro $ra

	move $a0, $s2				# Copia in $a0 l'indirizzo della stringa	
	move $v1, $zero				# Inizializza la lunghezza della stringa a 0
	lb $s0, czero				# Mette in $s0 il carattere 0 (1 byte)
	lb $t1, cuno				# Mette in $t1 il carattere 1 (1 byte)
	lb $t3, newline				# Mette in $t3 il carattere \n
whilec: lb $t2, 0($a0)				# Estrae byte meno significativo
        beq $t2, $zero, finewhilec		# Se il carattere e' NULL=00 allora esce
        beq $t2, $s0, avantic			# Se il carattere e' 0=30 allora passa al prossimo carattere
        beq $t2, $t1, avantic			# Se il carattere e' 1=31 allora passa al prossimo carattere
	beq $t2, $t3, errlung			# Se il carattere e' \n=10 allora 
	la $v0, strcarerr			# Restituisce in $v0 la stringa di errore caratteri errati
	j returnwhilec				# Esce dal ciclo
errlung:
	la $v0, strlenerr			# Restituisce in $v0 la stringa di errore lunghezza stringa
returnwhilec:
	li $v1, -1				# Restituisce in $v1 il valore -1
        j returncheckstr			# Va al punto di ritorno della procedura
avantic:
	addi $v1, $v1, 1			# Incrementa la lunghezza della stringa di  $v1 = 1
	addi $a0, $a0, 1			# Passa al byte successivo della stringa
        j whilec				# Torna al ciclo while
finewhilec:
	li $t0, 32					
	beq $v1, $t0, continueopcode		# Se la lunghezza della stringa inserita = 32 ovvero $v1 = 32 vai alla parte relativa all'opcode
	la $v0, strlenerr			# Restituisce in $v0 la stringa di errore lunghezza stringa errata
	li $v1, -1				# Restituisce in $v1 il valore -1
	j returncheckstr			# Va al punto di ritorno della procedura
continueopcode:
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa
	li $a1, 5				# $a1 indica l'indice di partenza del codice operativo da convertire in decimale
	move $a2, $zero				# $a2 contiene l'indice dove si fermera' il calcolo del valore decimale del codice operativo
	jal stringtodec				# Calcola il valore decimale del codice operativo e lo mette in $v0

	#
	# Verifica codice operativo
	#
	la $t0 opcode				# $t0 punta al primo elemento dell'array di opcode
	move $s7, $zero				# $s7 contatore all'elemento dell'array di opcode ed al relativo formattype
	li $v1, -1				# $v1 contiene il codice di uscita del ciclo che indica nessun opcode valido
cycleopcode:
	lw $t1, 0($t0)				# $t1 contiene l'opcode estratto dalla memoria elemento $t0[i]
	beq $t1, $v1, erropcode			# se $t1 = -1 vuol dire che non abbiamo trovato nessun opcode valido
	beq $t1, $v0, exitcycle			# altrimenti se $t1 = $v0 vuol dire che abbiamo trovato un opcode valido
	addi $s7, $s7, 4			# incrementa il contatore all'elemento dell'array successivo in word
	addi $t0, $t0, 4			# passa all'elemento successivo dell'array di opcode
	j cycleopcode				# torna al ciclo
exitcycle:
	la $t0, formattype			# $t0 punta all'inizio dell'array formattype (prima word)
	add $t0, $t0, $s7			# $t0 viene spostato all'elemento corrispondente all'opcode inserito
	lw $v0, 0($t0)				# $v0 conterra' l'indirizzo della procedura da eseguire per quell'opcode
	move $v1, $zero				# Pone $v1 a 0
	j returncheckstr			# Va al punto di ritorno della procedura
erropcode:
	la $v0, stropcerr			# Restituisce in $v0 la stringa di opcode errato
returncheckstr:
	lw $ra, 0($sp)				# Ripristina il registro di ritorno
	add $sp, $sp, 4				# Elimina lo spazio creato nello stack

	jr $ra					# Ritorna al main


##########################################################################################
# Procedura che calcola e restituisce il valore decimale di una stringa data in ingresso #
# in $a0, partendo dalla posizione $a1 tornando indietro fino alla posizione $a2         #
##########################################################################################
stringtodec:
						# $a0 contiene l'indirizzo di partenza della stringa
						# $a1 contiene l'indice superiore
						# $a2 contiene l'indice inferiore
	li $t2, 1				# $t2 contiene l'esponente in base 2 relativo al bit attuale
	move $v0, $zero				# $v0 contiene il valore decimale corrispondente alla stringa data parte da 0
whiledec:
        add $t0, $a0, $a1			# $t0 punta alla posizione $a0 + $a1
	lb $t1, 0($t0)				# $t1 contiene il byte meno significativo a partire da $t0
	slt $t3, $a1, $a2			# $t3 = 1 se $a1 < $a2
        bne $t3, $zero, finewhiledec		# se $t3 = 1 <> 0  vai alla fine della procedura
        beq $t1, $s0, avantidec			# altrimenti se $t1 = "0" vai avantidec in quanto non devi calcolare nulla
	add $v0, $v0, $t2			# se $t1 <> 0 = 1 allora $v0 = $v0 + $t2
avantidec:
	add $t2, $t2, $t2			# incrementa l'esponente di una base 2
        addi $a1, $a1, -1			# decrementa $a1 di 1
	j whiledec
finewhiledec:
	jr $ra


###########################################################################################
# Procedura che calcola se e' da fare il complemento a 2 oppure se da calcolare il valore #
# positivo di un campo di bit, selezionato dalla stringa in ingresso in $a0 e delimitato  #
# dai parametri $a1 e $a2 sempre in ingresso. Restituisce il valore decimale del campo di #
# bit eseguendo il complemento a 2 su tale campo, convertendolo in decimale e poi         #
# negandolo se necessario, altrimenti calcola il valore positivo del campo		  #
###########################################################################################
checkcomp2:
						# $a0 contiene l'indirizzo di partenza della stringa
						# $a1 contiene l'indice superiore
						# $a2 contiene l'indice inferiore

	addi $sp, $sp, -4			# Crea spazio nello stack per salvare i dati
	sw $ra, 0($sp)				# Salva il registro $ra

	add $t0, $a0, $a2			# $t0 si posiziona sul bit piu' significativo
	lb $t1, cuno				# Carica in $t1 il carattere '1'
	lb $t2, 0($t0)				# Estrae il bit piu' significativo e lo mette in $t2
	bne $t2, $t1, numpositivo		# Se il bit piu' significativo $t2 e' <> '1' allora va al calcolo del numero positivo
	move $t4, $a1				# Altrimenti copia valore di $a1 in $t4 per contare
loopcomp:
	beq $t2, $t1, cambiain0			# Se $t2 = '1' = $t1 allora lo si deve cambiare in 0
	sb $t1, 0($t0)				# altrimenti si cambia in '1'
	j continuecomp

cambiain0:
	sb $s0, 0($t0)				# Cambia il carattere in '0'

continuecomp:
	addi $t0, $t0, 1			# Incrementa $t0 di uno
	addi $t4, $t4, -1			# Decrementa $t4 di uno
	slt $t3, $t4, $a2			# $t3 = 1 se $t4 < $a2
        bne $t3, $zero, numnegativo		# Se $t3 <> 0  complemento a 1 terminato e va al calcolo del numero negativo
	lb $t2, 0($t0)				# Altrimenti estrae un carattere da $t0 e lo mette in $t2
	j loopcomp				# e si continua il ciclo

numpositivo:
	jal stringtodec				# Calcola il valore numerico
	j returncheckcomp			# va al punto di ritorno della procedura

numnegativo:
	jal stringtodec				# Calcola il valore numerico
	addi $v0, $v0, 1			# Aggiunge uno al valore numerico per finire il complemento a 2
	sub $v0, $zero, $v0			# Trasforma il valore in negativo

returncheckcomp:
	lw $ra, 0($sp)				# Ripristina il registro di ritorno
	addi $sp, $sp, 4			# Elimina lo spazio creato nello stack

	jr $ra					# Ritorna al chiamante


#######################################################################
# Procedura che estrae il campo registro da una stringa data in       #
# ingresso $a0 e delimitato dai parametri $a1, $a2. Restituisce       #
# direttamente l'indirizzo della stringa corrispondente al valore del #
# registro in $v0 						      #
#######################################################################
extractreg:
						# $a0 contiene l'indirizzo di partenza della stringa da cui estrarre il registro
						# $a1 contiene l'indice superiore
						# $a2 contiene l'indice inferiore

	addi $sp, $sp, -4			# Crea spazio nello stack per salvare i dati
	sw $ra, 0($sp)				# Salva il registro $ra

	jal stringtodec				# Calcola il valore numerico

	la $t0, registri			# $t0 punta all'inizio dell'array registri contenente gli indirizzi delle stringhe dei registri
	sll $v0, $v0, 2				# $v0 x 4
	add $t0, $t0, $v0 			# $t0 punta all' $t0[$v0] posizione
	lw $v0, 0($t0)				# estrae l'indirizzo della stringa dalla memoria e lo mette in $v0

	lw $ra, 0($sp)				# Ripristina il registro di ritorno
	addi $sp, $sp, 4			# Elimina lo spazio creato nello stack

	jr $ra					# Ritorna al chiamante


#############################################################################
# Procedura che estrae i campi relativi a istruzioni in formato R, verifica #
# che tutti i campi siano congrui e in caso affermativo stampa l'istruzione #
# MIPS relativa restituendo una newline, altrimenti restituisce una stringa #
# relativa al tipo di errore incontrato o parametro errato	 	    #
#############################################################################
formator:
	addi $sp, $sp, -4			# Crea spazio nello stack per salvare i dati
	sw $ra, 0($sp)				# Salva il registro $ra

	#
	# Estrae funct dall'istruzione e la mette in $s3
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre la funzione
	li $a1, 31				# $a1 contiene l'indice superiore
	li $a2,26				# $a2 contiene l'indice inferiore
	jal stringtodec				# Calcola il valore decimale del campo funct
	move $s3, $v0				# Copia il valore decimale della funzione in $s3

	la $t0, functr				# $t0 punta all'array delle funzioni functr
	move $s7, $zero				# $s7 e' il contatore che parte da 0
	li $t1, -1				# $t1 contiene il valore -1 che indica che indica la fine dell'array functr
loopfunctr:
	lw $t2, 0($t0)				# Estrae codice funzione da array functr[$t0] e lo mette in $t2
	beq $t2, $t1 notfoundfunct		# Se $t2 = -1 significa che non abbiamo trovato la funzione nell'array
	beq $t2, $s3 endloopfunctr		# Se $t2 = $s3 significa che abbiamo trovato la funzione nell'array
	addi $t0, $t0, 4			# Passa alla word successiva dell'array
	addi $s7, $s7, 4			# Incrementa il contatore in word
	j loopfunctr				# Continua ciclo
notfoundfunct:
	la $v0, strfunzerr
	j returnformator

endloopfunctr:
	#
	# Estrae la stringa relativa alla funct specificata e la mette in $s3
	# 
	la $t0, instructionsreg			# $t0 punta alla prima stringa di istruzioni
	add $t0, $t0, $s7			# Spostiamo $t0 alla posizione relativa alla funzione trovata

	lw $s3, 0($t0)				# $s3 contiene l'indirizzo della stringa relativa al comando (funzione) MIPS
	
	#
	# Estrae registro 1=rs e mette in $s4 la stringa relativa al registro 1
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 10				# $a1 contiene l'indice superiore
	li $a2, 6				# $a2 contiene l'indice inferiore
	jal extractreg				# Calcola il valore decimale del registro
	move $s4, $v0				# Copia il valore in $s4

	#
	# Estrae registro 2=rt e mette in $s5 la stringa relativa al registro 2
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 15				# $a1 contiene l'indice superiore
	li $a2, 11				# $a2 contiene l'indice inferiore
	jal extractreg				# Calcola il valore decimale del registro
	move $s5, $v0				# Copia il valore in $s5

	#
	# Estrae registro 3=rd e mette in $s6 la stringa relativa al registro 3
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 20				# $a1 contiene l'indice superiore
	li $a2, 16				# $a2 contiene l'indice inferiore
	jal extractreg				# Calcola il valore decimale del registro
	move $s6, $v0				# Copia il valore in $s6

	#
	# Estrae Shamt
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 25				# $a1 contiene l'indice superiore
	li $a2, 21				# $a2 contiene l'indice inferiore
	jal stringtodec				# Calcola il valore decimale del registro

	#
	# Estrae case dello switch
	#
	la $t1, switchr				# si posiziona al primo elemento dell'array switchr
	add $t1, $t1, $s7			# $t1 punta all'elemento relativo alla funzione selezionata
	lw $t1, 0($t1)				# estrae l'indirizzo del case da eseguire

	jr $t1					# va al case relativo alla funzione selezionata

R0:
	#
	# Verifica parametri il formato r - movz, movn, add, addu, sub, subu, and, or, nor, xor, slt, sltu
	#
	bne $v0, $zero, errshamt		# Se il valore dello shamt <> 0 allora restituisce la stringa di errore shamt
	j printformator				# Altrimenti va a selezionare il formato di stampa
	
R1:
	#
	# Verifica parametri per il formato r - jr, jalr
	#
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s5, $t0, errreg			# Se $s5 non e' $zero = valore 0 allora si ha un valore errato
	beq $s6, $t0, goprintformator		# Se $s6 e' $zero = valore 0 allora si ha una jalr con 1 registro
	
	move $s5, $s6				# altrimenti abbiamo una jalr con 2 registri spostiamo $s6 in $s5
	la $a0, P4				# Selezioniamo il formato di stampa diverso in $a0
	jal printmips				# Eseguiamo la stampa
	j returnformator			# Va al punto di ritorno della procedura

goprintformator:
	j printformator				# Seleziona il formato di stampa

R2:
	#
	# Verifica parametri per il formato r - sllv, srlv, srav
	#
	bne $v0, $zero, errshamt		# Se il valore dello shamt <> 0 allora restituisce la stringa di errore shamt
	move $t0, $s4				# Scambia i valori di $s4 e $s5 in quanto poi in stampa deve uscire prima $t e poi $s
	move $s4, $s5				# per fare questo utilizza un registro temporaneo $t0
	move $s5, $t0				#
	j printformator				# Seleziona il formato di stampa

R3:
	#
	# Verifica parametri per il formato r - sll, srl, sra
	#
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s4, $t0, errreg			# Se il registro rs <> $zero ovvero 0 allora va alla parte che restituisce la stringa parametri errati
	move $s4, $v0				# Copia in rs il valore di shamt
	j printformator				# Seleziona il formato di stampa

R4:
	#
	# Verifica parametri per il formato r - mul, multu, div, divu
	#
	bne $v0, $zero, errshamt		# Se il valore dello shamt <> 0 allora restituisce la stringa di errore shamt
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s6, $t0, errreg			# Se il registro rd <> "$zero" ovvero 0 allora va alla parte che restituisce la stringa parametri errati
	j printformator				# Seleziona il formato di stampa

R5:
	#
	# Verifica parametri per il formato r - mfhi, mflo
	#
	bne $v0, $zero, errshamt		# Se il valore dello shamt <> 0 allora restituisce la stringa di errore shamt	
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s4, $t0, errreg			# Se rs = $s4 <> "$zero" = valore 0 allora si ha un valore errato
	bne $s5, $t0, errreg			# Se rt = $s5 <> "$zero" = valore 0 allora si ha un valore errato
	move $s4, $s6				# Copia il valore del registro rd = $s6 in rs = $s4 per il formato di stampa
	j printformator				# Seleziona il formato di stampa

R6:
	#
	# Verifica parametri per il formato r - mthi, mtlo
	#
	bne $v0, $zero, errshamt		# Se il valore dello shamt <> 0 allora restituisce la stringa di errore shamt
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s5, $t0, errreg			# Se rt = $s5 <> "$zero" = valore 0 allora si ha un valore errato
	bne $s6, $t0, errreg			# Se rd = $s6 <> "$zero" = valore 0 allora si ha un valore errato
	j printformator

R7:
	#
	# Verifica parametri per il formato r - syscall, break 
	#
	bne $v0, $zero, errshamt		# Se il valore dello shamt <> 0 allora restituisce la stringa di errore shamt
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s4, $t0, errreg			# Se rs = $s4 <> "$zero" = valore 0 allora si ha un valore errato
	bne $s5, $t0, errreg			# Se rt = $s5 <> "$zero" = valore 0 allora si ha un valore errato
	bne $s6, $t0, errreg			# Se rd = $s6 <> "$zero" = valore 0 allora si ha un valore errato
						# Seleziona il formato di stampa

printformator:
	#
	# Seleziona il formato di stampa
	#
	la $t1, printr				# $t1 punta all'array dell'etichette dei case dello switch per il formato di stampa r
	add $t1, $t1, $s7			# $t1 si sposta sulla funzione richiesta
	lw $a0, 0($t1)				# Estrae l'indirizzo del case dello switch di stampa e lo mette in $a0
	jal printmips				# Chiama la procedura di stampa passandogli in $a0 il formato di stampa da usare
	j returnformator			# Va al punto di ritorno della procedura

errshamt:
	la $v0, strshamterr			# Fa puntare $v0 alla stringa di errore shamt
	j returnformator			# Va al punto di ritorno della procedura

errreg:
	la $v0, strregerr			# Fa puntare $v0 alla stringa di errore valore registro errato

returnformator:
	lw $ra, 0($sp)				# Ripristina il registro di ritorno
	addi $sp, $sp, 4			# Elimina lo spazio creato nello stack

	jr $ra					# Ritorna al chiamante


#############################################################################
# Procedura che estrae i campi relativi a istruzioni in formato I, verifica #
# che tutti i campi siano congrui e in caso affermativo stampa l'istruzione #
# MIPS relativa restituendo una newline, altrimenti restituisce una stringa #
# relativa al tipo di errore incontrato o parametro errato	 	    #
#############################################################################
formatoi:
	addi $sp, $sp, -4			# Crea spazio nello stack
	sw $ra, 0($sp)				# Salva $ra nello stack

	#
	# Estrae la stringa relativa all'opcode specificato e la mette in $s3
	# 
	la $t0, instructions			# $t0 punta all'elenco delle istruzioni
	add $t0, $t0, $s7			# ci spostiamo avanti di opcode posizioni
	lw $s3, 0($t0)				# $s3 contiene l'indirizzo della stringa relativa al comando MIPS

	#
	# Estrae registro 1=rs e mette in $s4 la stringa relativa al registro 1
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 10				# $a1 contiene l'indice superiore
	li $a2, 6				# $a2 contiene l'indice inferiore
	jal extractreg				# Calcola il valore decimale del registro
	move $s4, $v0				# Copia il valore in $s4

	#
	# Estrae registro 2=rt e mette in $s5 la stringa relativa al registro 2
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 15				# $a1 contiene l'indice superiore
	li $a2, 11				# $a2 contiene l'indice inferiore
	jal extractreg				# Calcola il valore decimale del registro
	move $s5, $v0				# Copia il valore in $s5

	#
	# Prepara per estrarre indirizzo/valore
	#
	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 31				# $a1 contiene l'indice superiore
	li $a2, 16				# $a2 contiene l'indice inferiore
	
	#
	# Estrae case dello switch
	#
	la $t1, switchother			# si posiziona al primo elemento dell'array switchother
	add $t2, $t1, $s7			# $t2 punta all'elemento relativo all'opcode dell'istruzione
	lw $t2, 0($t2)				# estrae l'indirizzo del case da eseguire

	jr $t2					# va al case relativo all'opcode dell'istruzione

I1:
	# 
	# Ricava i parametri per il formato i - bne, beq, bnel, beql
	#
	jal checkcomp2				# Esegue procedura per ricavare numero positivo o negativo
	move $t0, $s4				# Copia il valore di $s4 in $t0 per lo scambio
	sll $s4, $v0, 2				# Moltiplica $v0 x 4 e lo mette in $s4
	move $s6, $t0				# Copia in $s6 il valore di $t0 che era $s4, questo per uniformarsi al formato di stampa
	j printformatoi				# Va alla selezione del formato di stampa

I2:
	#
	# Verifica parametri per il formato i - blez, bgtz, blezl, bgtzl
	#
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s5, $t0, errreg2			# Se il registro rt <> "$zero" = 0 allora ritorna stringa errata
	jal checkcomp2				# Esegue procedura per calcolare numero positivo o negativo
	sll $s6, $v0, 2				# $s6 = $v0 x 4
	move $s5, $s4				# Copia in $s5 il valore di $s4, questo per uniformarsi al formato di stampa
	j printformatoi				# Va alla selezione del formato di stampa

I3:
	#
	# Verifica i parametri per il formato i - addi, addiu, slti, sltiu, lb, lh, lwl, lw, lwr, sb, sh, swl, sw, swr
	#
	jal checkcomp2				# Esegue procedura per ricavare numero positivo o negativo
	j I34					# Vai alla parte comune I34

I4:
	#
	# Verifica i parametri per il formato i - andi, ori, xori, lbu, lhu
	#
	jal stringtodec				# Ricava il numero positivo

I34:
	#
	# Parte comune per il formato i - addi, addiu, slti, sltiu, lb, lh, lwl, lw, lwr, sb, sh, swl, sw, swr, andi, ori, xori
	#
	move $t0, $s4				# Salva il valore di $s4 in $t0 per lo scambio
	move $s4, $v0				# Copia in $s4 il valore del numero
	move $s6, $s5				# Copia in $s6 il contenuto di $s5
	move $s5, $t0				# Copia il contenuto di $t0 vecchio $s5 in $s6
	j printformatoi				# Va alla selezione del formato di stampa

I5:
	#
	# Verifica i parametri per il formato i - lui
	#
	la $t0, r0				# Carica in $t0 l'indirizzo della stringa r0 = "$zero"
	bne $s4, $t0, errreg2			# Se il registro rs = $s4 <> "$zero" = 0 allora restituisce la stringa di errore registro
	jal checkcomp2				# Altrimenti calcola valore positivo o negativo
	move $s6, $v0				# Salva in $s6 il valore decimale del valore
	j printformatoi				# Va alla selezione del formato di stampa

I6:
	#
	# Verifica i parametri per il formato i - bltz, bgez, bltzl, bgezl, bltzal, bgezal, bltzall, bgezall
	#
	jal checkcomp2				# Calcola valore offset	negativo o positivo
	sll $s6, $v0, 2				# mette in $s6 il valore offset x 4

	la $t0, instructionsbranch1		# $t0, punta l'inizio dell'array relativo alle stringhe delle istruzioni branch
	la $t1, printbranch1			# $t1, punta l'inizio dell'array relativo alle stringhe dei registri delle istruzioni branch
	li $t2, -1				# $t2 ha il valore -1 che significa nessun istruzione branch trovata
loopi6:
	lw $t3, 0($t1)				# Estrae valore da array printbranch1[$t1] e lo mette in $t3
	beq $t3, $t2, errreg2			# Se $t3 = -1 significa che non abbiamo trovato il branch nell'array e ritorna stringa di errore
	beq $t3, $s5 endloopi6			# Se $t3 = $s5 = rt, significa che abbiamo trovato la branch nell'array
	addi $t0, $t0, 4			# Passa alla word successiva dell'array instructionsbranch1
	addi $t1, $t1, 4			# Passa alla word successiva dell'array printbranch1
	j loopi6				# Continua ciclo
endloopi6:
	lw $s3, 0($t0)				# Estra la stringa relativa al comando branch e la mette in $s3
	move $s5, $s4				# Copia il valore di $s4 in $s5 per il formato di stampa
	la $a0, OP2				# Copia in $a0 il puntatore alla modalita' di stampa
	jal printmips				# Chiama la procedura di stampa passando in $a0 la modalita'
	j returnformatoi			# Va al punto di ritorno della procedura

printformatoi:
	#
	# Seleziona il formato di stampa
	#
	la $t1, printother			# $t1 punta all'array dell'etichette dei case dello switch per la stampa del formato i
	add $t1, $t1, $s7			# $t1 si sposta sull'elemento relativo all'opcode dell'istruzione
	lw $a0, 0($t1)				# Estrae l'indirizzo del case dello switch di stampa e lo mette in $a0
	jal printmips				# Chiama la procedura di stampa passandogli in $a0 il formato di stampa da usare
	j returnformatoi			# Va al punto di ritorno della procedura

errreg2:
	la $v0, strregerr			# Fa puntare $v0 alla stringa di errore valore registro errato

returnformatoi:
	lw $ra, 0($sp)				# Ripristino del registro $ra dallo stack
	addi $sp, $sp, 4			# Rimozione degli elementi ripristinati

	jr $ra					# ritorna al chiamante


######################################################################
# Procedura che estrae i campi relativi a istruzioni in formato J ed #
# stampa l'istruzione MIPS relativa restituendo una newline	     #
######################################################################
formatoj:
	addi $sp, $sp, -4			# Crea spazio nello stack
	sw $ra, 0($sp)				# Salva $ra nello stack

	la $t0, instructions			# $t0 punta all'elenco delle istruzioni
	add $t0, $t0, $s7			# ci spostiamo avanti di opcode posizioni
	lw $s3, 0($t0)				# $s3 contiene l'indirizzo della stringa relativa al comando MIPS

	move $a0, $s2				# Copia in $a0 l'indirizzo di partenza della stringa da cui estrarre il campo
	li $a1, 31				# $a1 contiene l'indice superiore
	li $a2, 6				# $a2 contiene l'indice inferiore
	jal stringtodec				# Estrae valore dell'indirizzo
	move $s6, $v0				# Copia in $s6 il valore dell'indirizzo
	sll $s6, $s6, 2				# Moltiplica $s6 x 4 per puntare word

	la $t0, printother			# $t0 punta all'array dell'etichette dei case dello switch per i formati di stampa diversi da r
	add $t0, $t0, $s7			# $t0 si sposta sull'opcode richiesto
	lw $a0, 0($t0)				# Estrae l'indirizzo del case dello switch di stampa e lo mette in $a0

	jal printmips				# Esegue la procedura di stampa

	lw $ra, 0($sp)				# Ripristino del registro $ra dallo stack
	addi $sp, $sp, 4			# Rimozione degli elementi ripristinati

	jr $ra 


################################################################################################
# Procedura che esegue la stampa dell'istruzione mips a seconda del formato specificato da $a0 #
################################################################################################
printmips:
	move $t2, $a0				# Copia il contenuto di $a0 (tipo formato di stampa) in $t2

	li $v0, 4				# Seleziona codice di servizio per stampa stringa
	la $t0, newline				# Carica in $t0 la newline
	move $a0, $t0				# Copia $t0 in $a0
	syscall					# Stampa newline
	move $a0, $s3				# Carica in $a0 l'indirizzo della stringa relativa al comando MIPS
	syscall					# Stampa la stringa del comando MIPS

	jr $t2					# Passa al case di stampa relativo al formato specifico dell'istruzione (che era in $a0)

P1:
	#
	# Stampa per istruzioni formato r (jr, jalr - mfhi, mthi, mflo, mtlo) ovvero: "istruzione stringa_in_$s4"
	#
	move $a0, $s4				# Copia in $a0 l'indirizzo della stringa relativa a rs/rd
	syscall					# Stampa la stringa relativa a rs/rd
	j RP					# Va al punto di ritorno della procedura

P2:
	#
	# Stampa per istruzioni formato r (sllr, srlv, srav, movz, movn, add, addu, sub, subu, and, or, nor, xor, slt, sltu) 
	# ovvero: "istruzione stringa_in_$s6, stringa_in_$s4, stringa_in$s5
	#
	move $a0, $s6				# Copia in $a0 l'indirizzo della stringa relativa a rd
	syscall					# Stampa la stringa relativa a rd

	la $t4, comma				# Carica in $t4 l'indirizzo della virgola
	move $a0, $t4				# Copia in $a0 l'indirizzo della virgola
	syscall					# Stampa la stringa virgola

	move $a0, $s4				# Copia in $a0 l'indirizzo della stringa relativa a rs
	syscall					# Stampa la stringa relativa a rs

	move $a0, $t4				# Copia in $a0 l'indirizzo della stringa virgola
	syscall					# Stampa la stringa virgola

	move $a0, $s5				# Copia in $a0 l'indirizzo della stringa relativa a rt
	syscall					# Stampa la stringa relativa a rt

	j RP					# Va al punto di ritorno della procedura

P3:
	#
	# Stampa per istruzioni formato r (sll, srl, sra) formato i (beq, bne, beql, bnel, addi, addiu, slti, sltiu, andi, ori, xori) 
	# ovvero: "istruzione stringa_in_$s6, stringa_in_$s5, valore_in_$s4"
	#
	move $a0, $s6				# Copia in $a0 l'indirizzo della stringa relativa a rd/rt
	syscall					# Stampa la stringa relativa a rd/rt

	la $t4, comma				# Carica in $t4 l'indirizzo della virgola
	move $a0, $t4				# Copia in $a0 l'indirizzo della virgola
	syscall					# Stampa la stringa virgola

	move $a0, $s5				# Copia in $a0 l'indirizzo della stringa relativa a rt/rs
	syscall					# Stampa la stringa relativa a rt/rs

	move $a0, $t4				# Copia in $a0 l'indirizzo della stringa virgola
	syscall					# Stampa la stringa virgola

	li $v0, 1				# Seleziona codice di servizio per stampa intero
	move $a0, $s4				# Carica in $a0 il valore dello shamt/valore immediato messo nel registro rs
	syscall					# Stampa il valore dello shamt/valore immediato

	j RP					# Va al punto di ritorno della procedura

P4:
	#
	# Stampa per istruzioni formato r (mult, multu, div, divu) ovvero: "istruzione stringa_in$s4, stringa_in_$s5"
	#

	move $a0, $s4				# Copia in $a0 l'indirizzo della stringa relativa a rs
	syscall					# Stampa la stringa relativa a rs

	la $a0, comma				# Carica in $a0 l'indirizzo della virgola
	syscall					# Stampa la stringa virgola

	move $a0, $s5				# Copia in $a0 l'indirizzo della stringa relativa a rt
	syscall					# Stampa la stringa relativa a rt
	
	j RP					# Va al punto di ritorno della procedura

OP0:
	#
	# Stampa per istruzioni formato j (j, jal) ovvero: "istruzione indirizzo_in_$s4"
	#
	li $v0, 1				# Seleziona codice di servizio per stampa intero
	move $a0, $s6				# Copia in $a0 il valore dell'indirizzo che e' stato messo in $s6
	syscall					# Stampa il valore dell'indirizzo

	j RP					# Va al punto di ritorno della procedura

OP1:
	#
	# Stampa per istruzioni formato i (lb, lh, lwl, lw, lbu, lhu, lwr, sb, sh, swl, sw, swr) 
	# ovvero: istruzione stringa_in_$s5, valore_in_$s4(stringa_in_$s6)
	#
	move $a0, $s5				# Copia in $a0 l'indirizzo della stringa relativa a rt
	syscall					# Stampa la stringa relativa a rt

	la $a0, comma				# Carica in $a0 l'indirizzo della virgola
	syscall					# Stampa la stringa virgola

	move $a0, $s4				# Copia in $a0, il valore dell'offset
	li $v0, 1				# Seleziona codice di servizio per stampa intero
	syscall					# Stampa valore dell'offset

	li $v0, 4				# Seleziona codice di servizio per stampa stringa
	la $a0, pars				# Carica in $a0 l'indirizzo della parentesi aperta
	syscall					# Stampa parentesi aperta

	move $a0, $s6				# Carica in $a0 l'indirizzo della stringa relativa a rs/base
	syscall					# Stampa la stringa relativa a rs/base

	la $a0, pard				# Carica in $a0 l'indirizzo della parentesi chiusa
	syscall					# Stampa parentesi chiusa

	j RP					# Va al punto di ritorno della procedura

OP2:
	#
	# Stampa per istruzioni formato i (lui, blez, bgtz, blezl, bgtzl) ovvero: istruzione stringa_in_$s5, valore_in_$s6
	#
	move $a0, $s5				# Copia in $a0 l'indirizzo della stringa relativa a rt/rs
	syscall					# Stampa la stringa relativa a rt/rs

	la $a0, comma				# Carica in $a0 l'indirizzo della virgola
	syscall					# Stampa la stringa virgola

	move $a0, $s6				# Copia in $a0 il valore immediato/offset
	li $v0, 1				# Seleziona codice di servizio per stampa intero
	syscall					# Stampa valore immediato/offset
						# Esegue il ritorno della procedura
RP:
	move $v0, $t0				# Ritorna in $v0 la newline
	jr $ra					# Ritorna al chiamante