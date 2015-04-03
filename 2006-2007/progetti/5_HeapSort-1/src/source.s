.data

STRINGA_ES: .asciiz "pso49dnie65hfm\n"

SCELTA: .asciiz "Vuoi inserire una nuova stringa? (s/n) "

SCELTA2: .asciiz "Vuoi cambiare un valore alla stringa? (s/n) "

SCELTA3: .asciiz "Inserisci il nuovo valore..."

SCELTA4: .asciiz "Inserisci la posizione del vettore..."

SCELTA5: .asciiz "La stringa finale è la seguente..."

STRINGA_LUNG: .asciiz "Lunghezza della stringa da inserire: "

STRINGA_INS: .asciiz "Inserisci la stringa: "

ERROR1: .asciiz "Il carattere inserito non è correto! Riprova...\n"

ERROR2: .asciiz "Il numero dei caratteri non corrisponde alla lunghezza del vettore...\n"

ERROR3: .asciiz "Il valore inserito supera la posizione della stringa...Riprova\n"

FINE: .asciiz "LA PROVA è FINITA!\nLa prova sull'esempio è la seguente..."

SCAMBIO: .asciiz "Lo scambio avviene sulla stringa d'esempio..."

SCELTA1: .asciiz " "


.text
.globl main


main:

             bnez $a0, RIGACOMANDO                          # Controllo se l'inserimento è avvenuto tramite riga di comando

DECISIONE:

             la $a0, SCELTA                                 # Inserimento stringa da console
             li $v0, 4
             syscall
             
             la $a0, SCELTA1
             

             li $v0, 8                                      # Inserisco (s\n) $a0=indirizzo lettera inserita
             syscall


             lb $t0, 1($a0)                                 # Carichiamo la posizione successiva alla lettera inserita
             bne $t0, 10, ERROR_1                           # Controllo se si è inserito piu' di un carattere     
             li $t0, 0


             lb $t0, 0($a0)                                 # Caricamento della lettera

             beq $t0, 110, LOADING_ES                       # Se inserisci n ----> CARICO L'ESEMPIO e CHIUDO
             bne $t0, 115, ERROR_1                          # Se inserisci qualunque altro simbolo da S va in ERROR_1

                          
             la $a0, STRINGA_LUNG                           # Caricamento stringa "Inserisci lunghezza..."
             li $v0, 4
             syscall

             li $v0, 5                                      # Inserisco la lunghezza della stringa in $v0
             syscall

             ble $v0, $zero, ERROR_1                        # Controllo se il carattere inserito è un numero o è < 0

             move $a0, $v0                                  # Inserimento della lunghezza della stringa in $a0


             j INSERIMENTO


ERROR_1:                                       # Messaggio di errore ----> E' stato inserito un carattere diverso da s\n
                                               # oppure non ho inserito un numero da console
             la $a0, ERROR1
             li $v0, 4
             syscall

             j DECISIONE                       # Posso riprovare...




RIGACOMANDO:  
             
             beq $a0, 2, RIGACOMANDO2                       # Controllo se si è inserito due valori
             bgt $a0, 1, ERROR_1                            # Se vengono inseriti piu' di un valore viene caricato l'esempio                    
             
             lw $t0, 0($a1)                                 # Indirizzo del valore in $t0
             li $a0, 0
CONTA:

             lb $t1, 0($t0)                                 # Carico valore in $t1

             beq $t1, $zero, INSERIMENTO                    # Se il valore è uguale a 0 ---> Inserisco il valore dalla console


             slt $t2, $t1, 48                               # Controllo se il valore inserito è un numero >=1
             bne $t2, $zero, ERROR_1

             slt $t2, $t1, 58
             beq $t2, $zero, ERROR_1


             sub $t1, $t1, 48                               # Porto il valore in decimale
             mul $a0, $a0, 10                               # Moltiplico il registro moltiplicatore $t2x10
             add $a0, $a0, $t1                              # Sommo man mano il numero inserito da riga di comando
             addi $t0, $t0, 1                               # Vado avanti nella lettura del numero

             j CONTA

