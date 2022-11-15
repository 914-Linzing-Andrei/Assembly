;Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S.
;S: '+', '4', '2', 'a', '@', '3', '$', '*'
;D: '@','$','*'

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    s db '!', '4', '2', 'a', '@', '3', '$', '*'
    ls equ $-s                                          ;length of s
    d times ls db 0                                     ;we initialise d to be length of s because s may have all it's characters special ones
    
; our code starts here
segment code use32 class=code
    start:
        int3                                            ;manual breakpoint
        
        mov ecx, ls
        mov esi, 0
        mov edi, 0
        
        jecxz Ending
        repeat:
        
            mov al, [s + esi]
            
            cmp al, '!'
            je lista
            
            cmp al, '@'
            je lista
            
            cmp al, '#'
            je lista
            
            cmp al, '$'
            je lista
            
            cmp al, '%'
            je lista
            
            cmp al, '^'
            je lista
            
            cmp al, '&'
            je lista
            
            cmp al, '*'
            je lista
            
            
            
            inc esi
            dec ecx
            jmp repeat
            lista:
                mov [d + edi], al  
                inc edi
                inc esi
                
            
            
        loop repeat
        Ending:
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
