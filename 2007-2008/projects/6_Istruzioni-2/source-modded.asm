.data

Inputstr: .asciiz "Inserire un codice binario di 32 bit: "

Errore1: .asciiz "ERRORE!!! CODICE INSERITO NON VALIDO, INSERIRE 32 BIT BINARI!!!"

ErroreShamt: .asciiz "ERRORE!!! IL CODICE BINARIO INSERITO NEL CAMPO SHAMT DEVE ESSERE '00000' PER UN'ISTRUZIONE FORMATO R!!!"

ErroreFunct: .asciiz "ERRORE!!! IL CODICE BINARIO INSERITO NEGLI ULTIMI SEI BIT NON CORRISPONDE AD UN'ISTRUZIONE MIPS!!!"

ErroreOperation: .asciiz "ERRORE!!! IL CODICE BINARIO INSERITO NEI PRIMI SEI BIT NON CORRISPONDE AD UN'ISTRUZIONE MIPS!!!"

OkCode: .asciiz "Il codice inserito e' binario ed e' di 32 bit =)\n"

StrFinale: .asciiz "Il codice finale e': "

Continue: .asciiz "Si vuole convertire un'altro codice binario?\n"

Spazio: .asciiz " "

ParAp: .asciiz "("

ParCh: .asciiz ")"

Acapo: .asciiz "\n"

Virgola: .asciiz ","


##############################################################################################################
####################################################  Istruzioni FORMATO R  ##########################################


PosFunct: .word 32, 33, 36, 39, 37, 4, 7, 6, 34, 35, 38, 42, 43


Funct: .word f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12

f0: .asciiz "add "
f1: .asciiz "addu "
f2: .asciiz "and "
f3: .asciiz "nor "
f4: .asciiz "or "
f5: .asciiz "sllv "
f6: .asciiz "srav "
f7: .asciiz "srlv "
f8: .asciiz "sub "
f9: .asciiz "subu "
f10: .asciiz "xor "
f11: .asciiz "slt "
f12: .asciiz "sltu "



##############################################################################################################
#################################################  Registri  ######################################################


Register: .word r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31

r0: .asciiz "$zero"
r1: .asciiz "$at"
r2: .asciiz "$v0"
r3: .asciiz "$v1"
r4: .asciiz "$a0"
r5: .asciiz "$a1"
r6: .asciiz "$a2"
r7: .asciiz "$a3"
r8: .asciiz "$t0"
r9: .asciiz "$t1"
r10: .asciiz "$t2"
r11: .asciiz "$t3"
r12: .asciiz "$t4"
r13: .asciiz "$t5"
r14: .asciiz "$t6"
r15: .asciiz "$t7"
r16: .asciiz "$s0"
r17: .asciiz "$s1"
r18: .asciiz "$s2"
r19: .asciiz "$s3"
r20: .asciiz "$s4"
r21: .asciiz "$s5"
r22: .asciiz "$s6"
r23: .asciiz "$s7"
r24: .asciiz "$t8"
r25: .asciiz "$t9"
r26: .asciiz "$k0"
r27: .asciiz "$k1"
r28: .asciiz "$gp"
r29: .asciiz "$sp"
r30: .asciiz "$fp"
r31: .asciiz "$ra"


##############################################################################################################
############################################### Istruzioni FORMATO I ################################################


PosOp: .word 35, 43, 8, 13, 14, 12, 15, 9, 10, 11

OperationI: .word o0, o1, o2, o3, o4, o5, o6, o7, o8, o9

o0: .asciiz "lw "
o1: .asciiz "sw "
o2: .asciiz "addi "
o3: .asciiz "ori "
o4: .asciiz "xori "
o5: .asciiz "andi "
o6: .asciiz "lui "
o7: .asciiz "addiu "
o8: .asciiz "slti "
o9: .asciiz "sltiu "


###############################################################################################################
#############################################  Stringa immessa  ####################################################


Resultstr: .asciiz ""


##############################################################################################################
##############################################################################################################

