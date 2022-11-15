;A byte string S is given. Obtain the string D by concatenating the elements found on the even positions of S and then the elements found on the odd positions of S.
;S: 1, 2, 3, 4, 5, 6, 7, 8
;D: 1, 3, 5, 7, 2, 4, 6, 8

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 2, 3, 4, 5, 6, 7, 8
    ls equ $-s
    d times ls db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        
        mov ecx, ls/2
        mov esi, 0
        mov edi, 0
        
        jecxz Ending
        
        repeta:
        
            mov al, [s + esi]
            mov [d + edi], al
            inc esi
            inc esi
            inc edi
            
        loop repeta
        
        Ending:
        
        mov ecx, ls/2
        mov esi, 1
        
        jecxz Ending2
        
        repeta2:
        
            mov al, [s + esi]
            mov [d + edi], al
            inc esi
            inc esi
            inc edi
            
        loop repeta2
        
        Ending2:
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
