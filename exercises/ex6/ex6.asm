;Being given a string of words, obtain the string (of bytes) of the digits in base 10 of each word from this string.
;sir DW 12345, 20778, 4596
;1, 2, 3, 4, 5, 2, 0, 7, 7, 8, 4, 5, 9, 6.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir dw 12345, 20778, 4596
    l equ $-sir
    r times l db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        
        push 0xFFFF
        mov ecx, l/2
        mov edi, 0
        mov esi, sir
        mov ebx, 10
        xor edx, edx
        xor eax,eax
        
        repeta:
        
            cld
            lodsw
            cwd
            
            digits:
                xor edx,edx
                cmp ax, 0
                jne da
                jmp skip1
                
                da:
                    div bx
                    push edx
                    jmp digits
            skip1:
            
            mov eax,0
            
            repeta2:
                pop eax
                cmp al,0
                jge bun
                
                jmp afara
                
                bun:
                    cmp al,9
                    jbe bun2
                    
                    jmp afara
                    
                    bun2: 
                        mov [r + edi],al
                        inc edi
                        jmp repeta2
            afara:
            push 0xFFFF
        loop repeta
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