.text
.globl main

main: 		li $v0, 4
		la $a0, Inputstr
		syscall					# Stampa il messaggio di etichetta "Inputstr"
		li $v0, 8				# Chiamo la syscall che prende in input una stringa
		la $a0, Resultstr			# Carico l'indirizzo di destinazione della stringa che verra'  immessa
		li $a1, 34				# Carico in $a1 il numero massimo dei caratteri accettati dalla syscall (E' stato scelto 34 e non 33
							# per poter gestire l'errore della lunghezza della stringa immessa)
		syscall					# Prendo in input la stringa
		la $a0, Resultstr			# Carico Resultstr in $a0
		jal Control				# Salto alla procedura di controllo
		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 5				# Carico in $a1 l'"indirizzo" da cui voglio che il controllo dei 6 bit parta
		li $a2, 6				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo OP e convertire i bit contenuti in decimale
		add $t0, $zero, $v0			# Metto il risultato decimale di OP dentro $t0
		bne $t0, $zero, IndirFormI		# Se il valore restituito (in decimale) dalla lettura del campo OP e' 0, proseguo alla riga successiva, altrimenti salto al formato I
		la $a0, Resultstr			# Carico Resultstr in $a0
		jal FormatoR				# Chiamo la procedura per analizzare secondo il FORMATO R
		jal PrintContinue			# Chiamo la procedura che fa stampare il messaggio per scegliere se rieseguire di nuovo il programma
		j Esci					# Termino il programma


IndirFormI:	add $a0, $zero, $t0			# Carico il valore del campo OP convertito in decimale in $a0 per passarlo alla procedura FormatoI
		jal FormatoI				# Chiamo la procedura FormatoI
		jal PrintFinalStr				# Chiamo la procedura che stampa la stringa cosi' come risulta alla fine dell'esecuzione del programma
		jal PrintContinue			# Chiamo la procedura che fa stampare il messaggio per scegliere se rieseguire di nuovo il programma
		j Esci					# Termino il programma


###############################################################################################################
################################### Procedura per il controllo errori di input (Lunghezza - Coerenza bit)  ####################################

	
Control: 		li $t0, 0				# Inizializzo il contatore per vedere di quanti caratteri e' composta la stringa
			
	WhileControl: 	lb $t1, 0($a0)			# Carico il carattere di posizione $a0
			beq $t1, 0x0A, ReplaceLF	# Controllo se il byte letto e' = a 10 (LF "Line Feed" in ASCII), e se lo e' lo sovrascrivo con 0
			beq $t1, $zero, Contrlung	# Controllo se sono a fine stringa
			beq $t1, 48, Whileplus		# Controllo se il carattere letto e' = 0, e se lo e' passo al successivo
			beq $t1, 49, Whileplus		# Controllo se il carattere letto e' = 1, e se lo e' passo al successivo
			j PrintErrore			# Se non ho riconosciuto nulla di valido salto alla stampa del messaggio di errore

ReplaceLF:	sb $zero, 0($a0)			# Sovrascrivo il byte pari a 0x0A con 0
		j WhileControl				# Ritorno al While senza passare pero' al byte successivo (perche' siamo gia' a fine stringa)


Contrlung: 	beq $t0, $zero, Esci			# Se il contatore e' = 0, vuol dire che non abbiamo inserito niente, quindi usciamo
		bne $t0, 32, PrintErrore		# Se il contatore e' diverso da 32 (cioe' se la stringa e > o < di 32) salto a PrintErrore
		la $a0, OkCode			# Carico il messaggio che conferma la corretta immissione del codice binario
		li $v0, 4				# Chiamo la syscall
		syscall					# Stampo il messaggio OkCode
		jr $ra					# Torno alla riga successiva a "jal Control"

	Whileplus:	addi $a0, $a0, 1		# Passo al carattere successivo
			addi $t0, $t0, 1			# Incremento il contatore dei caratteri
			j WhileControl			# Continuo con il ciclo
		

