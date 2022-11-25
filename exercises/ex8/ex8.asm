;Two strings of bytes A and B are given. Parse the shortest string of those two and build a third string C as follows:
;up to the lenght of the shortest string C contains the largest element of the same rank from the two strings
;then, up to the length of the longest string C will be filled with 1 and 0, alternatively.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 12,200,30,60,50
    la equ $-a
    b db 100,199,23,201,150,160
    lb equ $-b
    c times la db 0
    
; our code starts here
segment code use32 class=code
    start:
        int3
        cld
        mov bl,lb
        mov bh,la
        
        cmp bh,bl
        jg a_mai_lung
        
        b_mai_lung:
            mov ecx,la
            mov edx,lb
            mov ebx,b
            mov esi,a
            
            
            push ecx
            push edx
            push ebx
            jmp afara
        
        a_mai_lung:
            mov ecx,lb
            mov edx,la
            mov ebx,a
            mov esi,b
            
            
            push ecx
            push edx
            push ebx
            
        afara:
        
        mov edx,esi
        mov edi,c
        mov ebx,edi
        
        rep movsb
        mov ecx,[esp + 4 * 2]
        mov esi,[esp]
        mov edi,ebx
        repeta:
            mov al,[esi]
            mov bl,[edi]
            cmp al,bl
            jb altfel
            
            stosb
            inc esi
            jmp skip
            altfel:
            mov al,bl
            stosb
            inc esi
        skip: loop repeta
        
        mov ecx,[esp + 4]
        sub ecx,[esp + 4 * 2]
         repeta2:
        
            mov al,1
            stosb
            dec ecx
            cmp ecx,0
            jle afara2
            mov al,00h
            stosb
            cmp ecx,0
            jle afara2
            
        
        loop repeta2
        afara2:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
