# Assembly-CO
Part of Lab Course at IIT Mandi - CS201, Fall '15

# Contents
Sample Prog : Add of 2 inputs
Assgn-1 	: Sum of N inputs
Assgn-2		: Sum. Mean & Variance of N Inputs
		--Implemented as Int
		--Implemented as Float using a custom divsion macro
		Issues: Using Local labels in Macros

# Usage

$ nasm -f elf32 -g -F stabs test.asm -l testlist.asm \n
$ ld -m elf_i386 -o testexe test.io io.o

Important flags used:
-> ld 	: -s = strips all symbolic information

-> nasm	: -f = format
			   elf32 = executable & linkable format 32-bit architecture
		  -g = generates symbol required by debuggers for specific 		formats
		  -F = 
		stabs= symbol format for debugging