#PER SPIM#	PrintErrore:	li $v0, 4
#				la $a0, Errore1
#				syscall			# Stampa il messaggio di errore di etichetta "Errore1"
#				addi $sp, $sp, 4	
#				j main			# Ritorna al main per far reinserire nuovamente il codice


PrintErrore:	 	li $v0, 31
			li $a0, 67
			li $a1, 1000
			li $a2, 121
			li $a3, 127
			syscall				# Riproduce suono di errore
			li $v0, 55
			la $a0, Errore1
			li $a1, 0
			syscall				# Stampa il messaggio di errore di etichetta "Errore1"
			addi $sp, $sp, 4		
			j main				# Ritorna al main per far reinserire nuovamente il codice


##############################################################################################################
#################################  Procedura che stampa le istruzioni codificate in FORMATO R  ###############################


FormatoR:	addi $sp, $sp, 4			# Libero lo stack
		sw $ra, 0($sp)				# Salvo $ra nello stack perche' la procedura FormatoR e' chiamante - chiamato
		
		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 25				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 6 bit parta, in questo caso controllo SHAMT
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo SHAMT e convertire i bit contenuti in decimale
		bne $v0, $zero, ErroreCampoShamt	# Se SHAMT contiene un valore stampo errore perche deve essere 0 per il FORMATO R da noi implementato
		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 31				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 6 bit parta
		li $a2, 6				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo FUNCT e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di FUNCT dentro $a0
		la $a1, PosFunct			# Carico dentro $a1 l'indirizzo dell'array PosFunct (situata nel .data)
		li $a2, 0				# Inizializzo il contatore che verra'  utilizzato all'interno di FindFunct
		jal FindFunct				# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in FUNCT

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 20				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RD e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RD dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RD
		jal PrintVirgola				# Stampo il carattere ","
		jal PrintSpazio				# Stampo uno spazio vuoto

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 10				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RS e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RS dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RS
		jal PrintVirgola				# Stampo il carattere ","
		jal PrintSpazio				# Stampo uno spazio vuoto

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 15				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RT e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RT dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RT

		lw $ra, 0($sp)				# Ripristino $ra dallo stack
		addi $sp, $sp, 4			# Resetto lo stack
		jr $ra					# Torno alla riga successiva a "jal FormatoR"


###################################################################################################
################# Procedura che cerca l'istruzione corrispondente al valore binario immesso nel campo FUNCT e la stampa ################


# Il contatore interno del ciclo "FindFunct" e' stato inizzializzato fuori dalla procedura, passandolo come parametro in $a2, in quanto se lo si fosse inizializzato
# all'interno del ciclo, quest'ultimo avrebbe iterato infinitamente perchè il contatore sarebbe stato rinizializzato ad ogni iterazione.


FindFunct:	lw $t1, 0($a1)				# Carico in $t1 la parola puntata da $a1
		beq $a0, $t1, PrintFunct		# Se il contenuto decimale di FUNCT e' uguale a $t1 salto a PrintFunct, altrimenti proseguo
		addi $a2, $a2, 4			# Incremento il contatore di 4
		addi $a1, $a1, 4			# Passo alla word successiva
		beq $a2, 52, ErroreCampoFunct	# Controllo di essere ancora all'interno di PosFunct e, se ho esaurito le word, stampo ErroreFunct
		j FindFunct				# Continuo con il ciclo
	

PrintFunct:	la $t1, Funct				# Carico l'indirizzo dell'array Funct in $t1
		add $a2, $a2, $t1			# Seleziono la $a2esima parola
		lw $a0, 0($a2)				# Carico la parola puntata da $a2 in $a0
		li $v0, 4				
		syscall					# Stampo la Funct corrispondente al codice inserito
		jr $ra					# Torno alla riga successiva a "jal FindFunct"


##################################################################################################
##################################### Stampe degli errori campi SHAMT e FUNCT #################################

