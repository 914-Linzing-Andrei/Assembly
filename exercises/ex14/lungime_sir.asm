global lungime_sir

segment data use32 class = data
    lungimee db 0

segment code use32 class = code
    lungime_sir:
        mov esi, [esp + 4]
        
        repeta:
            cmp byte [esi], 00h
            je afara
            
            inc byte [lungimee]
            inc esi
            jmp repeta
            
        afara:
        mov edx, dword [lungimee]
        ret