INSERIMENTO:

                                                            
             move $s0, $a0                                  # Salvo la lunghezza della Stringa in $s0
             move $t9, $s0                                  # Mantengo la lunghezza in $t9
             li $a0, 0

             la $a0, STRINGA_INS                            # Stampa stringa " Inserisci la stringa..."
             li $v0, 4
             syscall



             li $v0, 8
             syscall                                        # Indirizzo della stringa nella posizione iniziale in $a0

             move $s1, $a0                                  # Salvo l'indirizzo della posizione iniziale in $s1

             li $t0, 0
             li $t1, 0
             li $t2, 0

CONTATORE:                                                  # Conteggio caratteri inseriti 

             lb $t0, 0($a0)
             beq $t0, $zero, CONTROLLO
             addi $t1, $t1, 1
             addi $a0, $a0, 1
                
             j CONTATORE

CONTROLLO:
             addi $t1, $t1, -1                              # Controllo se la lunghezza è uguale al numero dei caratteri inseriti
             bne $t1, $s0, ERROR_2 


             j INIZIO

ERROR_2:                                                    # Messagio di errore sul contatore
             la $a0, ERROR2                                 # La lunghezza della stringa non è stata rispettata
             li $v0, 4                                      
             syscall 
                     
             

LOADING_ES:
             li $a0, 0
             li $s0, 0

             la $a0, FINE                                   # La prova è finita...
             li $v0, 4
             syscall

                        
             la $a0, STRINGA_ES
             li $v0, 4
             syscall
                                                            ########## VIENE CARICATO L'ESEMPIO ##########
             li $s0, 14                                     # Lunghezza della stringa_es
             move $s1, $a0                                  # Indirizzo alla posizione iniziale della stringa_es
             move $t9, $s0




INIZIO:            ################ LUNGHEZZA DELLA STRINGA IN $s0 + INDIRIZZO DELLA STRINGA IN $s1 #####################
             

                          

             add $s2, $s1, $s0                              # Indirizzo posizione finale della stringa
             addi $s2, $s2, -1
             
CICLO:
                         
             beq $s2, $s1, ESCI2                            # Si esce non appena la posizione finale coincide con la posizione iniziale
                                                            # ----> Vuol dire che è stato controllato tutto l'array
             
             li $t0, 2                                      # Useremo $t0 per dividere l'HEAP_SIZE                         
             li $t1, 0
             li $t2, 0
             
             div $s0, $t0                                   # Divido il vettore a meta' (n/2)
             mflo $t1                                       # Quoziente in $t1
             
RITORNA:

             beq $t1, $zero, ESCI1                          # Si esce non appena arrivo a controllare la radice
             

             add $t3, $t1, $s1                              # Carico posizione immediatamente precedente in $t3 
                                                            # Posizione che sara' presa in esame nel BUIL_HEAP
             addi $t3, $t3, -1
             move $a0, $t3                                  # Passo la posizione alla procedura BUILD_HEAP

             jal BUILD_HEAP



                        ######################################################
                        #####    BUILD_HEAP - BUILD_HEAP - BUILD_HEAP    #####                  
                        ######################################################
BUILD_HEAP:

                         

             lb $t4, 0($a0)                                 # Prendo il valore della posizione presa in esame (PADRE)

             mul $t5, $t1, 2                                # Calcolo 2n -----> (2*$t1)                 
             addi $t5, $t5, 1                               # Calcolo 2n+1
             add $t5, $t5, $s1                              # Indirizzo del figlio destro ($t5)

             addi $t5, $t5, -1

             
             bgt $t5, $s2, LASCIA                           # Il PADRE non ha il figlio destro

             lb $t6, 0($t5)                                 # Valore del figlio destro ($t5)

LASCIA:

             mul $t7, $t1, 2                                # Calcolo 2n -----> (2*$t1)
             
             add $t7, $t7, $s1                              # Indirizzo del figlio sinistro ($t6)
             addi $t7, $t7, -1


                                    
             lb $t8, 0($t7)                                 # Valore del figlio sinistro ($t6)



             slt $t2, $t4, $t8                              # Padre > Figli
             bne $t2, $zero, SCAMBIA

             slt $t2, $t4, $t6
             bne $t2, $zero, SCAMBIA


             j CONTROLLA_PADRE