#PER SPIM#	 ErroreCampoFunct:	li $v0, 4		
#					la $a0, ErroreFunct
#					syscall				# Stampa il messaggio di errore di etichetta "ErroreFunct"
#					addi $sp, $sp, 4		# Resetto lo stack
#					j main				# Ritorna al main per far reinserire nuovamente il codice

#PER SPIM#	 ErroreCampoShamt:	li $v0, 4		
#					la $a0, ErroreShamt
#					syscall				# Stampa il messaggio di errore di etichetta "ErroreShamt"
#					addi $sp, $sp, 4		# Resetto lo stack
#					j main				# Ritorna al main per far reinserire nuovamente il codice


ErroreCampoShamt:	li $v0, 31
			li $a0, 67
			li $a1, 1000
			li $a2, 121
			li $a3, 127
			syscall				# Riproduce suono di errore
			li $v0, 55
			la $a0, ErroreShamt
			li $a1, 0
			syscall				# Stampa il messaggio di errore di etichetta "ErroreShamt"
			addi $sp, $sp, 4		# Resetto lo stack
			j main				# Ritorna al main per far reinserire nuovamente il codice

ErroreCampoFunct:	li $v0, 31
			li $a0, 67
			li $a1, 1000
			li $a2, 121
			li $a3, 127
			syscall				# Riproduce suono di errore
			li $v0, 55
			la $a0, ErroreFunct
			li $a1, 0
			syscall				# Stampa il messaggio di errore di etichetta "ErroreFunct"
			addi $sp, $sp, 4		
			j main				# Ritorna al main per far reinserire nuovamente il codice


##############################################################################################################
################################  Procedura che stampa le istruzioni codificate in FORMATO I  #################################


FormatoI:	addi $sp, $sp, 4			# Libero lo stack
		sw $ra, 0($sp)				# Salvo $ra nello stack perche' la procedura Formato e' chiamante - chiamato

		la $a1, PosOp				# Carico l'indirizzo dell'array PosOp
		jal FindOp				# Chiamo la procedura FindOp

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 15				# Carico in $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RT e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RT dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RT
		jal PrintVirgola				# Stampo il carattere ","
		jal PrintSpazio				# Stampo uno spazio vuoto
		
		jal SedicEquals1			# Chiamo la procedura "SedicEquals1" per controllare se il campo ADDRESS e' negativo e per stampare il valore corrispondente
		
		li $v0, 4
		la $a0, ParAp
		syscall					# Stampo il carattere "("

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 10				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RS e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RS dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RS

		li $v0, 4
		la $a0, ParCh
		syscall					# Stampo il carattere ")"
		
		lw $ra, 0($sp)				# Ripristino $ra dallo stack
		addi $sp, $sp, 4			# Resetto lo stack
		jr $ra					# Torno alla riga successiva a "jal FormatoI"
	

##############################################################################################################
######################## Procedura che stampa il valore convertito in decimale del campo IMMEDIATE/ADDRESS ##############################


Print16:		li $v0, 1			# Chiamo la syscall per la stampa di un intero 
			syscall				# Stampo il campo IMMEDIATE/ADDRESS
							# $a0 e' assente in quanto e' gia' stato caricato prima della chiamata alla procedura
			jr $ra				# Torno al chiamante


###########################################################################################################
######################################### Procedura che stampa i registri #############################################


PrintRegister:		la $t1, Register			# Carico dentro $t1, l'indirizzo della tabella Register
			add $a0, $a0, $a0		# Effettuo $a0 x 2 e metto il risultato in $a0
			add $a0, $a0, $a0		# Effettuo $a0 x 2 e metto il risultato in $a0 per poter poi selezionare la $a0esima word
			add $t0, $t1, $a0		# Sommo 4*$a0 e $t1 per selezionare la word puntata da $a0
			lw $a0, 0($t0)			# La carico nel registro $a0
			li $v0, 4			# Chiamo la syscall per stampare stringhe
			syscall				# Stampo la stringa corrispondente all'etichetta selezionata
			jr $ra				# Torno alla riga successiva a "jal PrintRegister"


