;A file name (defined in data segment) is given. Create a file with the given name, then read words from the keyboard until character '$' is read. Write only the words that contain at least one lowercase letter to file.
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fprintf, fclose, fopen             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    format db "%s",0
    format2 db "%s",10,0
    res dd 0
    buffer resb 128
    filename db "file.txt",0
    file_descriptor db -1
    typef db "w",0
    ok db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        
        push dword typef
        push dword filename
        call [fopen]
        add esp, 4 * 2
        
        cmp eax,0
        je the_end
        mov [file_descriptor],eax
        repet:
        
            push dword buffer
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            cmp byte [buffer], '$'
            je cleanup
            
            
            ;mov byte [ok], 0
            mov esi, buffer
            
            check_char:
            
                cmp byte [esi], 00h
                je skip
                
                cmp byte [esi], '$'
                je cleanup
                
                cmp byte [esi], 'a'
                jl urmator
                
                cmp byte [esi], 'z'
                jg urmator
                
                ;mov byte[ok], 1
                jmp printare
                
                urmator:
                    inc esi
                    jmp check_char  
                    
            printare:
                    
                ;cmp byte[ok], 1
                ;jne cleanup
                
                pushad
                push dword buffer
                push dword format2
                push dword [file_descriptor]
                call [fprintf]
                add esp, 4 * 3  
                popad
            
        skip: jmp repet
        
        cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
        
        the_end:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