SCAMBIA:

             slt $t2, $t8, $t6                              # Figlio destro < Figlio sinistro ---> $t2=1
             bne $t2, $zero, FIGLIOSINISTRO

             sb $t8, 0($a0)                                 # Scambio il figlio destro con il padre
             sb $t4, 0($t7)

             j CONTROLLA_PADRE

FIGLIOSINISTRO:

             sb $t6, 0($a0)                                 # Scambio il figlio sinistro con il padre
             sb $t4, 0($t5)


CONTROLLA_PADRE:                                            # Viene controllato il PADRE del valore della posizione attuale
             
             li $t3, 0

             lb $t3, 0($a0)                                 # Ricarico il valore della posizione attuale in $t3

             li $t4, 0
             li $t5, 0

             beq $t1, 1, ESCI                               # Se la posizione attuale è la radice ---> ESCO

             div $t1, $t0
             mflo $t4                                       # Quoziente in $t4
             
             add $t4, $t4, $s1                              # Indirizzo del padre in $t4
             addi $t4, $t4, -1
             lb $t5, 0($t4)                                 # Valore del padre in $t4

             slt $t2, $t5, $t3                              # PADRE < VALORE POSIZIONE ATTUALE
             bne $t2, $zero, SCAMBIA_1


             j ESCI

SCAMBIA_1:

             sb $t3, 0($t4)                                 # Scambia il valore della posizione attuale con il padre
             sb $t5, 0($a0)

             j BUILD_HEAP                                   # Viene ricontrollato il tutto nel caso ci sono stati dei cambiamenti

ESCI:

             addi $t1, $t1, -1                              # Diminuisco la posizione che andremo a prendere in considerazione
            
             li $t6, 0                                      # Valori da esaminare posti a zero
             li $t8, 0
             
             
             j RITORNA


                      ############################################################
                      #####    STAMPA STRINGA CON LA PROPRIETA' DELL'HEAP    #####
                      ############################################################
ESCI1:

             move $a0, $s1                                 # Carico in $a0 la prima posizione della stringa
             li $v0, 4
             syscall


             li $t3, 0
             li $t4, 0
             li $t5, 0

             lb $t3, 0($s2)                               # Carico il valore dell'ultima posizione
             lb $t4, 0($s1)                               # Carico il valore della prima posizione

             sb $t4, 0($s2)                               # Scambio i valori
             sb $t3, 0($s1)

             addi $s2, $s2, -1                            # Diminuisco l'HEAP_SIZE
             addi $s0, $s0, -1                            # Diminuisco la lunghezza del vettore

             j CICLO

ESCI2:

             
             move $a0, $s1                                # Stampo la stringa finale... posizione iniziale in $s1
             li $v0, 4                                    # LA STRINGA è ORDINATA IN ORDINE CRESCENTE
             syscall


                       ##################################################
                       #####    POSSIBILITA' SOSTITUZIONE VALORI    #####
                       ##################################################

