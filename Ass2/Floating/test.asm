;Test routine for GetPut.asm     test.asm 
;
;       Objective: find the sum,mean & variacne of n numbers 
;       Input: Requests n  integers  from the user.
;       Output: Output the sum, mean & variance of inputted number.
;       Problem: Using Labels in macros
%include "io.mac"
;;;-----------------------------------------------------------------------------
;extern printf

;%macro  PutFloat  1
;        push    EAX
;        mov     EAX,%1
;        call    printf
;        pop     EAX
;%endmacro
;

%macro customFloatDiv 2
      mov AX,%1
      mov CX,%2
characteristic:
         
      mov DX,0
      div CX                        ; CX is the divsior, DX:AX - Dividend
      PutInt  AX                    ; Quotient is stored in AX & Remainder in DX
      PutCh   '.'
      
      mov EBX,3                     ; Hard-coded precision of 3
      mov [precision],EBX
;     PutLInt EBX
      cmp EBX,0
      jle end_decimal
;     jmp end_decimal
decimal:
      mov [precision], EBX
      mov AX,DX
      mov BX,10
      mul BX
      div CX
      PutInt  AX

      mov EBX,[precision]
      dec EBX
      jnz decimal         
end_decimal:
      nwln
%endmacro


;;; Problem: Label in macro
; -------------hence, a repeat macro with diff name
%macro customFloatDiv2 2
      mov AX,%1
      mov CX,%2
characteristic2:
         
      mov DX,0
      div CX                        ; CX is the divsior, DX:AX - Dividend
      PutInt  AX                    ; Quotient is stored in AX & Remainder in DX
      PutCh   '.'
      
      mov EBX,3                     ; Hard-coded precision of 3
      mov [precision],EBX
;     PutLInt EBX
      cmp EBX,0
      jle end_decimal2
;     jmp end_decimal2
decimal2:
      mov [precision], EBX
      mov AX,DX
      mov BX,10
      mul BX
      div CX
      PutInt  AX

      mov EBX,[precision]
      dec EBX
      jnz decimal2         
end_decimal2:
      nwln
%endmacro
;--------------------------------------------------------------------------------------


;----------------------------------------------------------------------------------------
.DATA
prompt_msg1 db    "Please input the number of values to be summed : ",0
prompt_msg2 db    "Please input the number : ",0
output_msg  db    "The running/current sum is : ",0
output_msg2 db    "The final sum is : ",0
mean_msg    db    "The mean of the numbers is : ",0
variance_msg    db    "The variance of the numbers is : ",0
;sum2        dq    16
.UDATA 
sum         resq    1
sq_of_sum   resq    1
avg         resq    1
variance    resq    1
count       resb    1
precision   resb    1

.CODE
      .STARTUP
      PutStr  prompt_msg1   ; request n
      GetInt CX             ; CX= n=number of values to be summed
      mov BX, 0
      mov BP, 0
      mov SP, 2
      mov AX, 0
      loop: 
                  cmp CX, BX
                   jle endloop
                  PutStr  prompt_msg2   ; request number 
                  GetInt DX             ; DX= number

                  add [sum], DX            ; SP has sum of Nos            
                  ;mov [sum],AX
                  PutStr  output_msg   
                  PutInt [sum] 
                  mov AX,DX
                  mul DX                ; AX now has sq of current no
                  add BP,AX             ; BP has sum of sqs
                  mov DI,BP
                  sub DI,[sum]             ; DI has Diff of Sum of Sq & Sum      
                  inc BX
                  nwln
                  jmp loop
      endloop:  
      PutStr output_msg2
      PutInt [sum]                
      nwln

;Trying FPU registers
      mov [count],CX                            ;Store n
;      PutInt [sum]
      fild qword[sum]                            ;Load Sum in FPU Data Register ST0
      fdiv qword[count]
      fst qword[avg]
; End FPU      

;Working Important Part
      mov AX,[sum]
      mov DI,AX
      mul DI                           ;AX has (sum)^2
      mov [sq_of_sum],AX
      mov AX,BP
      mul CX                           ;AX has n*(sum)^2
      sub AX,[sq_of_sum]               
      mov DI,AX                        ;DI has Var*n^2
      PutStr  mean_msg
      customFloatDiv [sum],CX
      nwln

      mov AX,CX
      mul CX                              ; AX has n^2
      mov CX,AX
      PutStr variance_msg
      ;PutInt DI
      customFloatDiv DI,CX
      nwln
;End of Important part

;     PutFloat [avg]
;      PutStr [avg]
;trying to Output the float number entered
      mov eax, 4
      mov ebx, 1
      mov ecx, [avg]
      ;PutInt [ecx]
      mov edx, 5
      int 80h  

done:
      .EXIT