# written by Akthm Daas
.data
    bool:   .space 4   # Array to store the secret number
    guess:  .space 4   # Array to store the user's guess
    prompt1: .asciiz "enter 1st number: "
    prompt2: .asciiz "\nenter 2nd number: "
    prompt3: .asciiz "\nenter 3rd number: "
    prompt4: .asciiz "enter 3 digit guess: "
    promptb: .asciiz " b"
    promptn: .asciiz " n"
    promptp: .asciiz " p"
    promptpp: .asciiz " pp"
    promptppp: .asciiz " ppp"
    promptbp: .asciiz " bp"
    promptbpp: .asciiz " bpp"
    promptbb: .asciiz " bb"
    promptwin: .asciiz "bbb\ngame won!\nGoodbye!"
    promptreplay: .asciiz "\nwanna play again? (y to replay)\n"
    
    errorm: .asciiz "\nnumbers are invalid try again!\n"
    newline: .asciiz "\n"

.text
.globl main 

	main:
	la $a0, bool
	jal get_number
	
	repeat:
	la $a0, guess
	la $a1, bool
	jal get_guess
	beq $v0, -1, game_done
	
	play_again: 
	li $v0, 4         # syscall: print_str
        la $a0, promptreplay    # load address of prompt string
        syscall
        
        li $v0, 12       # read char
        syscall
        move $t1, $v0
        li $v0, 4         # syscall: print_str
        la $a0, newline    # load address of prompt string
        syscall
        
        beq $t1, 121, repeat # ascii for small y 
        j exit
	
	game_done:
	li $v0, 4         # syscall: print_str
        la $a0, promptwin    # load address of prompt string
        syscall
        

	exit:  # terminate program 
	li $v0, 10
	syscall
	
	
	get_guess: # a0 -> guesses address | a1 -> bool address
		move $t0, $a0 # storing arguments if temp variables
		move $t1, $a1 
		
		li $v0, 4         # syscall: print_str
        	la $a0, prompt4    # load address of prompt string
        	syscall
        	
        	move $a0, $t0
		li $a1, 4
		li $v0, 8
		syscall
		
		li $v0, 4         # syscall: print_str
        	la $a0, newline    # load address of prompt string
        	syscall
		
		
		move $a0, $t0
		move $a1, $t1
		compare: # argumnets a0 -> guess address | a1 -> bool address
		# saving to temps for comarison
		#original 1 - 2 - 3
		lb $t1, 0($a1)
		lb $t2, 1($a1)
		lb $t3, 2($a1)
		# new guess 
		lb $t4, 0($a0)
		lb $t5, 1($a0)
		lb $t6, 2($a0)
		
		# comparing bols 
		beq $t1, $t4, bol1 # 1 is bol
		beq $t2, $t5, bol2 # 2 is bol
		beq $t3, $t6, bolis3 # 3 is bol
		j nobol # if no bols where found 
		
		bol1: # 1 is bol
		beq $t2, $t5, bol2a1
		beq $t3, $t6, bolis1a3
		j bolis1
		
		bol2a1: # 1 and 2 are bol
		beq $t3, $t6, allbols
		j bolis1a2
		
		bol2: # 2 is the first bol
		beq $t3, $t6, bolis2a3
		j bolis2
		
		
		allbols: # all bols
		li $v0, -1
		jr $ra
		
		
		bolis1: # only 1 is bol
		beq $t2, $t6, b1p1
		beq $t3, $t5, b1p2
		li $v0, 4         # syscall: print_str
        	la $a0, promptb    # load address of prompt string
        	syscall
        	jr $ra
		
			b1p1:
			beq $t3, $t5, b1p1a2
			li $v0, 4         # syscall: print_str
        		la $a0, promptbp    # load address of prompt string
        		syscall
        		jr $ra
        		
        		b1p1a2:
			li $v0, 4         # syscall: print_str
        		la $a0, promptbpp    # load address of prompt string
        		syscall
        		jr $ra
        		
        		b1p2:
        		li $v0, 4         # syscall: print_str
        		la $a0, promptbp    # load address of prompt string
        		syscall
        		jr $ra
			
		
		bolis3: # only 3 is bol
		beq $t1, $t5, b3p1
		beq $t2, $t4, b3p2
		li $v0, 4         # syscall: print_str
        	la $a0, promptb    # load address of prompt string
        	syscall
        	jr $ra
		
			b3p1:
			beq $t2, $t4, b3p1a2
			li $v0, 4         # syscall: print_str
        		la $a0, promptbp    # load address of prompt string
        		syscall
        		jr $ra
        		
        		b3p1a2:
			li $v0, 4         # syscall: print_str
        		la $a0, promptbpp    # load address of prompt string
        		syscall
        		jr $ra
        		
        		b3p2:
        		li $v0, 4         # syscall: print_str
        		la $a0, promptbp    # load address of prompt string
        		syscall
        		jr $ra
		
		bolis2: # only 2 is bol 
		
		beq $t1, $t6, b2p1
		beq $t3, $t4, b2p2
		li $v0, 4         # syscall: print_str
        	la $a0, promptb    # load address of prompt string
        	syscall
        	jr $ra
		
			b2p1:
			beq $t3, $t4, b2p1a2
			li $v0, 4         # syscall: print_str
        		la $a0, promptbp    # load address of prompt string
        		syscall
        		jr $ra
        		
        		b2p1a2:
			li $v0, 4         # syscall: print_str
        		la $a0, promptbpp    # load address of prompt string
        		syscall
        		jr $ra
        		
        		b2p2:
        		li $v0, 4         # syscall: print_str
        		la $a0, promptbp    # load address of prompt string
        		syscall
        		jr $ra
		
		
		nobol: # no bols ** warning a really long one **
		# testing p1 
		beq $t1, $t5, nobp11
		beq $t1, $t6, nobp12
		#2
		beq $t2, $t4, nobp21
		beq $t2, $t6, nobp22
		#3
		beq $t3, $t4, nobp31
		beq $t3, $t5, nobp32
		li $v0, 4         
        	la $a0, promptn    # nothing found
        	syscall
        	jr $ra
        	 
        	 
        	# testing for 2 p 
        	nobp11:
        	#2
        	beq $t2, $t6, nobp1121
        	beq $t2, $t4, nobpp
		#3
		beq $t3, $t4, nobpp
		j nobp
		
		nobp12: 
		#3
		beq $t3, $t5, nobp1221
		beq $t3, $t4, nobpp
		#2
		beq $t2, $t4, nobpp
		j nobp
		
		nobp21:
		# testing p1 
		beq $t1, $t6, nobp2111
		beq $t1, $t5, nobpp
		#3
		beq $t3, $t5, nobpp
		j nobp
		
		nobp22:
		#3
		beq $t3, $t4, nobp2211
		beq $t3, $t5, nobpp
		# testing p1 
		beq $t1, $t5, nobpp
		j nobp
		
		nobp31:
		# testing p1 
		beq $t1, $t5, nobp3111
		beq $t1, $t6, nobpp
		#2
		beq $t2, $t6, nobpp
		j nobp
		
		nobp32:
		#2
		beq $t2, $t4, nobp3211
		beq $t2, $t6, nobpp
		# testing p1 
		beq $t1, $t6, nobpp
		j nobp
		
		
		## testing for 3 p 
		nobp1121:
		beq $t3, $t4, nobppp
		j nobpp
		
		nobp1221:
		beq $t2, $t4, nobppp
		j nobpp
		
		nobp2111:
		beq $t3, $t5, nobppp
		j nobpp
		
		nobp2211:
		beq $t1, $t5, nobppp
		j nobpp
		
		nobp3111:
		beq $t2, $t6, nobppp
		j nobpp
		
		nobp3211:
		beq $t1, $t6, nobppp
		j nobpp
		
		# printing the last values
		nobp:
		li $v0, 4         # syscall: print_str
        	la $a0, promptp    # load address of prompt string
        	syscall
        	jr $ra
        	
		nobpp:
		li $v0, 4         # syscall: print_str
        	la $a0, promptpp    # load address of prompt string
        	syscall
        	jr $ra
        	
		nobppp:
		li $v0, 4         # syscall: print_str
        	la $a0, promptppp    # load address of prompt string
        	syscall
        	jr $ra
        	
		bolis1a2: # 1 and 2 are bol 
		
		bolis1a3: # 1 and 3 are bol
		
		bolis2a3: # 2 and 3 are bol 
		
		li $v0, 4         # syscall: print_str
        	la $a0, promptbb    # load address of prompt string
        	syscall
        	jr $ra
		
		
	
	
	get_number: # parameter a0 -> address of space to save input
		move $t4, $a0 # store the address given
		li $v0, 4         # syscall: print_str
        	la $a0, prompt1    # load address of prompt string
        	syscall
        	
		li $v0, 12         # syscall: read char 
        	syscall
		move $t0, $v0
		li $v0, 4         # syscall: print_str
        	la $a0, prompt2    # load address of prompt string
        	syscall
        	
		li $v0, 12       
        	syscall
		move $t1, $v0
		
		li $v0, 4         
        	la $a0, prompt3    # load address of prompt string
        	syscall
        	
		li $v0, 12         
        	syscall
		move $t2, $v0
		
	# test_numbers
		blt $t0, 48, error # test if less than 0 
		blt $t1, 48, error
		blt $t2, 48, error
		bgt $t0, 57, error # test if greater than 9 
		bgt $t1, 57, error
		bgt $t2, 57, error
		beq $t0, $t1, error # testing equality
		beq $t1, $t2, error
		beq $t0, $t2, error
	# save 
		sb $t0, 0($t4)
		addi $t4, $t4, 1
		sb $t1, 0($t4)
		addi $t4, $t4, 1
		sb $t2, 0($t4)
		addi $t4, $t4, 1
		sb $zero, 0($t4) # null terminator for printing purposes
		
		li $v0, 4         
        	la $a0, newline    # load address of prompt string
        	syscall
		
		jr $ra # returning to main without return value 
		
		
	error: # takes no arguments loops back to get_number
		li $v0, 4         # syscall: print_str
        	la $a0, errorm    # load address of prompt string
        	syscall
        	j get_number
		
