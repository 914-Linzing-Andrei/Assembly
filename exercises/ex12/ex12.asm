bits 32
;A file name and a text (which can contain any type of character) are given in data segment. Calculate the sum of digits in the text. Create a file with the given name and write the result to file.
global start
extern exit,fopen,fread,fwrite,fclose, fprintf
import exit  msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
segment data use32 class=data
    namea db "in.txt",0
    file_descriptora dd -1
    typea db "r",0
    typeb db "w",0
    nameb db "ceva.txt",0
    len equ 100
    c db 0
    file_descriptorb dd -1
    element db 0
    number_of_read_characters db 0
    rez dd 0
    format db "%d",0
    
segment code use32 class=code
start:
   int3
   xor ebx,ebx
   push dword typea
   push dword namea
   call[fopen]
   add esp,4*2
   
   cmp eax,0
   je the_end
   mov [file_descriptora],eax
   
   push dword typeb
   push dword nameb
   call [fopen]
   add esp, 4 * 2
   
   cmp eax,0
   je the_end
   mov [file_descriptorb],eax
   
   repet:
      push dword [file_descriptora]
      push dword 1
      push dword 1
      push dword c
      call [fread]
      add esp,4*4
      cmp eax,0
      je cleanup
      
      cmp byte[c],48    
      jae cifra
      
      jmp skip
      
      cifra:
        cmp byte[c],57
        jbe sigur_cifra
        
        jmp skip
        
        sigur_cifra:
            mov bl, byte[c]
            movsx ebx,bl
            sub ebx,48
            add dword[rez],ebx
            
           
      skip:jmp repet
    
    
   cleanup:
    pushad
    mov ebx,[rez]
    push ebx
    push dword format
    push dword [file_descriptorb]
    call [fprintf]
    add esp,4 *3 
    popad
    
    push dword [file_descriptora]
    call [fclose]
    add esp,4
    
    push dword [file_descriptorb]
    call [fclose]
    add esp,4
    
   the_end:
   
   push dword 0
   call [exit]
