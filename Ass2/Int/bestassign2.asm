;Test routine for GetPut.asm     test.asm 
;
;       Objective: find the sum of two numbers 
;       Input: Requests the number of values to be input by the user = n
;       Input: Requests n integers from the user.
;       Output: Outputs the total sum of numbers and also the current running sum.

%include "io.mac"

.DATA
prompt_msg1  db   "Please input the number of values to be summed : ",0
prompt_msg2  db   "Please input the number : ",0
output_msg  db   "The square is : ",0
output_msg2  db   "The final sum is : ",0
output_msg3  db   "The variance is : ",0
n1          dw      25159
msg_test db "The vaue inputted in n1",0
.UDATA 
number1   resd   1 
number2   resd   1

.CODE
      .STARTUP
      PutStr  prompt_msg1   ; request n
      GetInt SI             ; SI= n=number of values to be summed
      mov SP, 0
      mov BP, 0
      loop: 
                  cmp SI, SP        
                  jle endloop 
                  PutStr  prompt_msg2   ; request number 
                  GetInt DI            ; DI= number                    
                  add BP, DI  			;sum stored in BP
                  mov AX , DI  			; AX = value of number entered 
                  mul DI 				; now AX has square of DI

                  ;PutStr  output_msg   
                  ;PutInt  AX
                  add BX, AX 			; BX= sum of squared numbers
                  nwln
                  inc SP
                  jmp loop
      endloop:

      PutInt BP				;sum
      nwln
      PutInt BX				;square sum
      

      nwln 


      mov CX,AX   			; CX has sq of nth
      PutInt CX
      nwln
      mov AX,BP				; AX has sum
      PutInt AX
      nwln
      PutInt SI
      div SI				; AX is mean
      
      MUL AX
      MOV SP,AX
      PutInt SP
      nwln


      mov AX,BX						
      div SI				


      PutInt AX






      sub AX, SP 
      nwln  
      ;PutStr output_msg3
      PutInt AX

      nwln
done:
      .EXIT