##############################################################################################################
######################## Procedura che individua l’OP corrispondente al codice binario inserito nei primi 6 bit ################################


FindOp:	li $t2, 0					# Inizializzo il contatore $t2
		add $t1, $zero, $a1			# Copio $a1, in $t1
		beq $a0, 35, PrintOp			# Se $a0, e' = 35, stampo "lw"
		addi $t2, $t2, 4				# Incremento il contatore di 4 perche' passo alla word successiva
		add $t1, $t1, 4				# Passo alla word successiva
		beq $a0, 43, PrintOp			# Se $a0, e' = 43, stampo "sw"
		addi $t2, $t2, 4				# Incremento il contatore di 4 perche' passo alla word successiva
		add $t1, $t1, 4				# Passo alla word successiva
		j FindOp2				# Salto a FindOp2 se il campo OP non era uguale a nessuno dei casi precedenti
		

PrintOp: 	la $t0, OperationI			# Carico l'indirizzo dell' array delle Istruzioni in formato I
		add $t2, $t0, $t2			# Seleziono la $t2esima word dell' array OperationI
		lw $a0, 0($t2)				# Carico la word in $a0
		li $v0, 4				# Chiamo la syscall
		syscall					# Stampo la word
		jr $ra					# Torno alla riga successiva a "jal FindOp"


FindOp2:	lw $t3, 0($t1)				# Carico la word puntata da $t1
		beq $a0, $t3, PrintOp2			# Se la word caricata e' uguale al contenuto in decimale del campo OP salto a PrintOp2
		addi $t2, $t2, 4				# Incremento il contatore di 4 perche' passo alla word successiva
		add $t1, $t1, 4				# Passo alla word successiva
		beq $t2, 52, ErroreFormatoI		# Se il contatore e' arrivato a fine tabella salto a ErroreFormatoI per restituire un errore
		j FindOp2				# Continuo con il ciclo


PrintOp2:	beq $t3, 9, Unsigned			# Se la word caricata e' uguale a 9 ("addiu") stampo l'OP e salto a Unsigned
		beq $t3, 11, Unsigned			# Se la word caricata e' uguale a 10 ("sltiu") stampo l'OP e salto a Unsigned
		la $t0, OperationI			# Carico l'indirizzo dell' array delle Istruzioni in FORMATO I
		add $t0, $t0, $t2			# Seleziono la $t2esima word della tabella OperationI
		lw $a0, 0($t0)				# Carico la word puntata da $t0 in $a0
		li $v0, 4				# Chiamo la syscall
		syscall					# Stampo la word
		j FormatoI2

Unsigned:	la $t0, OperationI			# Carico l'indirizzo della tabella delle Istruzioni in formato I
		add $t0, $t0, $t2			# Seleziono la $t2esima word della tabella OperationI
		lw $a0, 0($t0)				# Carico la word in $a0
		li $v0, 4				# Chiamo la syscall
		syscall					# Stampo la word
		j FormatoI3
		

##############################################################################################################
####################################  Procedura per le istruzioni con segno in FORMATO I ######################################


FormatoI2: 	la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 15				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RT e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RT dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RT
		jal PrintVirgola				# Stampo ","
		jal PrintSpazio				# Stampo uno spazio vuoto

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 10				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RS e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RS dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RS
		jal PrintVirgola				# Stampo il carattere ","
		jal PrintSpazio				# Stampo uno spazio vuoto
		
		jal SedicEquals1			# Chiamo la procedura che controlla se il bit piu' significativo del campo IMMEDIATE e' 1
		lw $ra, 0($sp)				# Ripristino $ra dallo stack
		addi $sp, $sp, 4			# Resetto lo stack
		jr $ra					# Torno alla riga successiva a "jal FormatoI"


##############################################################################################################
### Procedura che controlla, prima se il primo bit del campo IMMEDIATE/ADDRESS e' 1, e se lo e' complementa a 2 e poi stampa il campo in decimale #######


