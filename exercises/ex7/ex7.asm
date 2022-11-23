;Being given two strings of bytes, compute all positions where the second string appears as a substring in the first string.
;a db 1,2,3,4,2,1,2,4,5,1,2
;b db 1,2
;r db 0,5,9

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1,2,1,2,2,1,2,4,5,1,2
    la equ $-a
    b db 1,2
    lb equ $-b
    r times la db 0
    
; our code starts here
segment code use32 class=code
    start:
        int3
        mov esi,a
        mov ecx,la
        xor eax,eax
        
        push 0xFFFF                ;pun in stiva 0xFFFF ca sa stiu ca elementul din stiva mea (cel mai de jos element e FFFF)
        repeta:
            xor edx,edx            ;edx mereu in loop se initializeaza cu 0
            mov edi,b              
            cld
            
            cmp esi,edi
            jge afara
            cmpsb
            je bun
            
            jmp skip
            
            bun:
                inc dl
                label1:
                    cmpsb
                    je bun2
                    
                    jmp label2
                    
                    bun2:
                        inc dl
                        jmp label1
            label2:
                cmp dl,lb
                je perfect
                
                jmp skip
                
                perfect:
                    mov ebx,esi
                    sub ebx,lb
                    dec ebx
                    inc eax
                    push ebx
                    dec esi
            dec esi
        skip: loop repeta
        afara:
        ;--------------------------------------------------------------------------------------------------------------------------------------
        ;pun in [r + edi] pozitiile pe care gasesc substringul b in a (pozitiile au fost initial puse in stiva si le 'scot' de acolo)
        ;--------------------------------------------------------------------------------------------------------------------------------------
        mov ecx,eax
        dec ecx
        mov edi,0
        label3:
            cmp word[esp + 4 * edi],0xFFFF
            jne bun3
        
            jmp pa
            
            bun3:
                mov eax,[esp + 4 * ecx]
                mov [r + edi],al
                dec ecx
                inc edi
                jmp label3
            pa:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
