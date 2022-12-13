;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, digits and spaces.
;Replace all the digits on odd positions with the character ‘X’. Create the file with the given name and write the generated text to file.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, fread             
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll    
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text db "asdg142412 124 124"
    len equ $-text
    rez times len db 0
    
    fileName db "out.txt",0
    accessMode db "w",0
    fileDescriptor dd -1
    
    tmp db 0, 0
    format db "%s",0
    index db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        push dword accessMode
        push dword fileName
        call [fopen]
        add esp, 4 * 2
         
        mov dword [fileDescriptor],eax
        cmp dword [fileDescriptor],0
        je final
        mov esi,text
        mov ecx,len
        mov edi,rez
        cld
        repeta:
            lodsb
            inc byte[index]
            test byte[index],0x01
            jnz odd_pos
            pushad
            mov [tmp], al 
            
            push tmp
            ;movsx eax,al
            ;push eax
            push dword format
            push dword [fileDescriptor]
            
            call [fprintf]
            
            add esp, 4 * 3
            popad
            
            jmp skip
            
            odd_pos:
                pushad
                mov al,'X'
                mov [tmp], al 
                push tmp
                ;movsx eax,al
                ;push eax
                push dword format
                push dword [fileDescriptor]
                
                call [fprintf]
                
                add esp, 4 * 3
                popad
        
        skip: loop repeta
        
        push dword [fileDescriptor]
        call [fclose]
        add esp,4 * 1
        
        final:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