SedicEquals1:	addi $sp, $sp, -4			# Alloco spazio nello stack
		sw $ra, 0($sp)				# Salvo $ra nello stack
		la $a0, Resultstr			# Carico in $a0 l'indirizzo della stringa binaria immessa
		lb $t0, 16($a0)				# Carico il primo byte del campo IMMEDIATE/ADDRESS (bit di segno)
		bne $t0, 49, EsciSedic1		# Se il bit di segno e' 1 proseguo, se e' 0 proseguo senza complementare il numero del campo IMMEDIATE/ADDRESS

GotoCompl: 	jal Conta1				# Chiamo la procedura per contare gli 1 presenti nel campo IMMEDIATE/ADDRESS
		la $a0, Resultstr			# Carico in $a0 l'indirizzo della stringa binaria immessa
		add $a1, $zero, $v0			# Carico il numero degli 1 contati dentro $a1 per passarlo alla procedura Complemento2
		jal Complemento2			# Chiamo la procedura per complementare a 2 il campo IMMEDIATE/ADDRESS
		la $a0, Resultstr			# Carico in $a0 l'indirizzo della stringa binaria immessa
		li $a1, 31				# Carico in $a1, il punto di partenza da cui iniziare la lettura dei 16 bit del campo IMMEDIATE/ADDRESS
		li $a2, 15				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo IMMEDIATE/ADDRESS e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Copio il valore decimale restituito dalla conversione del campo IMMEDIATE/ADDRESS in $a0
		sub $a0, $zero, $a0			# Rendo negativo il numero decimale
		jal Print16				# Lo stampo
		lw $ra, 0($sp)				# Ripristino $ra dallo stack
		addi $sp, $sp, 4			# Resetto lo stack
		jr $ra					# Torno alla riga successiva a "jal SedicEquals1"

EsciSedic1:	la $a0, Resultstr			# Carico in $a0 l'indirizzo della stringa binaria immessa
		li $a1, 31				# Carico in $a1, il punto di partenza da cui iniziare la lettura dei 16 bit del campo IMMEDIATE/ADDRESS
		li $a2, 15				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo IMMEDIATE/ADDRESS e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di IMMEDIATE/ADDRESS dentro $a0
		jal Print16				# Chiamo la procedura per far stampare il valore decimale corrispondente al codice immesso in IMMEDIATE/ADDRESS
		lw $ra, 0($sp)				# Ripristino $ra dallo stack
		addi $sp, $sp, 4			# Resetto lo stack
		jr $ra					# Torno alla riga successiva a "jal SedicEquals1"


##############################################################################################################
################################ Procedura che conta il numero degli 1 presenti negli ultimi 15 bit ##############################


Conta1:	li $v0, 0				# Inizializzo $v0

	WhileCont1:	lb $t0, 17($a0)			# Carico il byte di indice $a0 a partire dalla 17esima posizione
			beq $t0, $zero, EsciCont1	# Se siamo a fine stringa esco dalla procedura
			beq $t0, 49, Cont1Plus		# Se il byte letto e' 1 salto a Cont1Plus che incrementa il contatore
			addi $a0, $a0, 1		# Passo al byte successivo
			j WhileCont1			# Continuo con il ciclo


	Cont1Plus:	addi $v0, $v0, 1		# Incremento il contatore degli 1
			addi $a0, $a0, 1		# Passo al byte successivo
			j WhileCont1			# Continuo con il ciclo

EsciCont1:	jr $ra					# Torno alla riga successiva a "jal Conta1"
				

##############################################################################################################
############################### Procedura che complementa a 2 il campo IMMEDIATE/ADDRESS ###################################


