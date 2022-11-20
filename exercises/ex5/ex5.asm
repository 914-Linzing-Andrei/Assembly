;A word string s is given. Build the byte string d such that each element d[i] contains:
;- the count of zeros in the word s[i], if s[i] is a negative number
;- the count of ones in the word s[i], if s[i] is a positive number
;s: -22, 145, -48, 127
;1111111111101010, 10010001, 1111111111010000, 1111111
;d: 3, 3, 5, 7

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

extern exit
import exit msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dw -22, 145, -48, 127
    l equ $-s
    r times l db 0
    
; our code starts here
segment code use32 class=code
    start:
        int3
        
        mov ecx,l/2
        xor eax,eax
        xor ebx,ebx
        xor edx,edx
        mov esi,s
        mov edi,0
        
        repeta:
            cld
            lodsw
            
            push ax
                
            mov edx,ecx
            mov ecx,16
            mov ebx,0
            
            number_of_1_and_0:
                shr ax,01h
                jnc n0
                
                n1: inc bh
                jmp skip1
                
                n0: inc bl
                    
            skip1: loop number_of_1_and_0
            
            mov ecx,edx
            
            cmp word[esp],0
            jl negat
            
            mov [r + edi], bh
            inc edi
            
            jmp skip
            
            negat:
                mov [r + edi], bl
                inc edi
                
        skip: loop repeta
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