RITENTA:
            la $a0, SCELTA2                               # Stampa stringa sostituzione valori
            li $v0, 4
            syscall

            la $a0, SCELTA1



            li $v0, 8                                      # Inserisco (s\n) $a0=indirizzo lettera inserita
            syscall


            lb $t0, 1($a0)                                 # Carico la lettera inserita in $t0
            bne $t0, 10, ERROR_3                           # Controllo se è stato inserito un carattere solo
            li $t0, 0


            lb $t0, 0($a0)

           

            beq $t0, 110, PRINT_STR                        # Se inserisci n ----> CHIUDO
            bne $t0, 115, ERROR_3                          # Se inserisci qualunque altro simbolo da S va in ERROR_3


            li $t0, 0
            li $t1, 0

            la $a0, SCELTA3                                # Inserimento valore da cambiare
            li $v0, 4
            syscall

            la $a0, SCELTA1                                # Indirizzo valore inserito

            li $v0, 8                                      # Inserimento un nuovo valore in $v0
            syscall

            
            lb $t0, 1($a0)                                 # Carico la lettera inserita in $t0
            bne $t0, 10, ERROR_3                           # Controllo se è stato inserito un carattere solo

            lb $t0, 0($a0)                                 # Salviamo il valore inserito in $t0

            beq $t0, 10, ERROR_3                           # Non è stato inserito alcun carattere

            
            
            la $a0, SCELTA4                                # Posizione in cui si vuole immettere il nuovo valore          
            li $v0, 4
            syscall


            la $a0, SCELTA1                                # Indirizzo della posizione

            li $v0, 5                                      # Inserimento posizione del vettore
            syscall

            move $t1, $v0                                  # Salvataggio dell'intero in $t1
             
            ble $t1, $zero, ERROR_3
            bgt $t1, $t9, ERROR_4                          # Salto se è > della lunghezza della stringa

            li $t2, 0
            add $t1, $t1, $s1                              # Calcoliamo l'indirizzo con il valore intero inserito
            addi $t1, $t1, -1

            sb $t0, 0($t1)                                 # Inseriamo nel vettore il nuovo valore
 
            move $a0, $s1                                  # Carichiamo la prima posizione

            li $v0, 4
            syscall
            
            li $t1, 0
            move $s0, $t9                                  # Rimetto in $s0 la lunghezza della stringa    
             
            j CONTATORE                                    # Torno al contatore



ERROR_3:                                       # Messaggio di errore ----> E' stato inserito un carattere diverso da s\n
                                               # oppure non ho inserito un numero da console
            la $a0, ERROR1
            li $v0, 4
            syscall

            j RITENTA
          
ERROR_4:
           
            la $a0, ERROR3                                 # La posizione inserita supera la lunghezza del vettore
            li $v0, 4
            syscall

            j RITENTA    
 

RIGACOMANDO2:


             la $a0, SCAMBIO
             li $v0, 4
             syscall


             li $a0, 0
             li $s0, 0
             li $t3, 0
             li $t4, 0
             li $t5, 1
             
                        
             la $a0, STRINGA_ES                            # Caricamento posizione iniziale della stringa_es             
             li $v0, 4
             syscall

             li $s0, 14                                    # Lunghezza della stringa_es
             move $s1, $a0                                 # Indirizzo alla posizione iniziale della stringa_es in $s1
             move $t9, $s0                                 # Risalviamo in $t9


             lw $t0, 0($a1)                                # Indirizzo dei valori

             lb $t1, 0($t0)                                # Valore da sostituire in $t1

             addi $t0, $t0, 1                              # Controllo sull'inserimento di un solo valore
             lb $t2, 0($t0)

             bne $t2, $zero, ERROR_1                

             addi $t0, $t0, -1

             addi $t0, $t0, -2                             # Torno indietro nella posizioni
             
             lb $t2, 0($t0)                                # Valore intero della posizione del valore da sostituire in $t2

MAX_10:
             slt $t3, $t2, 48                              # Controllo se il secondo valore inserito è un numero
             bne $t3, $zero, ERROR_1

             slt $t3, $t2, 58
             beq $t3, $zero, ERROR_1

             sub $t2, $t2, 48                              # Calcolo il decimale

             mul $t2, $t2, $t5                             # Valore "completo" in $t4
             add $t4, $t4, $t2
             
             mul $t5, $t5, 10

              

             addi $t0, $t0, -1                             # Vado avanti nella memoria
             lb $t2, 0($t0)

             bne $t2, $zero, MAX_10                        # Controllo se il numero > 10

             bgt $t4, $s0, ERROR_5                         # Controllo se il valore inserito > lunghezza stringa

             
             add $t4, $t4, $s1                             # Calcolo l'indirizzo in cui devo sostituire il valore
             addi $t4, $t4, -1

             sb $t1, 0($t4)                                # Scambio il valore
                  
             j INIZIO

             
ERROR_5: 

            la $a0, ERROR3                                 # La posizione inserita supera la lunghezza del vettore
            li $v0, 4
            syscall

            j DECISIONE    
 
       

PRINT_STR:                                                 ########## STAMPA STRINGA FINALE ##########

            la $a0, SCELTA5
            li $v0, 4
            syscall

            move $a0, $s1
            li $v0, 4
            syscall                          












 