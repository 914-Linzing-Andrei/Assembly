;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the negative elements of A.
;A: 2, 1, -3, 3, -4, 2, 6
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, -3, -4

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2, 1, -3, 3, -4, 2, 6
    b db 4, 5, 7, 6, 2, 1
    l equ $-a
    l2 equ $-a-b
    r times l db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        
        mov ecx, l2
        mov esi, l2
        mov edi, 0
        
        jecxz Ending
        
        repeat:
            
            mov al, [b + esi - 1]
            mov [r + edi], al
            dec esi
            inc edi
            
        loop repeat

        Ending:
        
        mov ecx, l-l2
        mov esi, 0
        
        jecxz Ending2
        
        repeat2:
            
            mov al, [a + esi]
            
            cmp al, 0
            jl cond
            
            inc esi
            dec ecx
            
            cmp ecx, 0
            jl cond2
            
            jmp repeat2
            
            cond2:
                jmp Ending2
                
            cond:
                mov [r + edi], al
                inc edi
                inc esi
            
        loop repeat2

        Ending2:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
