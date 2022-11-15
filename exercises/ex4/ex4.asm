;Two byte strings S1 and S2 of the same length are given. Obtain the string D where each element contains the minimum of the corresponding elements from S1 and S2.
;S1: 1, 3, 6, 2, 3, 7
;S2: 6, 3, 8, 1, 2, 5
;D: 1, 3, 6, 1, 2, 5

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    s1 db 1, 3, 6, 2, 3, 7
    l equ $-s1
    s2 db 6, 3, 8, 1, 2, 5
    d times l db 0
    
; our code starts here
segment code use32 class=code
    start:
        int3
        mov edi, 0
        mov esi, 0
        mov ecx, l
        
        jecxz Ending
        
        repeat:
            
            mov al, [s1 + esi]
            mov ah, [s2 + esi]
            
            cmp al, ah
            jbe ceva
            
            mov [d + edi], ah
            inc edi
            inc esi
            
            dec ecx
            jecxz Ending
            jmp repeat
            
            ceva:
                mov [d + edi], al
                inc esi
                inc edi
        
        loop repeat
        Ending:
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
