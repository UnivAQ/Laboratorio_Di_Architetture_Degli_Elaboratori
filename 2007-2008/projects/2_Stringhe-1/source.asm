.data 

Vuno: .space 512
Vdue: .space 512

TRUE: .asciiz "vero\n"

FALSE: .asciiz "falso\n"

STAMPA: .asciiz "inserire la lunghezza dell'array\n"

ARRAYuno: .asciiz "inserire gli elementi del primo array separati da uno spazio e infine premere invio\n"
ARRAYdue: .asciiz "inserire gli elementi del secondo array separati da uno spazio e infine premere invio\n"

ERR: .asciiz "Valore non corretto\n"
.text

.globl main


main:

j insk

ser:
li $v0, 4    # messaggio di errore nell'inserimento di k
la $a0, ERR
syscall
insk:

li $v0, 4              # inserire un valore
la $a0, STAMPA
syscall

li $v0,5                #inserimento di k
syscall
add $s1,$v0,$zero       #k viene messo in $s1
slt $t0,$zero, $s1
beq $t0,$zero,ser       #se k non è >0 va a stampare un messaggio di errore

insprimoarr:

li $v0, 4                   #stringa per l'inserimento degli elementi dell'array
la $a0, ARRAYuno
syscall
 
li $v0, 8                   #inserimento primo array
la $a0, Vuno
li $a1, 512
syscall
add $t1,$zero, $zero        #azzera $t1 per poter fare il controllo sul primo array

su:

lb $t0,0($a0)               #
addi $a0,$a0,1
addi $t5, $zero, 32         #                
beq $t0, $zero, finearray   #   codice di controllo sul primo array
bne $t0, $t5, su            # 
nop
addi $t1,$t1, 1             #
j su


finearray:
nop                              
addi $t1, $t1, 1            #$t1 controlla il numero di spazi.Saranno k-1 se l'inserimento è corretto
                            #si aumenta $t1 di uno cosi si può fare il confronto con k 
bne $t1, $s1, insprimoarr   #confronto con k
la $s4, Vuno                #copia in $s4 l'indirizzo di partenza del primo array


insecondoarr:

li $v0, 4              # stringa per l'inserimento degli elementi dell'array
la $a0, ARRAYdue
syscall

li $v0, 8              #inserimento secondo array
la $a0, Vdue
li $a1, 512
syscall
add $t1,$zero, $zero   #azzera $t1 per poter fare il controllo sul primo array

sudue:

lb $t0,0($a0)                     #
addi $a0,$a0,1
addi $t5, $zero, 32               #
beq $t0, $zero, finearraydue      #   codice di controllo sul secondo array
bne $t0, $t5, sudue               #
nop
addi $t1,$t1, 1                   #
j sudue

finearraydue:
nop
addi $t1, $t1, 1               #$t1 controlla il numero di spazi.Saranno k-1 se l'inserimento è corretto
                               #si aumenta $t1 di uno cosi si può fare il confronto con k 
bne $t1, $s1, insecondoarr     #confronto con k
la $s0, Vdue                   #copia in $s0 l'indirizzo di partenza del secondo array

add $s2, $zero, $zero          #$s2 è un il contatore fondamentale del programma



add $t8, $s1, $s1
add $t8, $t8, $t8

sub $sp, $sp, $t8              #alloca k posizioni nello stack per andare a memorizzare il numero d vocali di ogni stringa del primo array
add $t6, $sp, $zero            #fa una copia di $sp

RICOMINCIA:

add $t0, $zero, $zero          #
add $t1, $zero, $zero          #
add $t2, $zero, $zero          #azzera i contatori delle 5 vocali
add $t3, $zero, $zero          #
add $t4, $zero, $zero          #

FOR:

lb $a0, 0($s0)             #carica il primo carattere
addi $s0, $s0, 1           #incremento del puntatore
addi $t5, $zero, 32
beq $a0, $t5, ESCI         #controllo fine stringa

beq $a0, $zero, ESCI       #controllo fine array

jal CONFRONTO

nop
slt $t7, $t7, $zero
beq $t7, $zero, FOR        # cicla il for

nop
ESCI:
                                                                                      #Questa parte di codice viene fatta
