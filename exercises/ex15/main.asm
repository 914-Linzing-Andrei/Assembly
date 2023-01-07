bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf, reverse, lungime_sir              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    buffer resb 128
    format db "%s", 0
    nr db 0
    rez db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        
        
        xor edx,edx
        
        repeta:
            pushad
            push dword buffer
            push dword format
            call [scanf]
            
            add esp, 4 * 2
            popad
            cmp dword [buffer],0
            je afara
            mov edi,edx
            ;push dword 0
            push edi
            push dword buffer
            call lungime_sir
            call reverse
            
            pop edi
            
            push dword edi
            call [printf]
            add esp, 4 * 1
            
        loop repeta
        
        afara:
            
            
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
