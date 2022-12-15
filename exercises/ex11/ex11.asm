bits 32 ;  A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Transform all the lowercase letters from the given text in uppercase. Create a file with the given name and write the generated text to file.
global start
extern exit,fopen,fread,fwrite,fclose
import exit  msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import fclose msvcrt.dll
segment data use32 class=data
    namea db "a.txt",0
    file_descriptora dd -1
    typea db "r",0
    typeb db "w",0
    nameb db "b.txt",0
    len equ 100
    c db 0
    file_descriptorb dd -1
    element db 0
    number_of_read_characters db 0
    
segment code use32 class=code
start:
   int3
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
      
      cmp byte[c],97
      jae litera_mica
      
      push dword [file_descriptorb]
      push dword 1
      push dword 1
      push dword c
      call [fwrite]
      add esp,4 * 4
    
      cmp eax,0
      je cleanup
      jmp skip
      
      litera_mica:
        cmp byte[c],122
        jbe sigur_litera_mica
        
        push dword [file_descriptorb]
        push dword 1
        push dword 1
        push dword c
        call [fwrite]
        add esp,4 * 4
        
        cmp eax,0
        je cleanup
        jmp skip
        
        sigur_litera_mica:
            sub byte [c], 32
            
            push dword [file_descriptorb]
            push dword 1
            push dword 1
            push dword c
            call [fwrite]
            add esp,4 * 4
            
            cmp eax,0
            je cleanup
           
      skip:jmp repet
      
   cleanup:
    push dword [file_descriptora]
    call [fclose]
    add esp,4
    
    push dword [file_descriptorb]
    call [fclose]
    add esp,4
    
   the_end:
   
   push dword 0
   call [exit]