Complemento2:	add $t1, $zero, $a1		# Copio il numero degli 1 contati nel campo IMMEDIATE/ADDRESS in $t1
			addi $t1, $t1, -1		# Decremento il numero degli 1, in quanto dobbiamo complementare fino all'ultimo 1 escluso
			
		WhileCompl2:	lb $t0, 17($a0)		# Carico il byte di indirizzo $a0, a partire dalla 17esima posizione
				beq $t0, 48, Conv0	# Se il byte letto e' 0 salto a Conv0 per complementarlo
				beq $t0, 49, Conv1	# Se il byte letto e' 1 salto a Conv1 per complementarlo
				j EsciCompl2		# Altrimenti esco dalla procedura		

Conv0:		li $t0, 49				# Carico il codice ASCII di 1 in $t0
		sb $t0, 17($a0)			# Sovrascrivo il carattere complementato nella $a0esima posizione a partire dal 17esimo byte
		addi $a0, $a0, 1			# Passo al byte successivo
		j WhileCompl2				# Continuo con il ciclo

Conv1:		beq $t1, $zero, EsciCompl2		# Se il contatore degli 1 e' 0 esco perche da qui in poi non devo piu' complementare (ultimo 1)
		li $t0, 48				# Carico il codice ASCII di 0 in $t0
		sb $t0, 17($a0)			# Sovrascrivo il carattere complementato nella $a0esima posizione a partire dal 17esimo byte
		addi $a0, $a0, 1			# Passo al byte successivo
		addi $t1, $t1, -1			# Decremento il contatore degli 1
		j WhileCompl2				# Continuo con il ciclo


EsciCompl2:	jr $ra					# Torno alla riga successiva a "jal Complemento2"


##############################################################################################################
####################################  Procedura per le istruzioni unsigned in FORMATO I #######################################


FormatoI3: 	la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 15				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RT e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RT dentro $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RT
		jal PrintVirgola				# Stampo ","
		jal PrintSpazio				# Stampo uno spazio vuoto

		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 10				# Carico dentro $a1 l'"indirizzo" da cui voglio che il controllo dei 5 bit parta
		li $a2, 5				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo RS e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di RS in $a0
		jal PrintRegister			# Chiamo la procedura per far stampare l'istruzione corrispondente al codice immesso in RS
		jal PrintVirgola				# Stampo il carattere ","
		jal PrintSpazio				# Stampo uno spazio vuoto
		
		
		la $a0, Resultstr			# Carico Resultstr in $a0
		li $a1, 31				# Carico in $a1 l'"indirizzo" da cui voglio che il controllo dei 16 bit parta
		li $a2, 15				# Carico in $a2, il numero che indica alla procedura "LetturaCampo" da quanti bit quel campo e' composto
		jal LetturaCampo			# Chiamo la procedura per leggere il campo IMMEDIATE senza segno e convertire i bit contenuti in decimale
		add $a0, $zero, $v0			# Metto il risultato decimale di IMMEDIATE in $a0
		jal Print16
		lw $ra, 0($sp)				# Ripristino $ra dallo stack
		addi $sp, $sp, 4			# Resetto lo stack
		jr $ra					# Torno alla riga successiva a "jal FormatoI"


##############################################################################################################
################################# Stampa un messaggio di errore per il FORMATO I ##################################


#PER SPIM#	 ErroreFormatoI:	li $v0, 4		
#					la $a0, ErroreOperation
#					syscall				# Stampa il messaggio di errore di etichetta "ErroreOperation"
#					addi $sp, $sp, 4		# Resetto lo stack
#					j main				# Ritorna al main per far reinserire nuovamente il codice


ErroreFormatoI:	li $v0, 31
			li $a0, 67
			li $a1, 1000
			li $a2, 121
			li $a3, 127
			syscall				# Riproduce suono di errore
			li $v0, 55
			la $a0, ErroreOperation
			li $a1, 0
			syscall				# Stampa il messaggio di errore di etichetta "ErroreOperation"
			addi $sp, $sp, 4		
			j main				# Ritorna al main per far reinserire nuovamente il codice


##############################################################################################################
 ###################################### Procedura che stampa uno spazio vuoto #########################################	


