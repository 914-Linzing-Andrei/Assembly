global concatenation

segment data use32 class = data
    rez resb 400

segment code use32 class = code
    concatenation:
        mov esi, [esp + 4]
        mov ebx, rez
        ;push esi
        ;mov edi, [esp + 4 * 2]
        mov ecx,edx
        
        repeta:
            ;lodsb
            cmp byte [esi],00h
            je afara
            
            mov al, byte [esi]
            mov [rez + edi],al
            ;stosb
            inc edi
            inc esi
        
        loop repeta
        afara:
        ret