add $t0, $t0, $t1                                                                     #ogni volta che finiamo di leggere 
add $t0, $t0, $t2                                                                     #una stringa,cioè k volte.
add $t0, $t0, $t3                                                                     #Infatti il salto all'etichetta ESCI
add $t0, $t0, $t4         #in $t0 risulterà la somma di tutti i contatori delle vocali#è solo nel caso di fine stringa o 
                                                                                      #fine array (che comunque è un fine
addi $s2, $s2, 1                                                                      #stringa).
beq $s2, $s1, ETI         #da k in poi non salterà piu a ETI                          #Sfruttiamo questa logica (usando $s2  
                                                                                      #come contatore) per contare le volte 
                                                                                      #che passiamo da questo pezzo di codice.
slt $t8, $s1, $s2         #da k in poi salterà sempre a ETIC                          #Quando $s2=$s1 (cioè k) scambieremo il
bne $t8, $zero, ETIC                                                                  #puntatore al primo array con il puntatore
                                                                                      #al secondo array e ritorneremo all'inizio
sw $t0, 0($t6)            #memorizza nello stack se non salta ne a ETI ne a ETIC      #sfruttando il codice già scritto per il 
addi $t6, $t6, 4                                                                      #primo array, anche col secondo array

j RICOMINCIA

ETI:

sw $t0, 0($t6)            #memorizza il numero di vocali di ogni stringa nello stack
addi $t6, $t6, 4          #e passa alla word successiva da riempire

add $s3, $zero, $s0       #scambiamo i puntatori
add $s0, $zero, $s4       #ci salviamo in $s3 il vecchio puntatore (solo per non perdere informazioni) 

j RICOMINCIA

ETIC:

add $t8, $s1, $s1         #
add $t8, $t8, $t8         #$t6 = $sp + 4*k (si leggerà lo staqck a partire dall'ultimo valore inserito)
add $t6, $sp, $t8         #

PARTE:

beq $t6, $sp, CONTROLLO   #se ($t6=$sp) si è già letto l'ultimo valore nello stack e possiamo saltare a CONTROLLO

addi, $t6, $t6, -4        #
lw $t7, 0($t6)            #carica il valore all'intero dallo stack 
nop                       #serve un ritardo altrimenti fa prima il controllo e poi carica il valore in $t7
slt $t8, $t0, $t7         #
beq $t8, $zero, FALSO     #se il valore caricato ($t7) è minore di quello su cui stiamo lavorando ($t0) restituisce FALSE
j PARTE

CONTROLLO:
                          #
add $t8, $s1, $s1         #se il contatore $s2 è arrivato a 2*k non ci sono più valori nello stack e restituisce TRUE
                          #
beq $t8, $s2, VERO        #
                          #
j RICOMINCIA

FALSO:

li $v0, 4
la $a0, FALSE
syscall                   #restituisce FALSE

j FINE

VERO:

li $v0, 4
la $a0, TRUE
syscall                   #restituisce TRUE

j FINE


CONFRONTO:

add $t9, $zero, $zero
                          #confronto con le vocali
addi $t9, $zero, 65
beq $a0, $t9, ESCIa       #a
addi $t9, $t9, 32
beq $a0, $t9, ESCIa       #A
addi $t9, $zero, 69
beq $a0, $t9, ESCIe       #e
addi $t9, $t9, 32
beq $a0, $t9, ESCIe       #E
addi $t9, $zero, 73 
beq $a0, $t9, ESCIi       #i
addi $t9, $t9, 32
beq $a0, $t9, ESCIi       #I
addi $t9, $zero, 79 
beq $a0, $t9, ESCIo       #o
addi $t9, $t9, 32
beq $a0, $t9, ESCIo       #O
addi $t9, $zero, 85
beq $a0, $t9, ESCIu       #u
addi $t9, $t9, 32
beq $a0, $t9, ESCIu       #U
 
j USCITA

ESCIa:

nop
addi $t0, $zero, 1
j USCITA

ESCIe:

nop
addi $t1, $zero, 1
j USCITA

ESCIi:

nop
addi $t2, $zero, 1
j USCITA

ESCIo:

nop
addi $t3, $zero, 1
j USCITA

ESCIu:

nop
addi $t4, $zero, 1

USCITA:


jr $ra



FINE:

li $v0, 10
syscall