PrintSpazio:	li $v0, 4
		la $a0, Spazio
		syscall					# Stampo uno spazio vuoto
		jr $ra					# Torno alla riga successiva a "jal PrintSpazio"


##############################################################################################################
######################################## Procedura che stampa il carattere "," ##########################################


PrintVirgola:	li $v0, 4
		la $a0, Virgola
		syscall					 # Stampo il carattere ","
		jr $ra					# Torno alla riga successiva a "jal PrintVirgola"


##############################################################################################################
###################################### Procedura che stampa la stringa a fine esecuzione ##################################


PrintFinalStr:		li $v0, 4
			la $a0, Acapo
			syscall				# Stampo il carattere "/n" per andare a capo
		
			li $v0, 4
			la $a0, StrFinale
			syscall				# Stampo il messaggio di etichetta StrFinale

			li $v0, 4
			la $a0, Resultstr
			syscall				# Stampo la stringa immessa che risulta dopo l'esecuzione dell'intero programma
			
			li $v0, 4
			la $a0, Acapo
			syscall				# Vado a capo nuovamente
			jr $ra				# Torno alla riga successiva a "jal PrintFinalStr"


##############################################################################################################
#################################### Procedura che chiede se si vuole rieseguire il programma ###############################


#PER SPIM#	 PrintContinue:		li $v0, 4		
#					la $a0, Continue
#					syscall				# Stampa il messaggio di etichetta "Continue"
#					li $v0, 12
#					syscall
#					beq $a0, 121, main		# Se il carattere di scelta e' "y" rieseguo il programma
#					jr $ra				# Torno alla riga successiva a "jal PrintContinue"


PrintContinue:		li $v0, 31
			li $a0, 67
			li $a1, 1000
			li $a2, 120
			li $a3, 127
			syscall				# Riproduce suono
			li $v0, 50
			la $a0, Continue
			syscall				# Stampo il messaggio che chiede se si vuole effettuare una nuova esecuzione del programma
			beq $a0, $zero, main		# Se si e' premuto il tasto "Si" ($a0 = 0) ritorno al main per rieseguire il programma
			jr $ra				# Altrimenti torno alla riga successiva a "jal PrintContinue"


##############################################################################################################
########################## Procedura che legge campi e converte il contenuto binario in decimale #############################


LetturaCampo:		add $a0, $a0, $a1		# Seleziono il byte di indice $a1
			add $v0, $zero, $zero		# Azzero $v0
			li $t0, 1				# Inizializzo il registro per la registrazione temporanea dei quadrati a 1
			add $t1, $zero, $a2		# Inizializzo il contatore a 6 per poi andarlo a decrementare ad ogni esecuzione del ciclo

	
        While:   	lb $t2, 0($a0)				# Carico il byte di indice $a0
		beq $t1, $zero, EsciCampo		# Se il contatore e' arrivato a 0 (fine ciclo) stampo il quadrato ottenuto
		beq $t2, 49, Uno			# Se il byte letto e' = 1 allora salto a "Uno"
		beq $t2, 48, Zero			# Se il byte letto e' = 0 allora salto a "Zero"


          Uno:	add $v0, $v0, $t0			# Prendo il quadrato corrispondente alla posizione ricoperta dall'1 attuale
		add $t0, $t0, $t0			# Calcolo il quadrato successivo
		addi $a0, $a0, -1			# Decremento $a0 per selezionare il byte precedente
		addi $t1, $t1, -1			# Decremento il contatore
		j While					# Continuo con il ciclo


         Zero:	add $t0, $t0, $t0			# Calcolo il quadrato successivo (senza pero' copiarlo in $v0, in quanto abbiamo letto uno 0)
		addi $a0, $a0, -1			# Decremento $a0 per selezionare il byte precedente
		addi $t1, $t1, -1			# Decremento il contatore
		j While					# Continuo con il ciclo


EsciCampo:	jr $ra					# Torno alla riga successiva a "jal LetturaCampo"


##################################################################################################
##################################################################################################


Esci: 		li $v0, 10
		syscall					# Termina il programma
