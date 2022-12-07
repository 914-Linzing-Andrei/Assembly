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
    text db "asdg142412 124 124 214   12412asaasd3mkate"
    len equ $-text
    rez times len db 0
    
    fileName db "out.txt",0
    accessMode db "w",0
    fileDescriptor dd -1
    
    format db "%s",0
    index db 0

; our code starts here
segment code use32 class=code
    start:
        int3
        
        mov esi,text
        mov edi,rez
        mov ecx,len
        
        cld
        push dword accessMode
        push dword fileName
        call [fopen]
        add esp, 4 * 2
        
        repeta:
            lodsb
            inc byte[index]
            test byte[index],0x01
            jnz odd_pos
            movsx eax,al
            push dword eax
            push dword format
            call [fprintf]
            add esp, 4 * 3
            
            jmp skip
            
            odd_pos:
                mov al,'X'
                movsx eax,al
                push dword eax
                push dword format
                call [fprintf]
                add esp, 4 * 3
        
        skip: loop repeta
        
        push dword [fileDescriptor]
        call [fclose]
        add esp,4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

